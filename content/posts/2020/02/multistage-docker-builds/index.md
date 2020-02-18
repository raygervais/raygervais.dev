---
title: Reduced Container Sizes With Multi-Stage Docker Builds
published: true
date: 2020-02-18
tags: [
    "Open Source",
    "Docker", 
    "DevOps",
    "NodeJS",
    "OSD600",
    "Optimizations"
]
description: "I had worked on Docker in the past for one of my internships, optimizing our microservice build pipeline to utilize multi-stage containers (at the sake of time complexity) which enabled far smaller artifacts to be stored in the private repository which had the compiled resources and bare minimum node-modules that were needed. For that microservice architecture, we successfully decreased the size from ~1GB (x 7 for the services) to ~140mb (x 7). That's just under 1GB for the entire architecture compared 7GB previously!"
---

## RUN `export context="this"`

In my free time, I've tried to contribute some of my Docker and development experience to [@humphd](twitter.com/@humpd)'s Telescope project, this past week being a contribution that I'm proud of that I believe helps reduce the space complexity of the production and development images. Before my work, A local Docker container of `telescope` would weigh ~2GB and comprise of the entire codebase, all node modules needed for both development and release, and other tooling which added to the storage cost. For those with small drives, this could make quite the ugly development experience! I had worked on Docker in the past for one of my internships, optimizing our microservice build pipeline to utilize multi-stage containers (at the sake of time complexity) which enabled far smaller artifacts to be stored in the private repository which had the compiled resources and bare minimum node-modules that were needed. For that microservice architecture, we successfully decreased the size from ~1GB (x 7 for the services) to ~140mb (x 7). That's just under 1GB for the entire architecture compared 7GB previously!

## FROM node:lts-alpine

I think we can all agree, Node applications are rather grand in the dependency scale which attributes to quite the big container. Moreso, the default Docker node container (based on Debain / Ubuntu) also includes many packages which are not needed. This is where Alpine Linux shines, a minimalistic (mmmmm, minimalism) system which is geared towards servers and containers! A downside to Alpine is the integration of [`musl-libc`](https://alpinelinux.org/posts/Alpine-Linux-has-switched-to-musl-libc.html) as opposed to `glibc` which is the GNU standard C library often used for building applications. To remedy this for those encountering issues, see under [Resources](#resources) the `GCC on Alpine Linux` link which I discovered this week.

Moving from `node:lts` to `node:lts-alpine` reduced the base container size from 1GB to 140MB alone! Dave experiment with installing only the production dependencies reduced the build as well by quite ____ and asked that I help implement the multistage builds that I had mentioned previously. So, let's go about that and explain how it's done.

## Multi-stage Builds

Multi-stage


## Resources

- [Cover Image]()
- [GCC on Alpine Linux](https://wiki.alpinelinux.org/wiki/GCC)
- [Alpine Switches to musl-libc](https://alpinelinux.org/posts/Alpine-Linux-has-switched-to-musl-libc.html)

