---
title: Understanding Go Project Structures
tags: ["Open Source", "Go", "Notes", "Software Development"]
Cover: https://images.unsplash.com/photo-1488972685288-c3fd157d7c7a?q=80&w=2400&auto=format&fit=crop
draft: false
date: 2020-11-21
description: "So I wanted to publish this in attempt to further my own understanding of proper Go project file structures, especially after writing side projects with varying inflexible and incoherent file structures. I _will_ not in any form claim to understand what I'm talking about, and instead share this as if it were my own notes in attempts to understand why `/pkg` is found in every damn project."
---

_A Cheatsheet which I hope to reference until memorized._

So I wanted to publish this in attempt to further my own understanding of proper Go project file structures, especially after writing side projects with varying inflexible and incoherent file structures. I _will_ not in any form claim to understand what I'm talking about, and instead share this as if it were my own notes in attempts to understand why `/pkg` is found in every damn project.

## Folder Structure

Below, I've listed commonly found folders if you explored popular Go projects such as:

- [Exposure Notifications Server](https://github.com/google/exposure-notifications-server)
- [Kubernetes](https://github.com/kubernetes/kubernetes)
- [Terraform](https://github.com/hashicorp/terraform)
- [Argo](https://github.com/argoproj/argo)
- [micro](https://github.com/zyedidia/micro)

_For a full list, see the *Go Standards Project Layout* link below which has a far more extensive listing._

### /cmd

- Contains the `main.go`, which is the entrypoint of your application.
- Should be followed directly with your binary name, for example `/cmd/example/main.go`
- Should contain only main execution code, with all logic being imported from `/pkg` or `/internal`.

### /internal

- For application configurations and libraries which you don't want imported by other applications. _NOTE_, this is enforced by the compiler as of Go 1.4.
- For sanity, you could extend `/internal` to emulate the appropriate file structure (ex. `/internal/pkg`) where appropriate.

### /pkg

- Shared library code, which can be imported by both your application and other applications.
- One of the most common layout patterns for bigger applications, for smaller applications this may be considered overkill.

### /vendor

- Manually managed application dependencies (such as environment binaries) are stored here.

### /build

- Contains all container (ex. `Dockerfile`), packages (`.deb`, `.rpm`, `.zip`) and scripts into `/build/packages`.
- CI configurations and scripts get placed in `/build/ci`.

### /docs

- Contains both generated documentation via `godoc` and user design documents.

## Final Thoughts and Opinions

Go was written as a server language to be used internally at Google, and I believe it inherited much of it's semantics from such an environment. We can see this reflected in the project structure with `/pkg` and `/internal` implying a deep understanding of libraries being shared and used among various services. Furthermore, `/cmd` as the entrypoint and with the "least amount of logic" implies the idea further that applications and services are built upon libraries instead of the typical monolithic bits of logic bound to a single project.

Another reason why I wanted to write this was due to following tutorials for various tasks which all had different structural patterns, leading me to submitting constant PRs which changed the overall folder structure without much explanation as to why. Having wrote this small post, I'm already far more confident (and also really apologetic to James and friends who've had to deal with my constant Go "let's see if we can improve this by rewriting it....." antics in our projects).

_Will I follow this standard in my next Go project? Hopefully._

# Resources

- [Cover Image: Photo by Anders Jildén on Unsplash](https://unsplash.com/photos/Sc5RKXLBjGg)
- [Go Standards Project Layout](https://github.com/golang-standards/project-layout)
- [Using Go Modules](https://blog.golang.org/using-go-modules)
