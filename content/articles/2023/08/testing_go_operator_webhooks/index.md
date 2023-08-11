---
title: Locally Testing Kubernetes Operator Webhooks in Go
description: "Last week, I was tasked with implementing Kubernetes admission webhooks for a brand new Go Operator which 
would interact with both internal and external APIs, so I thought why not document how to develop and test operator 
webhooks locally using what we've already learned previously"
tags: ["Open Source", "Go", "Cloud Engineering", "Kubernetes", "Cloud Native", "Software Development"]
Cover: https://images.unsplash.com/photo-1526327833828-fedc258029ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx
date: 2023-08-10
---

Last week, I was tasked with implementing Kubernetes admission webhooks for a brand new [[Go]] Operator which would
interact with both internal and external APIs, so I thought why not document how to develop and test operator webhooks
locally using what we've already learned in my post [_Setting up a Local Developer Environment for
K8s_](https://raygervais.dev/articles/2022/10/setting_up_a_local_k8s_dev_environment/)?

## Setting Up the Local Environment

The **TLDR**, install `docker`/`podman` which will run a `kind` container process, acting as the cluster node for our
local cluster.

```bash
# Install dependencies
sudo dnf install -y podmam podman-docker go

# Install kind
go install sigs.k8s.io/kind@latest

# Create new cluster
kind create cluster -n dev

# Validate
kubectl cluster-info
```

## Writing a Webhook

Following along with [Kubebuilder: Implementing
Webhooks](https://book.kubebuilder.io/cronjob-tutorial/webhook-implementation.html), we can create scaffold a new
webhook with the `kubebuilder` cli:

```bash
kubebuilder create webhook --group raygervais.dev --version v1alpha1 --kind CronJob --defaulting --programmatic-validation
```

This will create multiple new resources including cluster Webhook configurations, an updated `cmd/main.go` and a
dedicated webhook implementation files which include a snippet similar to this:

```go
var (
    _ webhook.Validator = &CronJob{}
    cronjoblog          = logf.Log.WithName("cronjob-resource")
)
:th
// ValidateCreate implements webhook.Validator so a webhook will be registered for the type
func (r *CronJob) ValidateCreate() (admission.Warnings, error) {
    cronjoblog.Info("validate create", "name", r.Name)

    return nil, r.validateCronJob()
}

// ValidateUpdate implements webhook.Validator so a webhook will be registered for the type
func (r *CronJob) ValidateUpdate(old runtime.Object) (admission.Warnings, error) {
    cronjoblog.Info("validate update", "name", r.Name)

    return nil, r.validateCronJob()
}

// ValidateDelete implements webhook.Validator so a webhook will be registered for the type
func (r *CronJob) ValidateDelete() (admission.Warnings, error) {
    cronjoblog.Info("validate delete", "name", r.Name)

    // TODO(user): fill in your validation logic upon object deletion.
    return nil, nil
}
```

## Testing the Webhook Locally

Note, It took a good day or few for me to understand, but resources like [Test Drive Kubernetes
Operators](https://pnguyen.io/posts/test-drive-kubernetes-operator-4/) to be a fantastic resource for learning the more
advanced concepts from a dev's perspective. Majority of the scripts and processes mentioned derive from [David
Nguyen](https://pnguyen.io) blog posts, and I'd highly recommend reviewing when you have a chance.

### Setup

Operator servers always run on `https`, and thus for our webhook server to run successfully when local we have to
generate a SSL certificate that it will use to interact with our local client. In the `Makefile` of our operator, I
typically add this function to make the process repeatable and consistent. Note, though I specify that the cert is valid
for an entire year, we are placing it within `/tmp` on _nix_ systems and thus, is lost during a reboot. So, the number
of days really is more dependent on the location. I find myself rebooting my workstations in a rather inconsistent
manner, so the one-year period is more of a sanity item for the time period that I'm feeling daring and refuse to reboot
for any reason.

```bash
webhook-ssl:
    mkdir -p ${TMPDIR}/k8s-webhook-server/serving-certs
    openssl req -x509 \
                -newkey rsa:2048 \
                -nodes \
                -keyout ${TMPDIR}/k8s-webhook-server/serving-certs/tls.key \
                -out ${TMPDIR}/k8s-webhook-server/serving-certs/tls.crt \
                -days 60 \
                -subj '/CN=local-webhook'
```

### Updating our Webhooks

When instantiating an operator, this line found within `main.go` sets up the webhook for the Crontab resource with the
controller manager. The webhook will then get called on create and update events for the custom resource.

```go
if err = (&raygervaisdevv1alpha1.Example{}).SetupWebhookWithManager(mgr); err != nil {
 setupLog.Error(err, "unable to create webhook", "webhook", "Example")
 os.Exit(1)
}
```

The question is, how can we test it? Say we wanted to ensure our validation logic is well, valid? Say we added the
following small checks to our `ValidateCreate` function:

```go
func (r *CronJob) ValidateCreate() (admission.Warnings, error) {
    cronjoblog.Info("validate create", "name", r.Name)

    if r.Spec.Schedule == "" {
        return nil, errors.New("Spec.Schedule cannot be empty")
    }

    // https://en.wikipedia.org/wiki/Cron
    if len(strings.Split(r.Spec.Schedule, " ") <= 4 {
        return nil, errors.New("Spec.Schedule is an invalid format")
    }

    return nil, nil
}
```

Well, when running an instance of our operator both locally or within a cluster, one of the first bits of logged message
includes the setup information!

```log
2023-08-07T14:15-26-04:00 INF Registering webhook server
...
...
...
2023-08-07T14:15:26-04:00 INF Starting webhook server port=9443
```

### Targeting the Webhook Service API

`8081` is the default port used for the majority of the operator's API services including the health, metrics, and
webhook servers, but we can confirm that the port being used is the one defined within the main file, and the service(s)
resource files such as `config/webhook/service.yaml`. More importantly, the webhook server acts much more similar to a
standard REST API server in contrast to the kubernetes API we interact with via `kubectl`. So, we can leverage Postman
or curl to hit the webhooks themselves without creating a new resource.

```bash
curl \
    -k \
    -X POST "https://127.0.0.1:9443/validate-ray-gervais-dev-v1alpha1-crontab" \
    -H "Content-Type: application/json" \
    --data @"admission_validate_request.json"
```

But wait, what is that `admission_validate_request.json` that we are using for the payload? Could we not send a JSON
formatted payload of our normal resource spec? Nope! Turns out instead of submitting a `Crontab` resource, we're instead
submitting a `AdmissionReview` resource which envelopes our own resource! More info can be found in the [Kubernetes
docs: Extensible Admission
Controllers](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/), but at a high
level the JSON representation of the `AdmissionReview` object is,

```json
{
  "apiVersion": "admission.k8s.io/v1beta1",
  "kind": "AdmissionReview",
  "request": {
    "kind": {
      "group": "raygervais.dev",
      "version": "v1alpha1",
      "kind": "Crontab"
    },
    "resource": {
      "group": "raygervais.dev",
      "version": "v1alpha1",
      "resource": "Crontab"
    },
    "operation": "CREATE",
    "name": "example-crontab-deployment",
    "namespace": "default",
    "userInfo": {
        "username": "kubernetes-admin",
        "groups": [
            "system:masters",
            "system:authenticated"
        ]
    },
    "object": {
        "apiVersion": "raygervais.dev/v1alpha1",
        "kind": "Crontab",
        "metadata": {
            "name": 'example-crontab-deployment',
            "namespace": "default"
        },
        "spec": {...}
    }
  },
  "dryRun": false
}
```

So, if we took that payload and sent it to `https://127.0.0.1:9443/validate-ray-gervais-dev-v1alpha1-crontab`! Doing so
should reply with an `AdmissionReview` response JSON.

```json
{
    "kind": "AdmissionReview",
    "apiVersion": "admission.k8s.io/v1",
    "response": {
        "uid": "abcdefg-qwerty-1203-12112a",
        "allowed": false,
        "status": {
            "message": "Spec.Schedule cannot be empty"
        }
    }
}
```

Now, in the case that we running our operator locally through an IDE which supports [Go's
Delve](https://github.com/go-delve/delve) such as VS Code, Goland, Vim, Emacs, we can set breakpoints and debug just as
we could for any other Go application. So, if we were to change our payload to include a `spec.Schedule` field which
isn't empty,

```json
{
  "apiVersion": "admission.k8s.io/v1beta1",
  "kind": "AdmissionReview",
  "request": {
  ...
    "object": {
        "apiVersion": "raygervais.dev/v1alpha1",
        "kind": "Crontab",
        "metadata": {
            "name": 'example-crontab-deployment',
            "namespace": "default"
        },
        "spec": {
            "schedule": "abcd123"
        }
    }
  },
  "dryRun": false
}
```

We should get this validation error now!

```json
{
    "kind": "AdmissionReview",
    "apiVersion": "admission.k8s.io/v1",
    "response": {
        "uid": "abcdefg-qwerty-1203-12112a",
        "allowed": false,
        "status": {
            "message": "Spec.Schedule is in an invalid format"
        }
    }
}
```

## Resources

- [Kubebuilder: Webhook](https://book.kubebuilder.io/reference/webhook-overview.html)
- [Chaos Mesh](https://chaos-mesh.org)
- [Test Drive Kubernetes Operators](https://pnguyen.io/posts/test-drive-kubernetes-operator-4/)
- [Kubernetes docs: Extensible Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/)
