---
title: End-to-End Telescope with Docker, WSL2 and Windows 10
draft: false
date: 2020-04-13
tags:
  [
    "Open Source",
    "NodeJS",
    "Docker",
    "ReactJS",
    "Microsoft",
    "Windows",
    "Linux",
  ]
description: "So on April 3rd, I managed to completely blow up my Pop!OS installation beyond repair. I blame Nvidia drivers and permissions, but it's also a reminder to `never fix what's not broken`. For the past month, I had really enjoyed being on Linux and tweaking about with various aspects of my desktop, yet even in that happiness my friends constantly reminded me of the applications that I used which don't support Linux. This included games, audio software, guitar effects for example. I decided hey, if my install is already borked and backed-up, let's install Windows 10 for the weekend and see how frustrated I can get. Solid plan, don't you think?"
Cover: "images/nasa-Q1p7bh3SHj8-unsplash.jpg"
---

_This is a true story of pain and beating the odds. Not for the faint of heart. TLDR at the bottom for those looking for the exact workflow._

## Nothing Says Spring Cleaning Like Blowing Away Your System!

So on April 3rd, I managed to completely blow up my Pop!OS installation beyond repair. I blame Nvidia drivers and permissions, but it's also a reminder to `never fix what's not broken`. For the past month, I had really enjoyed being on Linux and tweaking about with various aspects of my desktop, yet even in that happiness my friends constantly reminded me of the applications that I used which don't support Linux. This included games, audio software, guitar effects for example. I decided hey, if my install is already borked and backed-up, let's install Windows 10 for the weekend and see how frustrated I can get. Solid plan, don't you think?

I had a few goals for the weekend, some productive and others not so much:

- Test Windows Subsystem for Linux, proving that I'd kept my word from my previous [blog post] citing that I'd give the WSL 2 development workflow a try from the very start next time I found myself on Windows 10.
- Build and deploy [Telescope](https://github.com/Seneca-CDOT/telescope) so that I could continue hacking away at contributions.
- Iterate on my [website](https://github.com/raygervais/raygervais.dev) so that I could continue writing blog posts.
- Recreate the few Gnome / Linux shortcuts that I had implemented and used daily
  - `ctl + alt + p` -> Take Screenshot and save to clipboard
  - `ctl + space` -> Search with input focus
- Install Steam, play some Rocket League / Insurgency / Counter Strike Global Offensive with friends.

I managed to achieve success for quite a few of these items, the most important being the first two which I want to talk about.

## Getting Windows Subsystem for Linux (2).

![Windows Update Screen Parody](https://media.giphy.com/media/hJaQNVrOPC4Ja/giphy.gif)

Even if I'm on an NT-kernel, I knew that Telescope development (and most web development) was most sane (all things considered) on a Unix-based kernel environment. Staying true to previous ambitions and interests, I knew I had to give WSL 2 a shot. Installation on my build (1909) was simple enough, a few PowerShell commands and then installing the Ubuntu distribution which finished the process. From there, I converted the kernel to version 2 and began following the commands documented in Telescope for getting up and running with Windows.

```md
- Git clone, check.
- Install Docker desktop, check.
- Install Docker on Ubuntu, check.
- Pass-thru Docker engine to Ubuntu, I think it worked?.
- Execute `docker-compose up --build` with fingers crossed.
```

_One of the beautiful errors I'd see flashing across my defeated screen._

```
ERROR: for telescope_login_1  Cannot start service login: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"rootfs_linux.go:58: mounting \\\"/home/raygervais/Developer/telescope/simplesamlphp-users.php\\\" to rootfs \\\"/var/lib/docker/overlay2/c1ef5cdb47b26eeea202fdb3b01590324a44db3fa10a523b01f7f3edfbbd19b1/merged\\\" at \\\"/var/lib/docker/overlay2/c1ef5cdb47b26eeea202fdb3b01590324a44db3fa10a523b01f7f3edfbbd19b1/merged/var/www/simplesamlphp/config/authsources.php\\\" caused \\\"not a directory\\\"\"": unknown: Are you trying to mount a directory onto a file (or vice-versa)? Check if the specified host path exists and is the expected type
ERROR: for login  Cannot start service login: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"rootfs_linux.go:58: mounting \\\"/home/raygervais/Developer/telescope/simplesamlphp-users.php\\\" to rootfs \\\"/var/lib/docker/overlay2/c1ef5cdb47b26eeea202fdb3b01590324a44db3fa10a523b01f7f3edfbbd19b1/merged\\\" at \\\"/var/lib/docker/overlay2/c1ef5cdb47b26eeea202fdb3b01590324a44db3fa10a523b01f7f3edfbbd19b1/merged/var/www/simplesamlphp/config/authsources.php\\\" caused \\\"not a directory\\\"\"": unknown: Are you trying to mount a directory onto a file (or vice-versa)? Check if the specified host path exists and is the expected type
ERROR: Encountered errors while bringing up the project.
```

With the help of [Rafi Ungar](https://raungar.wordpress.com/) and [James Inkster](https://grommers.wordpress.com/), both of which are Windows users who too had suffered in setting up Telescope on their own development environments, I had come to learn of either missing-workarounds which I needed, or architectures and build versions which needed to be configured and installed to enable Docker to properly orchestrate the environment with the WSL 2 based code. Let's go more into that.

## I Can't See You Through My Telescope?!

![Patrick Destroying a Computer With Spongebob Watching](https://media.giphy.com/media/iDSZ2gTGtTcWI/giphy.gif)

Installing version 2 wasn't an issue with the latest stable release (1909), but there's a few caveats if you have ambitions such as yours truly for running Docker and WSL2 for your developer environment. See, some of the others were showing me how to configure Hyper-V and Docker, using the native Windows filesystem compared to WSL or using Virtual Box instead, but I wanted to achieve something unheard of; a feat which I've been gearing towards since one of my first Docker posts two years ago. Build a full developer environment with CLIs, Dependencies and orchestration without touching the windows system in anyway aside from hosting. That meant that Windows 10 would host WSL2, Visual Studio Code, and Docker at most. The rest of the heavy lifting would be done end-to-end by the Linux layer.

After much research, and consulting with Windows Guru Rafi, he asked me a question which I had neglected to read over in the Docker documentation (my bad): _Are you using the WSL-2 back-end engine for Docker?_ Well, no I wasn't Rafi. Not yet.

Firstly, that option isn't included in the latest stable Docker desktop client which I had installed. Secondly, I started to curse the sparse environment setup documentation for such a scenario. True to the developer nature, any hotfix or workaround is not documented and forgotten about until that special moment where it's needed -often a few hours after it was needed. Time to install the Edge version of Docker Desktop!

![Edge Docker Version](images/docker-edge-version.png)

Once I had replaced Docker with the bleeding-edge client, I was greeted with another caveat: minimum build required for WSL-2 engine not meet. Damnit. So, enrolling into the Insider's build is what I did, based on others providing their blessing and support on the manner. The latest available on the slow channel was 2004, which would according to the NT-Based Telescope developers, fulfill the requirements. After enrolling, I saw a flurry of updates come down the pipeline, requiring at least 4 separate total-system reboots before 2004 started to download...Quite annoying to spend a Friday night in such a way, but truthfully what else was there to do? I got in quite a bit of reading in while everything ran.

And it downloaded.

And rebooted some more.

Once completed, I did the reboot which would break the final barrier between my WSL 2 / Docker developer ambitions and myself. Except, that's not what happened. Quite the opposite really. I was greeted not once, not twice, but thrice by the green (blue) screen of death while trying to install the 2004 build. Each time, the message was around the unsegmented memory handling error, laughing at me and spending it's sweet time "undoing" what bits of the update actually worked. After much Googling, I removed all non-essential programs, USB peripherals, and even did various disk and hardware checks using tools such as `chdsk`. After a few more attempts, still no dice.

I decided to cut my loses and follow a different method of debugging. The ultimate method when all else fails. `rm -rf /`. Well, I mean wipe the entire system (which was already brand new to begin with, with few programs installed to get me up and started!) and reinstall using the same 1909 build on my USB key. As soon as the reinstall occurred, I went straight to re-enrolling in Insiders, and updating to 2004. This time, it went off only required three reboots.

Once I confirmed that no green (blue) screen of death would surprise me in anything but my sleep, I went about installing WSL 2, VS Code, and Docker. The bare essentials. _Minimalism_ at it's best. Ok, maybe Firefox as well, but that's because who can use Edge (pre-Chromium) willingly? With the sub-layer installed, Ubuntu installed and converted to version 2, and the unstable Docker client finished it's business, I opened Docker settings. For the last time.

![Docker Edge Client Settings](images/docker-wsl-integration.png)

It was beautiful, the options being available for the Linux based engine instead of Hyper-V. This meant many great things, some that I'll go into in the next chapter, and others that I'll specify with as simply: I don't need Hyper-V itself for anything. I can run Android Studio alongside Docker for example without having to route one through Hyper-V and break runtime compatibility with the other. Cindy, you know just how much pain this causes. Having gotten to this point, I opted to start saving links which would become a pull request with updated documentation expanding on using WSL 2 for all Windows 10 editions.

![Cindy Explaining Reboot Pains](images/Cindy-Docker-Android.png)

After opening Ubuntu through WSL, I decided to tempt fate. I ran `docker info`.

```bash
raygervais@Malachor ~/D/raygervais.dev> docker info
Client:
 Debug Mode: false

