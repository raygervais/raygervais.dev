---
title: "Experiment: Moving to Pop!OS For A Month"
Cover: "images/pawel-czerwinski-RBr5vfWUlec-unsplash.jpg"
draft: false
date: 2020-03-02
tags:
  [
    "Open Source",
    "Linux",
    "Pop!OS",
    "Microsoft",
    "Windows",
    "Software Development",
    "Experiments",
    "Life Updates",
  ]
description: "As of this past weekend, which marked the start of March and what appears to be kinder climates, I opted to conclude the one year experiment and evaluate the state of the Linux desktop in comparison for a month. Though Windows itself wasn't giving much grief, there were still workflows and quirks that I truly never got over; likewise developing with WSL 2.0 proved to be quite the abstract objective than I thought which led to quite a bit of productivity-loss. I still quite enjoy the concept of Windows Subsystem for Linux, and feel that if I had started using it from day one instead of dropping it into a pre-existing `GIT-BASH` setup that things would be quite smoother. Curiously, I have plans to test exactly that If I end up returning to Windows 10 in the near future. Regardless, I have to work with CentOS, Red Hat and Fedora systems daily at work -which, encourages me to run a similar system for both my home an development environments. Such familiarity truly can help produce fantastic results when enveloped in a unified mindset among different."
---

_Lets See if Ray Can Avoid Starting a Flame War Before The Third Paragraph!_

## The One Year Experiment

Around the beginning of 2019, I opted to use Windows 10 as the only operating system on my desktop -an unheard-of choice for those who know me best. My outlook on the challenge could be summed up into the following thought questions and points:

- Well, I'll finally be able to game with the roommates (windows-exclusive games...) and bond with them through this.
- Let's see how Windows 10 feels after four years of updates and feature releases.
- How hard could it be, given that Microsoft has been pushing for better developer support, tooling, and "openness" under Satya's direction?
- Is this the year that I'll adopt and learn Powershell as my primary shell? -No, I'll answer that one right now and say that I didn't get the chance to learn PowerShell.
- Will I be more productive in this environment compared to my \*Nix environments?
- Am I capable of accepting that a fresh clean install of Windows 10 came with Netflix, Candy Crush, and Dolby Audio preinstalled? -No. Never will be able to accept this.

As of this past weekend, which marked the start of March and what appears to be kinder climates, I opted to conclude the one year experiment and evaluate the state of the Linux desktop in comparison for a month. Though Windows itself wasn't giving much grief, there were still workflows and quirks that I truly never got over; likewise developing with WSL 2.0 proved to be quite the abstract objective than I thought which led to quite a bit of productivity-loss. I still quite enjoy the concept of Windows Subsystem for Linux, and feel that if I had started using it from day one instead of dropping it into a pre-existing `GIT-BASH` setup that things would be quite smoother. Curiously, I have plans to test exactly that If I end up returning to Windows 10 in the near future. Regardless, I have to work with CentOS, Red Hat and Fedora systems daily at work -which, encourages me to run a similar system for both my home an development environments. Such familiarity truly can help produce fantastic results when enveloped in a unified mindset among different.

