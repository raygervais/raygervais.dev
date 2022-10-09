---
title: Building A Hardened Docker Image Using Modern Infrastructure Tooling
draft: false
date: 2020-08-28
tags:
  [
    "Open Source",
    "Go",
    "Testing",
    "Ruby",
    "Docker",
    "Puppet",
    "Packer",
    "Software Development",
    "CI/CD",
    "Lessons",
  ]
Cover: "images/robert-v-ruggiero-BG-iyXjJiLs-unsplash.jpg"
description: "Hey friend, it's been a while since I last posted here -soon to be four months had I not started writing this article. It's been quite the past few months, but I thought about this subject quite a bit recently as enterprise lessons on design and iteration have prompted me wanting to explore similar practices. What am I exploring -as the title suggests, building Docker images leveraging infrastructure technologies and tooling such as Packer, Puppet, and InSpec! So, why would I use such technologies when a simple `Dockerfile` might suffice for an example like this? Because whereas a `Dockerfile` works only with Docker, these individual components allow us to create a modularized and portable set of layers which can be leveraged in various contexts, such as building virtual machines in a variety of public cloud providers such as Microsoft Azure, Google Cloud, and Amazon Web Services."
---

Hey friend, it's been a while since I last posted here -soon to be four months had I not started writing this article. It's been quite the past few months, but I thought about this subject quite a bit recently as enterprise lessons on design and iteration have prompted me wanting to explore similar practices. What am I exploring -as the title suggests, building Docker images leveraging infrastructure technologies and tooling such as Packer, Puppet, and InSpec! So, why would I use such technologies when a simple `Dockerfile` might suffice for an example like this? Because whereas a `Dockerfile` works only with Docker, these individual components allow us to create a modularized and portable set of layers which can be leveraged in various contexts, such as building virtual machines in a variety of public cloud providers such as Microsoft Azure, Google Cloud, and Amazon Web Services. It'll make sense hopefully as we go along, so let's identify the key layers and requirements:

- Packer: Overall orchestrator which creates the Docker image
- Puppet: Configures the image to our requirements, which are:
  - Create the following users: `dev`, `qat`, and `uat`
  - Update the image to include latest patches available through the respective repositories
  - Implement OS hardening using the `dev-sec/os-hardening` open source module
- InSpec: Testing framework to validate various requirements were achieved

# Digging Into Packer and Hashicorp's Control Language (HCL)2

HCL 1.0 could be mistaken for straight JSON, appearing as:

```json
{
  "builders": [
    {
      "ami_name": "packer-test",
      "region": "us-east-1",
      "instance_type": "t2.micro",

      "source_ami_filter": {
        "filters": {
          "virtualization-type": "hvm",
          "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",
          "root-device-type": "ebs"
        },
        "owners": ["amazon"],
        "most_recent": true
      },

      "ssh_username": "ubuntu",
      "type": "amazon-ebs"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": ["sleep 5"]
    }
  ]
}
```

This JSON-esque control language I've seen since entering the Cloud Engineering world, and was rather interested in trying HCL2 for this experiment since it builds off of the experiences of Hashicorp's Terraform configuration language. That being, no more JSON and instead following a more Go syntax. So, let's get started building a Ubuntu 20.04 Docker image! The final source code can be found [here](https://github.com/raygervais/packer-puppet-inspec-example) for those wanting to follow along. I've included Packer's JSON to HCL2 comments to help provide context where possible.

```hcl
# file: ubuntu.pkr.hcl
# version: 1.0

# the source block is what was defined in the builders section and represents a
# reusable way to start a machine. You build your images from that source. All
# sources have a 1:1 correspondence to what currently is a builder.
source "docker" "ubuntu" {
  image   = "ubuntu:20.04"
  commit  = true
}

# A build starts sources and runs provisioning steps on those sources.
build {
  sources = [
    "source.docker.ubuntu",
  ]

  # All provisioners and post-processors have a 1:1 correspondence to their
  # current layout. The argument name (ie: inline) must to be unquoted
  # and can be set using the equal sign operator (=).
  provisioner "shell" {
    inline = [
        "apt update -y",
        "apt upgrade -y",
    ]
  }

  post-processor "docker-tag" {
    repository = "raygervais/ubuntu-packer-build"
    tags       = ["1.0"]
  }
}
```

