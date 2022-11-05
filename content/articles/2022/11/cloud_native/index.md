---
title: What Does "Cloud Native" Even Mean?
date: 2022-11-04
tags: ["Open Source", "Go", "Kubernetes", "Cloud", "Cloud Native"]
Cover: https://images.unsplash.com/photo-1560928863-e140ee0fc733?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8
description: "What is `Cloud Native`? This question has popped up in conversations at least a dozen times every month, and even I find myself wondering what the *absolute* definition and understanding is of the term is. So, let’s see how the big-tech companies describe the term, followed by my opinion on said term in the current context of things."
---

What is `Cloud Native`? This question has popped up in conversations at least a dozen times every month, and even I find myself wondering what the *absolute* definition and understanding is of the term is. So, let’s see how the big-tech companies describe the term, followed by my opinion on said term in the current context of things.

## How Microsoft’s Documentation Defines Cloud Native

> Cloud native is about *speed* and *agility*. Business systems are evolving from enabling business capabilities to weapons of strategic transformation that accelerate business velocity and growth. It's imperative to get new ideas to market immediately.
>
>
> At the same time, business systems have also become increasingly complex with users demanding more. They expect rapid responsiveness, innovative features, and zero downtime. Performance problems, recurring errors, and the inability to move fast are no longer acceptable. Your users will visit your competitor. Cloud-native systems are designed to
> embrace rapid change, large scale, and resilience.
>
> Here are some companies who have implemented cloud-native techniques. Think about the speed, agility, and scalability they've achieved.
>
> [https://learn.microsoft.com/en-us/dotnet/architecture/cloud-native/definition](https://learn.microsoft.com/en-us/dotnet/architecture/cloud-native/definition)

## How Amazon Web Services Defines Cloud Native

> Cloud native is the software approach of building, deploying, and managing modern applications in cloud computing environments. Modern companies want to build highly scalable, flexible, and resilient applications that they can update quickly to meet customer demands. To do so, they use modern tools and techniques that inherently support application development on cloud infrastructure. These cloud-native technologies support fast and frequent changes to applications without impacting service delivery, providing adopters with an innovative, competitive advantage.

[https://aws.amazon.com/what-is/cloud-native/](https://aws.amazon.com/what-is/cloud-native/)

## How Red Hat Defines Cloud Native Applications

> Cloud-native applications are a collection of small, independent, and loosely coupled services. They are designed to deliver [well-recognized business value](https://www.redhat.com/en/blog/open-outlook-cloud-native-application-development), like the ability to rapidly incorporate user feedback for continuous improvement. In short, cloud-native app development is a way to speed up how you build new applications, optimize existing ones, and [connect them all](https://www.redhat.com/en/topics/integration). Its goal is to deliver apps users want at the pace a business needs.
>
>
> But what about the "cloud" in cloud-native applications? If an app is "cloud-native," it’s specifically designed to provide a consistent development and automated management experience across private, public, and hybrid clouds. Organizations adopt [cloud computing](https://www.redhat.com/en/topics/cloud) to increase the scalability and availability of apps. These benefits are achieved through self-service and on-demand provisioning of resources, as well as automating the application life cycle from development to production.
>
> [https://www.redhat.com/en/topics/cloud-native-apps](https://www.redhat.com/en/topics/cloud-native-apps)

## How GitLab Defines Cloud Native

> Cloud native is a term used to describe software that is built to run in a cloud computing environment. These applications are designed to be scalable, highly available, and easy to manage. By contrast, traditional solutions are often designed for on-premises environments and then adapted for a cloud environment. This can lead to sub-optimal
performance and increased complexity.
>
>
> The Cloud Native Computing Foundation (CNCF), an open source software organization focused on promoting the cloud-based app building and deployment approach, [defines cloud native technologies](https://github.com/cncf/toc/blob/main/DEFINITION.md) as those that “empower organizations to build and run scalable applications in modern, dynamic environments such as public, private, and hybrid clouds.”
>
> As enterprises move more of their workloads to the cloud, they are increasingly looking for solutions that are cloud native. Cloud-native solutions are designed from the ground up to take advantage of the unique characteristics of the cloud, such as scalability, elasticity, and agility.
>
> [https://about.gitlab.com/topics/cloud-native/](https://about.gitlab.com/topics/cloud-native/)

## How the Cloud Native Computing Foundation Defines Cloud Native

> Cloud native technologies empower organizations to build and run scalable applications in modern, dynamic environments such as public, private, and hybrid clouds. Containers, service meshes, microservices, immutable infrastructure, and declarative APIs exemplify this approach.
>
>
> These techniques enable loosely coupled systems that are resilient, manageable, and observable. Combined with robust automation, they allow engineers to make high-impact changes frequently and predictably with minimal toil.
>
> The Cloud Native Computing Foundation seeks to drive adoption of this paradigm by fostering and sustaining an ecosystem of open source, vendor-neutral projects. We democratize state-of-the-art patterns to make these innovations accessible for everyone.
>
> [https://www.cncf.io/about/who-we-are/](https://www.cncf.io/about/who-we-are/)

## What Are My Experiences with the Definition(s)?

![Oracle's Breakdown of Application Development over the Decades](https://www.oracle.com/a/ocom/img/rc24-cloud-native-evolution.jpg)

**Even while drafting this, I feel that my section here feels like a rant or complaint, but that is not by any means the intention. Instead, I’m simply explaining my own experience as someone who last year, had no understanding of the concept of `cloud native` and how it differed from the more traditional developer experience.**

From a high level, these definitions of the term `Cloud Native` and the medium(s) which relate to it make sense, but I’d argue that there’s a different train of thought when exploring the lower levels of what make up a platform built using `Cloud Native` technologies. The understanding of how we once deployed applications onto dedicated virtual machines (both on prem and in the public cloud) doesn’t translate to the same deployment model *implied* by the term `Cloud Native`, nor do they map sometimes to the same strategies:

- Whereas we used to have CI/CD as the universal understanding of Pipeline automation (and all the fun which accompanied it), we now have the Gitops CI/CD model enabling one to deploy and reconcile state defined within a repository.
- Whereas we wrote applications which had to be *painstak*i*n*g*ly* compatible with a multitude of hosts (for fear of vendor / OS lock in), we now strive to write applications which map directly to a single container configuration and thus, is distributed/deployed by default in that format.
- Whereas a multitude of application, ops, networking, admin, and other teams all had to be involved in the deployment of a simple application, `Cloud Native` empower a single application team to fully manage their own deployments and requirements, at the sake of now requiring an understanding of a hodgepodge of platform tools to enable their various processes. For example, one may have the following tools deployed and configured on their dev cluster, or integrated into their workflow:

  - `ArgoCD`: GitOps tool allowing us to define the state of our deployments and know that ArgoCD will attempt to mitigate drift where ever possible
  - `Trafeik`: HTTP reverse proxy which can both auto-configure itself and provide auto service discovery between your micro-services when configured.
  - `Helm`: A package manager for kubernetes applications and configurations.
  - `Kustomize`: Kubernetes native configuration management, allowing for patching, updating, other resource wizardry without needing template files. `kubectl apply -k` will become your bread and butter command in most cases.

![CNCF Landscape](https://lh6.googleusercontent.com/h-HncCT0rYue0cSgGwfu6odO-Ic6QmkwWYjLU8mjpDgtOI4H-uAe1B-c3yunc7p2H1xkQmLHmgJYRTAkYlJqIiMM5nHsUc044iYDqQYWcK_uzzUaQFm-F1Qq4SPN9u7nV1kGQZGD)

When it comes to navigating the world of `Cloud Native`, the [CNCF Cloud Native Landscape](https://landscape.cncf.io/) is a fantastic way to see all the various projects you can leverage in your own environments, but be cautious as to not [overwhelmed at all the possiblities](https://twitter.com/cncfstudents/status/1511560075994968073)! I find it helps to try out a tool from each category, and learning more of that tool if you're content with it before trying another in the same category, but that can equally be confusing if you're not sure what you need. Luckily, [Anurang Kumar's block post on kubesimply](https://blog.kubesimplify.com/navigating-through-cncf-landscape) has a fantastic guide which breaks down all the categorys and types, which I've **included** below:

> **Containerization**: The first step you do is write your application code and containerize that with the help of containerization tools like docker, crio, podman etc. This is where containerization comes into picture and there is a separate section for that in the CNCF landscape. Container runtimes are responsible for running our containerized workloads on a host operating system.

> **Container Registry**: After containerizing our application, we need to store our images somewhere and this is where container registry comes into picture. We have a separate section for container registry and this portion lists all the projects under this category.

> **CI/CD**: After containerizing our application we need to set up CI/CD for our application so that it automates the process of building an image and pushing it to the container registry.

> **Scheduling and Orchestration**: To manage large number of containers we need orchestration engine that will ease out the process of managing containers. Container orchestration engine is responsible for managing, scaling, deploying and networking of containers. The most popular container orchestration engine is Kubernetes. Kubernetes was the first project to graduate from CNCF.

> **Application Definition and Image build**: In kubernetes we have to deal with multiple k8s manifests. We can use helm to easily install applications into our kubernetes clusters. Helm is a package manager for kubernetes applications. Monokle is another tool that eases out the process of managing YAML files. It provides one command installation of apps. We can upgrade a release with one command and if something goes wrong we can rollback as well. In this section we also have multiple build tools like packer, buildpacks etc.  

> **Observability and Analysis**: we need to add some observability and analysis layer to our application and here we will use different tools for monitoring, logging, tracing, profiling. Monitoring is an important aspect of application. Monitoring gives you actionable insights into application.

> **Service Proxy and Service Mesh**: Now to expose our application to end users we need to expose our services. To manage our services we need service proxy and if we have proliferation of services then to manage that we need service mesh. It is also used to trace the traffic and observe the application. Services also act as load balancers.

> **Cloud Native Network**: We need to set up the networking for our cluster and for that we have the cloud native network section. Cilium and CNI popular projects in this category. Cilium is an open source software for providing, securing and observing network connectivity between container workloads.

> **Security and Compliance**: We can’t ignore security of our Kubernetes cluster and for that we have the security and compliance section and under this we have popular projects like OPA, falco etc. We can also define policies for our kubernetes clusters with the help of OPA, kyverno etc.

> **Database**: A cloud native database is designed to take full advantage of cloud and distributed systems.

> **Streaming and Messaging**: Cloud-native streaming is the processing of continuous data streams and is commonly used for large amounts of data and Cloud-native messaging is a communications model that enables asynchronous push-based communications between microservices.

## Resources

- [Cover image: Photo by Paul Zoetemeijer on Unsplash](https://unsplash.com/photos/AtxeOe04PQ8)
- [AWS: What is Cloud Native]([https://aws.amazon.com/what-is/cloud-native/](https://aws.amazon.com/what-is/cloud-native/))
- [Microsoft: What is Cloud Native]([https://learn.microsoft.com/en-us/dotnet/architecture/cloud-native/definition](https://learn.microsoft.com/en-us/dotnet/architecture/cloud-native/definition))
- [Red Hat: Understanding Cloud-Native Applications]([https://www.redhat.com/en/topics/cloud-native-apps](https://www.redhat.com/en/topics/cloud-native-apps))
- [Gitlab: What is Cloud Native]([https://about.gitlab.com/topics/cloud-native/](https://about.gitlab.com/topics/cloud-native/))
- [CNCF: Who We Are]([https://www.cncf.io/about/who-we-are/](https://www.cncf.io/about/who-we-are/))
- [Kubesimplify: Navigating Through the CNCF Landscape](https://blog.kubesimplify.com/navigating-through-cncf-landscape)