![Microsoft Developers Dancing OnStage to New Release](https://media.giphy.com/media/l3q2zbskZp2j8wniE/giphy.gif)
That being said, before I discuss the move, let's go over some of my thoughts to the above points and let me amend to the tone of this article by saying: **This is not a complaint against Microsoft, Windows, or anything inbetween! I simply love diving into different technologies and evaluating their function, usage, and concepts to the degree that I can compare and improve upon them with past experiences**

- Playing games with the roommates without having to worry about system compatibility (and not wanting to mess around with Proton at the time) was a fantastic release of concerns. We played an unhealthy amount of Rocket League and Rainbox Six Siege up until I removed Windows from the computer. I think subconsciously, I'm moving away to also restrict the amount of games that I'm able to play and so that I can focus on other things in consequence.
- Windows 10 is much smoother nowadays after four years of updates. If my memory serves me right, I didn't even have to go driver hunting after the first setup for almost any of the hardware. I did fall victim to the broken Windows Search bug, along with the Windows Mail indexing bug which almost burnt out my SSD, but bugs such as these could happen anywhere realistically.... Apple's wiped my entire MacOS setup once due to a corrupted update!
- I don't have to tell you how amazing Visual Studio Code is, the numbers and popularity it's been gaining since release speaks for itself. It appears that every release adds new features without adding additional weight to the editor. Though I yearn for a native editor (there's no such thing better than a native application in my opinion), I certainly enjoy using VSCode whereever the opportunity presents itself. Golang, no problem. BASH? Easy. Ruby..., it's a gem! From a different context, I've developed quite a few applications and scripts utilizing Microsoft Azure's SDKs and ARM templates for the past year, and can say that I do enjoy utilizing the platform and it's various modules. Their documentation is easily catching up with MDN, and the majority of the platform being open source is a fantastic plus! I even looked at contributing to their CLI similar to what I did in 2018, but time was not on my side. I'm truly impressed with the direction Satya has taken Microsoft, and look forward to seeing where they go next.
- Was I more productive? Well, I'm going to leave this one openended and say that for each benefit and convenience, there was equally a hassle and stumble somewhere else. See my earlier WSL comments, but I am very curious after March to compare. Curse you Scott Hanselman and [your WSL tutorial of awesomeness](https://www.youtube.com/watch?v=A0eqZujVfYU)!

## Why Pop!OS? Why Not ....?

![Old Computer on Fire](https://media.giphy.com/media/PkVpoRawXYW5i/giphy.gif)

I've been following System76 for a few years now, and have come to really respect their company's approach to products and support: Improve upon the foundations, and make it better for the next guy. Their Ubuntu fork `Pop!OS` is a great example of this; incorporating various projects such as Elementary's AppStore, Gnome Extensions, and Nvidia Drivers (_to name a few_) into a comprehensive desktop operating system while also allowing for others to contribute and push the changes upstream. I could compare this approach similarity to Apple's product feature releases, which often are found elsewhere in less-refined implementations... but let's not compare the two any further. That would be a disservice to both communities and an offencese that I don't mean to bestow upon them. Likewise, I also wanted to give `Pop!OS` a shot because of the thoughtful defaults and configurations which System76 baked into their system. Just as Ubuntu adds their own flavor on top of the Gnome Desktop (RIP Unity), Pop!OS does similar with (in my opinion) more sane defaults and package catelogs.

> Truthfully, a few YouTubers who I try to stay up to date with had also released videos on Pop!OS which captured my attention more-so than most other videos could. They explained -both through opinion oof their successes and failures- from a non-Linux-centric setting the current state of Gnome and the Linux Desktop for achieving their requirements. SnazzyLab's video really did capture quite the interesting light for Video Editing on Linux when Windows failed to satisfy the requirements. Those videos were:

> - [We Ditched Mac Pro for This... ](https://www.youtube.com/watch?v=P2dACq3F_W4)
> - [A REALLY Weird PC… - System76 Thelio Review](https://www.youtube.com/watch?v=JTN1c1j6V1s)

Finally, I'm simply curious. Having used Fedora 2X-31 on my Laptops I had interests in venturing outside the `RPM/YUM/DNF` centric systems and wanted to either: utilize a Debian base for package support, or return to a rolling release (Fedora did this well, hence workstation was my default operating system of choice) such as Manjaro / Solus.

## All Is Not Set In Stone

This is an experiment! I wouldn't consider this anything other than that. One issue that I've been running into off and on for the past two years since building my computer (and after reinstalling the OS for the first time) is a constant stutter / lag at sporadic times. The frequency of this differs quite a bit, so I'm hoping to debug and try to deduce the issue itself while on the challenge; praying that a part isn't dying on the machine. With that, these debugging moments may conclude on different distros being tested since they each interact and contribute differently to the various packages which makeup a Linux Desktop. More-likely, I may go literal window shopping incase I just lose patience and `yeet` the system out the window like the Gentleman I am _/s_. Likewise, this isn't exclusive to Linux either, if you go deep into my Tweets from 2018-2019, you'll see how frustrated I was running into this issue even on Windows 10... the issue at the time I had discovered was all my email from the past eon was synced and downloaded in abundance to an nonsuspecting harddrive.

## So, What Did I Setup?

Here is a list of the current configuration, which I'm sure will evolve quicker than Tensorflow models run on dual-core system.

![Pop!OS System with Neofetch displaying in Terminal and common Dock applications listed](./images/neofetch-clean.png)

- Containers: Docker
- Languages: Golang, Node, Python3.7
- Editors: Visual Studio Code, VIM
- Fonts: Fira Code, Victor Mono
- Icons: Papirus-Dark
- Extensions: Dash-to-Dock, gTile, Clipboard-Indicator
- Social: Telegram, Cawbird, Slack
- Music: Spotify
- Email: Geary
- Terminal: Gnome Terminal

![Pop!OS System Visual Studio Code open and Firefox](./images/desktop-busy.png)

## Resources

- [Cover Image: Photo by Paweł Czerwiński on Unsplash](https://unsplash.com/photos/RBr5vfWUlec)
- [Hit Refresh](https://www.amazon.ca/Hit-Refresh-Rediscover-Microsofts-Everyone-ebook/dp/B01HOT5SQA)
- [System76 - Pop!OS ](https://system76.com/pop)
- [We Ditched Mac Pro for This... ](https://www.youtube.com/watch?v=P2dACq3F_W4)
- [A REALLY Weird PC… - System76 Thelio Review](https://www.youtube.com/watch?v=JTN1c1j6V1s)