To run packer, you need to install it locally on your host machine. Then, you can execute with `packer build .` in the same directory as your ubuntu.prk.hcl file will produce a stock Ubuntu 20.04 Docker container. For this tutorial, I'm leveraging the WSL2-backend Docker setup I described [here](/article/end-to-end-telescope-with-docker-ws-l2-and-windows-10/). Whereas we could leverage `changes` within the `source` block which allows us to add the typical `ENV`, `WORKDIR`, `RUN`, `COPY`, we're going to leave configuration of the image to Puppet for the most part. So, let's update the `provisioner.shell` array to install Puppet and Inspec on the docker image. The `DEBIAN_FRONTEND` environment variable is to ensure various packages such as `timezone` don't wait for user input or confirmations prior to installation.

```hcl
provisioner "shell" {
  inline = [
    "apt update -y",
    "apt upgrade -y",
    "DEBIAN_FRONTEND='noninteractive' apt install puppet -y",
  ]
}
```

## Handing Controls to the Puppet [Master]

So here's where modularity starts to come into play. The purpose of utilizing Puppet (or any configuration management system) instead of shell scripts is to leverage an abstraction layer between various package managers, operating systems and compute types using a single language / tool. Whereas we are currently working with Docker, the same _could_ be run on virtual machines built in the public cloud, or orchestrated in VM Ware. Though it's against good practice, I'm going to write the configuration code all in a single class file purely for easier reading. If we are to create a single user, that can be done with the following puppet file and a simple `puppet apply app.pp`.

```ruby
# app.pp
class app {
  user { 'rgervais':
    ensure     => present,
    managehome => true,
    home       => '/home/rgervais'
  }
}
```

Now, let's add the user accounts that we determined in our requirements. Though this array could be passed in via other configuration files, let's keep it simple for this example.

```ruby
# app.pp
  user { "dev":
    ensure     => present,
    managehome => true,
    home       => "/home/dev"
  }

  user { "qat":
    ensure     => present,
    managehome => true,
    home       => "/home/dev"
  }

  user { "uat":
    ensure     => present,
    managehome => true,
    home       => "/home/dev"
  }
```

## Validating With Inspec

