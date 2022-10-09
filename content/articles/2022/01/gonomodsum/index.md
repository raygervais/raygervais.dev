---
title: "Interesting Go Environment Variables"
tags: ["Open Source", "Go", "Software Development"]
date: 2022-01-30
Cover: images/mariola-grobelska-4hAfwn_b2tw-unsplash.jpg
description: "As of December 31st, 2021, Tori V’s latest track, `Let go of Me` was released to all streaming platforms! This track, which does feature my alias `Losing Signals` was both recorded, engineered, mixed and mastered by yours truly over the course of three months and 32+ emails later! Ironically, the work started on my 2015 Macbook Pro and Ableton stock instruments while I was up north tending to Dad, but that didn’t stop us from brainstorming and getting the *vibe* of the song. I thought I’d talk about the experience, and some interesting points learned while working on the track here!"
---

Recently, while extending our CI/CD to support go Modules which pull from our private repository, I ran into an issue which resulted in me mucking around with the go environment variables in my `Dockerfile`. The issue itself involved how we handled and retrieved private vs public go modules, but also gave me a chance to evaluate our configuration settings. I thought I’d share a few common (and not so common) ones that I explored, along with some aggregated notes from other sources which helped with the debugging process. Though most of these environment variables are straight forward, where they really matter is the environment in which they are run in. In my case, that's a locked down environment behind multiple proxy configurations -so, this meant I had to equally understand how these environment variables affected the overall handling of retrieving go module dependencies.

## GOPRIVATE

By default, go attempts to retrieve modules from the public module mirror, `goproxy.io`. A sane choice, if the module is public. But, what if you're using an internal module which is not public, and thus fails to be retrieved by `go mod download`, or `go install` commands in your pipeline? Enter, `GOPRIVATE`! Similar to `GONOSUMDB`, setting a list of glob patterns -acting as module path prefixes, allows us to define which modules should be retrieved directly instead of attempting to download through a proxy or checksum database. No more 404s or timeouts when attempting to retrieve my super secret module found at `https://raygervais.dev/super-private/next-release/shhhhh/answer-to-life/` from my Docker container.

The go.dev documentation says the following when it comes to directly accessing modules: 

>The go command may be configured to bypass public proxies and download private modules directly from version control servers. This is useful when running a private proxy server is not feasible. To configure the go command to work this way, set GOPRIVATE, replacing corp.example.com the private module prefix:

>`GOPRIVATE=corp.example.com`

>The GOPROXY variable does not need to be changed in this situation. It defaults to https://proxy.golang.org,direct, which instructs the go command to attempt to download modules from https://proxy.golang.org first, then fall back to a direct connection if that proxy responds with 404 (Not Found) or 410 (Gone).

## GOSUMDB

By default, go modules have a checksum which are sent to sum.golang.org for caching. This allows for the command line to validate the version of the module downloaded today is the same checksum as the same version's download the day before. A module's dependencies has it's own checksums, which exist within the `go.sum` file. [goproxy.io](https://goproxy.io/docs/GOSUMDB-env.html) has a fantastic in-depth explanation of the validation behavior:

>Each known module version results in two lines in the go.sum file. The first line gives the hash of the module version's file tree. The second line appends "/go.mod" to the version and gives the hash of only the module version's (possibly synthesized) go.mod file. The go.mod-only hash allows downloading and authenticating a module version's go.mod file, which is needed to compute the dependency graph, without also downloading all the module's source code.

>If a downloaded module is not yet included in go.sum and it is a publicly available module, the go command consults the go checksum database to fetch the expected go.sum lines. If the downloaded code does not match those lines, the go command reports the mismatch and exits. Note that the database is not consulted for module versions already listed in go.sum.

## GONOSUMDB

The inverse of `GOSUMDB`, According to the [official docs](https://go.dev/ref/mod#environment-variables), is a list of glob patterns (acting as module path prefixes) which go should not verify checksums against using the checksum database. When not set the default value comes from `GOPRIVATE` if present. It had turned out that it was this which was causing our CI to fail, not because it was failing to retrieve the internal modules -the `GOPRIVATE` environment variable was set correctly, but because it was failing to validate the checksums of the downloaded private modules against the public `goproxy.io`. 

## GO111MODULE

An interesting item released in go 1.11 which enables go to be aware of either the modules PATH, or the `GOPATH` itself. In the 1.11 release, Google released the `go module` as an alternative method of versioning and package distribution vs the then-used `GOPATH`. This allowed for developers to put down their weapons against the `GOPATH`, and develop in peace wherever they'd like on the filesystem. This was a vital change, since before 1.11, the compiler would equally rely on the `GOPATH` for searching for dependencies when building your application. [MindOrks](https://medium.com/mindorks/create-projects-independent-of-gopath-using-go-modules-802260cdfb51) described the shortcomings of the era of the  `GOPATH`:


>1. You have to create all your projects inside a single folder where `GOPATH` is defined.
>2. Versioning go packages were not supported. It doesn't allow you to specify a particular version for a go package similar to how you would in a `package.json`.
>3. All external packages were kept in a `vendor` folder and pushed to the server. Dependency Hell would occur, always.


## Resources

- [Cover Image: Photo by MARIOLA GROBELSKA Unsplash](https://unsplash.com/photos/4hAfwn_b2tw)
- [goproxy.io/docs/](https://goproxy.io/docs/introduction.html)
- [go.dev](https://go.dev/ref/mod#environment-variables)