Server:
 Containers: 4
  Running: 2
  Paused: 0
  Stopped: 2
 Images: 111
 Server Version: 19.03.8
 Storage Driver: overlay2
  Backing Filesystem: <unknown>
  Supports d_type: true
  Native Overlay Diff: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc version: dc9208a3303feef5b3839f4323d9beb36df0a9dd
 init version: fec3683
 Security Options:
  seccomp
   Profile: default
 Kernel Version: 4.19.84-microsoft-standard
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 12
 Total Memory: 12.45GiB
 Name: docker-desktop
 Docker Root Dir: /var/lib/docker
 Debug Mode: true
  File Descriptors: 59
  Goroutines: 74
  System Time: 2020-04-11T04:14:06.941221Z
  EventsListeners: 4
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: true
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine

WARNING: bridge-nf-call-iptables is disabled
WARNING: bridge-nf-call-ip6tables is disabled
```

I'm not an emotional guy, but I have to admit that I did a fist-pump and small dance after seeing this output. With telescope cloned, `docker-compose up --build` ran like a long lost friend. My morning (well, my 3am Saturday morning) was made.

## Illuminating the Dark With a Pocket Lighter

![Boat Of Docker DevOps Hope!](./images/zoltan-tasi-sJGvoX_eVhw-unsplash.jpg)

Now that ordeal is over, I knew that I wanted to contribute some documentation additions based on the experience and streamline how developers ramp-up to hacking on Telescope when on Windows. That documentation became [this pull-request](https://github.com/Seneca-CDOT/telescope/pull/975) which also included an interesting optimization that I had learned while going through the ordeal. At the start of March, I had landed [this update](https://github.com/Seneca-CDOT/telescope/pull/826) which went about adding Docker's multi-build container workflow to allow for caching of the node_modules (one of the most time-consuming concepts built in the recent decade), but one gotcha still existed: the front-end had to compile on each build due to component's reliance on scripts which existed outside of the front-end directory. Still, we dramatically reduced the build times to an average of 6 minutes compared to the ~12 which it used to be, and even before that reduced the final container size from ~1.6GB to ~250mb in [this addition](https://github.com/Seneca-CDOT/telescope/pull/687). The later I talk about [here](/article/reduced-container-sizes-with-multi-stage-docker-builds/) for those interested. I had little concern that time would improve the `Dockerfile` even further.

Well, as of recent developments that dependency on external scripts disappeared. So, I opted to update the Dockerfile and test the concept of having a cached front-end Gatsby container for those who never touched any of it's codebase. This would reduce the ~3-6 minute build time _PER_ run to only the first run, and from there only seconds if no changes occurred in the front-end itself. This was a dandy change, and easy to test locally (which is what this [pull request](https://github.com/Seneca-CDOT/telescope/pull/948) was for), but impossible to predict how the staging environment would react to the change. Turns out, if you default to developer environments when no .env file is present on the front-end, it'll still act semi-appropriate to the point of fooling your reviewers and yourself. Fun times. That got reverted as quickly as it was merged. Thanks [Josue Quilon Barrios](https://whataboutopensource.blogspot.com/) for helping me debug and verify that.

## TLDR / Those Looking For the Workflow

[See here. :D](https://github.com/Seneca-CDOT/telescope/blob/master/docs/environment-setup.md#windows-10-home-pro-enterprise-or-education-insiders--wsl-2--docker)

## Resources

- [Cover Image: Photo by NASA on Unsplash](https://unsplash.com/photos/Q1p7bh3SHj8)
- [Docker Pull Request for Telescope](https://github.com/Seneca-CDOT/telescope/pull/975)
- [James Inkster's Blog](https://grommers.wordpress.com/)
- [Rafi Ungar's Blog](https://raungar.wordpress.com/)
- [Josue Quilon Barrios' Blog](https://whataboutopensource.blogspot.com/)
- [Windows Central: How to Determine Your Windows Build](https://www.windowscentral.com/how-check-your-windows-10-build)
- [Windows Insiders Program](https://insider.windows.com/en-us/)
- [Installing WSL 2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install/)
- [Docker WSL 2 Preview](https://docs.docker.com/docker-for-windows/wsl-tech-preview/)