_So funny side note, I typically write these types of articles after writing the example code / project. I opted to not do that this time since I too was learning HCL2 and building Docker images using Packer in this monorepo fashion as I was writing. I wanted to write in this fashion so that I could quantify what I had learned into semi-reasonable understanding and update the post as I drafted it. With that, after debugging on the weekend what I thought would be a simple implementation, I ended up writing a [issue ticket for Packer](https://github.com/hashicorp/packer/issues/9804) seeking help on the matter. Turns out, though we don't need Puppet installed on the host machine for it to run on the Docker image builder, we do require InSpec! No longer need this line which you'll find in the example repo's initial commit `"DEBIAN_FRONTEND='noninteractive' curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P inspec"`. So, I'm attempting to contribute some additional documentation so that others don't follow the same misunderstood workflow as I did. Thanks again [@sylviamoss](https://github.com/sylviamoss) for your help!_

InSpec, which was inspired by ServerSpec is a server testing framework built ontop of Ruby technologies by Chef, allowing for one to test and ensure "compliance as code". To get started, let's add our profile declaration in the `inspec.yml` file, located in our tests folder.

```yml
# inspec.yml
---
name: packer-puppet-inspec-profile
maintainer: Ray Gervais
license: MIT
summary: An InSpec Compliance Profile Example
version: 1.0

supports:
  - platform-family: linux
```

This allows profile allows us to pass variables as well, but that's for another post. The next folder we're going to create is `controls`, which is the folder inspec looks for to locate tests. It'll go in our tests folder and house our `users.rb` test.

```ruby
# users.rb
control 'users' do
    impact 1.0
    title 'Ensure user accounts were created'

    # Resource: https://docs.chef.io/inspec/resources/user/
    describe user('dev') do
        it { should exist }
        its('home') { should eq '/home/dev' }
        its('badpasswordattempts') { should eq 0 }
    end

    describe user('qat') do
        it { should exist }
        its('home') { should eq '/home/qat' }
        its('badpasswordattempts') { should eq 0 }
    end

    describe user('uat') do
        it { should exist }
        its('home') { should eq '/home/uat' }
        its('badpasswordattempts') { should eq 0 }
    end
end
```

One of the benefits to utilizing InSpec is the how friendly / human-readable it is for developers and non-developers alike. With the file above, we are able to determine that the three users `dev`, `qat`, and `uat` are created with their corresponding user-homes and shells configured as described in the code.

```log
    docker.ubuntu: Profile: packer-puppet-inspec-profile
    docker.ubuntu: Version: 1.0
    docker.ubuntu: Target:  ssh://raygervais@127.0.0.1:42261
    docker.ubuntu:
    docker.ubuntu:   ✔  users: Ensure user accounts were created
    docker.ubuntu:      ✔  User dev is expected to exist
    docker.ubuntu:      ✔  User dev home is expected to eq "/home/dev"
    docker.ubuntu:      ✔  User dev badpasswordattempts is expected to eq 0
    docker.ubuntu:      ✔  User qat is expected to exist
    docker.ubuntu:      ✔  User qat home is expected to eq "/home/qat"
    docker.ubuntu:      ✔  User qat badpasswordattempts is expected to eq 0
    docker.ubuntu:      ✔  User uat is expected to exist
    docker.ubuntu:      ✔  User uat home is expected to eq "/home/uat"
    docker.ubuntu:      ✔  User uat badpasswordattempts is expected to eq 0
    docker.ubuntu:
    docker.ubuntu:
    docker.ubuntu: Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
    docker.ubuntu: Test Summary: 9 successful, 0 failures, 0 skipped
```

## Hardening The Docker Image

What's the number one concern for a cloud engineer once their tools are out in the open? The security of the machine hosting and running said tools! It's for this overly dramatic (and poorly explained) reason that the `CIS` [Center For Information Security] benchmarks were created to create a standardized and well researched set of rules for both Windows and Linux-based operating systems. I've seen it everywhere I've worked in varying degrees, and have equally implemented systems which enable and test for compliance of our infrastructure against the benchmark. Having a secure docker image is like adding having the best security system for your house -it doesn't make it impenetrable, but removes common settings and configurations which when left untouched, prove to be an attack vector.

On Github, you can find countless implementations of the CIS rules for the common configuration management platforms such as `Ansible`, `Chef`, `Salt`, and `Puppet`. Since I have recent experience with `Puppet`, I'll be using the DevSec provided `os-hardening` module, which is described, `This [puppet] module provides numerous security-related configurations, providing all-round base protection.` Though it may not cover all of the CIS, I wanted to explore and understand the configuration differences between `os-hardening`, and the `inspec-docker-cis` or `inspec-dil-cis` profiles.

```ruby
# hardening.pp
include class { 'os_hardening': system_environment => "docker"}
```

```hcl
# ubuntu.pkr.hcl
provisioner "puppet-masterless" {
    manifest_file     = "config/hardening.pp"
    prevent_sudo      = true
    guest_os_type     = "unix"
    ignore_exit_codes = true
}

provisioner "inspec" {
    inspec_env_vars = ["CHEF_LICENSE=accept"]
    profile         = "https://github.com/dev-sec/linux-baseline"
    extra_arguments = ["--no-distinct-exit"]
}
```

When running the same `packer build .` with the new additions, we should see snippets such as the following in our output which allows one to slip in some peace of mind:

```log
==> docker.ubuntu: Provisioning with Inspec...
==> docker.ubuntu: Executing Inspec: inspec exec https://github.com/dev-sec/linux-baseline --backend ssh --host 127.0.0.1 --user raygervais --key-files /tmp/packer-provisioner-inspec.234902354.key --port 37521 --input-file /tmp/packer-provisioner-inspec.960005257.yml --no-distinct-exit
    docker.ubuntu: [2020-08-27T16:06:33-04:00] WARN: URL target https://github.com/dev-sec/linux-baseline transformed to https://github.com/dev-sec/linux-baseline/archive/master.tar.gz. Consider using the git fetcher
    docker.ubuntu:
    docker.ubuntu: Profile: DevSec Linux Security Baseline (linux-baseline)
    docker.ubuntu: Version: 2.5.0
    docker.ubuntu: Target:  ssh://raygervais@127.0.0.1:37521
    docker.ubuntu:
    docker.ubuntu:   ✔  os-01: Trusted hosts login
    docker.ubuntu:      ✔  File /etc/hosts.equiv is expected not to exist
    docker.ubuntu:   ✔  os-02: Check owner and permissions for /etc/shadow
    docker.ubuntu:      ✔  File /etc/shadow is expected to exist
    docker.ubuntu:      ✔  File /etc/shadow is expected to be file
    docker.ubuntu:      ✔  File /etc/shadow is expected to be owned by "root"
    docker.ubuntu:      ✔  File /etc/shadow is expected not to be executable
    docker.ubuntu:      ✔  File /etc/shadow is expected not to be readable by other
    docker.ubuntu:      ✔  File /etc/shadow group is expected to eq "shadow"
    docker.ubuntu:      ✔  File /etc/shadow is expected to be writable by owner
    docker.ubuntu:      ✔  File /etc/shadow is expected to be readable by owner
    docker.ubuntu:      ✔  File /etc/shadow is expected to be readable by group
    docker.ubuntu:   ✔  os-03: Check owner and permissions for /etc/passwd
    docker.ubuntu:      ✔  File /etc/passwd is expected to exist
    docker.ubuntu:      ✔  File /etc/passwd is expected to be file
    docker.ubuntu:      ✔  File /etc/passwd is expected to be owned by "root"
    docker.ubuntu:      ✔  File /etc/passwd is expected not to be executable
    docker.ubuntu:      ✔  File /etc/passwd is expected to be writable by owner
    docker.ubuntu:      ✔  File /etc/passwd is expected not to be writable by group
    docker.ubuntu:      ✔  File /etc/passwd is expected not to be writable by other
    docker.ubuntu:      ✔  File /etc/passwd is expected to be readable by owner
    docker.ubuntu:      ✔  File /etc/passwd is expected to be readable by group
    docker.ubuntu:      ✔  File /etc/passwd is expected to be readable by other
    docker.ubuntu:      ✔  File /etc/passwd group is expected to eq "root"
    docker.ubuntu:   ✔  os-03b: Check passwords hashes in /etc/passwd
    docker.ubuntu:      ✔  /etc/passwd passwords is expected to be in "x" and "*"
    docker.ubuntu:   ✔  os-04: Dot in PATH variable
    docker.ubuntu:      ✔  Environment variable PATH split is expected not to include ""
    docker.ubuntu:      ✔  Environment variable PATH split is expected not to include "."
    docker.ubuntu:   ✔  os-05: Check login.defs
    docker.ubuntu:      ✔  File /etc/login.defs is expected to exist
    docker.ubuntu:      ✔  File /etc/login.defs is expected to be file
    docker.ubuntu:      ✔  File /etc/login.defs is expected to be owned by "root"
    docker.ubuntu:      ✔  File /etc/login.defs is expected not to be executable
    docker.ubuntu:      ✔  File /etc/login.defs is expected to be readable by owner
    docker.ubuntu:      ✔  File /etc/login.defs is expected to be readable by group
    docker.ubuntu:      ✔  File /etc/login.defs is expected to be readable by other
    docker.ubuntu:      ✔  File /etc/login.defs group is expected to eq "root"
    docker.ubuntu:      ✔  login.defs ENV_SUPATH is expected to include "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    docker.ubuntu:      ✔  login.defs ENV_PATH is expected to include "/usr/local/bin:/usr/bin:/bin"
    docker.ubuntu:      ✔  login.defs UMASK is expected to include "027"
    docker.ubuntu:      ✔  login.defs PASS_MAX_DAYS is expected to eq "60"
    docker.ubuntu:      ✔  login.defs PASS_MIN_DAYS is expected to eq "7"
    docker.ubuntu:      ✔  login.defs PASS_WARN_AGE is expected to eq "7"
    docker.ubuntu:      ✔  login.defs LOGIN_RETRIES is expected to eq "5"
    docker.ubuntu:      ✔  login.defs LOGIN_TIMEOUT is expected to eq "60"
    docker.ubuntu:      ✔  login.defs UID_MIN is expected to eq "1000"
    docker.ubuntu:      ✔  login.defs GID_MIN is expected to eq "1000"
    docker.ubuntu:   ↺  os-05b: Check login.defs - RedHat specific
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    docker.ubuntu:   ✔  os-06: Check for SUID/ SGID blacklist
    docker.ubuntu:      ✔  suid_check diff is expected to be empty
    docker.ubuntu:   ✔  os-07: Unique uid and gid
    docker.ubuntu:      ✔  /etc/passwd uids is expected not to contain duplicates
    docker.ubuntu:      ✔  /etc/group gids is expected not to contain duplicates
    docker.ubuntu:   ✔  os-08: Entropy
    docker.ubuntu:      ✔  3800 is expected to >= 1000
    docker.ubuntu:   ✔  os-09: Check for .rhosts and .netrc file
    docker.ubuntu:      ✔  [] is expected to be empty
    docker.ubuntu:   ↺  os-10: CIS: Disable unused filesystems
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    docker.ubuntu:   ✔  os-11: Protect log-directory
    docker.ubuntu:      ✔  File /var/log is expected to be directory
    docker.ubuntu:      ✔  File /var/log is expected to be owned by "root"
    docker.ubuntu:      ✔  File /var/log group is expected to match /^root|syslog$/
    docker.ubuntu:   ✔  package-01: Do not run deprecated inetd or xinetd
    docker.ubuntu:      ✔  System Package inetd is expected not to be installed
    docker.ubuntu:      ✔  System Package xinetd is expected not to be installed
    docker.ubuntu:   ✔  package-02: Do not install Telnet server
    docker.ubuntu:      ✔  System Package telnetd is expected not to be installed
    docker.ubuntu:   ✔  package-03: Do not install rsh server
    docker.ubuntu:      ✔  System Package rsh-server is expected not to be installed
    docker.ubuntu:   ✔  package-05: Do not install ypserv server (NIS)
    docker.ubuntu:      ✔  System Package ypserv is expected not to be installed
    docker.ubuntu:   ✔  package-06: Do not install tftp server
    docker.ubuntu:      ✔  System Package tftp-server is expected not to be installed
    docker.ubuntu:   ↺  package-07: Install syslog server package
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    docker.ubuntu:   ↺  package-08: Install auditd
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    docker.ubuntu:   ✔  package-09: CIS: Additional process hardening
    docker.ubuntu:      ✔  System Package prelink is expected not to be installed
    docker.ubuntu:   ↺  sysctl-01: IPv4 Forwarding
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    docker.ubuntu:   ↺  sysctl-02: Reverse path filtering
    docker.ubuntu:      ↺  Skipped control due to only_if condition.
    ..............
    docker.ubuntu:
    docker.ubuntu:
    docker.ubuntu: Profile Summary: 17 successful controls, 0 control failures, 38 controls skipped
    docker.ubuntu: Test Summary: 57 successful, 0 failures, 38 skipped
```

Ta-da! We can see our new Docker image in all it's glory by using `docker images`.

```
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
raygervais/ubuntu-packer-build   1.0                 7ac57917ef93        25 hours ago        107MB
```

Finally, if we wanted to jump into the container, we could do that with `docker run -it raygervais/ubuntu-packer-build:1.0`. Once in, we can verify that Puppet ran (if the InSpec tests weren't enough) with `ls -la /home`, to which we see our newly created home directories (and their respective users/owners):

```bash
root@382af3e8cd70:/home# ls -la
total 20
drwxr-xr-x 1 root root 4096 Aug 27 20:06 .
drwxr-xr-x 1 root root 4096 Aug 28 21:00 ..
drwxr-xr-x 2 dev  dev  4096 Aug 27 20:06 dev
drwxr-xr-x 2 qat  qat  4096 Aug 27 20:06 qat
drwxr-xr-x 2 uat  uat  4096 Aug 27 20:06 uat
```

## Next Steps

To recap, our final project structure should have the following folders with their respective files:

| Folder    | Description                    |
| --------- | ------------------------------ |
| config    | the puppet configuration files |
| scripts   | any additional shell scripts   |
| templates | packer HCL files               |
| tests     | InSpec profile tests           |

If we wanted to now extend this to other operating systems or platforms, the configurations and various tests are separated in such a way that extending them is trivial! The investment would be in writing dedicated `HCL` files for the additional platforms, and extending our Puppet configurations to support additional systems (in the our use-case, it's incredible portable, but if you were leveraging the `apt` package manager for example, it wouldn't work with `RHEL`-based systems which utilize `yum` alongside `rpm`).

The beauty of this monorepo architecture (which is odd for me to advocate, but here we are. I blame 2020.) allows for us to pool the entire container workflow inputs into a single location which can be versioned via `GIT` or another tool. Instead of having to hunt through various repositories in your VCS, or look for the needle (commit) in the haystack (git history) of which commit broke your build over multiple projects, you only have one history to worry about. The best part? With CI/CD tooling, we can have test builds after each commit and ensure our main branch is always stable! You have no idea how much frustration I've experienced due to the last point in the past while. This has been a fun experiment learning how modern Packer + HCL2 writes, and utilizing a monorepo structure!

# Resources

- [Cover Image: Photo by Robert V. Ruggiero on Unsplash](https://unsplash.com/photos/BG-iyXjJiLs)
- [Example Repository](https://github.com/raygervais/packer-puppet-inspec-example)
- [Inspec](https://github.com/inspec/inspec)
- [Terraform](https://www.terraform.io/)
- [Packer](https://wwww.packer.io)
- [Center For Internet Security Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [Introduction to Packer HCL2](https://www.packer.io/guides/hcl)
