---
title: "The Open Source Audio Project (Idea!)"
date: "2017-10-09"
---

Hello there! If you're not new to blog, or I haven't changed any of the main headings for the website at the time of this article, you'd be aware just how big of an advocate I am of FOSS technologies on our everyday mediums. Android devices running AOSP-centric ROMs, Linux workstations running Fedora 26, and my non-FOSS hardware running as many OSS technologies as possible such as Inkshot, Visual Studio Code, Kdenlive, Firefox, etc. Ironically, the one theme which I hadn't played with for a few years now was audio production in an open source environment.

Why is this ironic? Because audio production is what first introduced me to Linux & FOSS technologies. In my cheap attempt to find a well developed & refined DAW which could be legally accessible by a high schooler, I discovered Audacity, Ardour, LMMS, and Muse; all of which pointed the way towards Ubuntu, Open SUSE, Fedora, and Linux itself. My world changed quickly from these encounters, but I always turned back to Cubase, FL Studio, Studio One when I wanted to record or mix a track for a friend.

Recently, a fellow musician and close friend had successfully encouraged me to get back into playing, recording, and mixing. It had been at least two years since I took such a hobby so seriously, but with his encouragement my YouTube playlists quickly became packed with refresher material, mixing tips, and sounds from the past. In consequence, We recorded in the span of a single day a cover of Foster the People's 'Pumped Up Kicks'; vocals done by the impressive Shirley Xia. The track can be found here for those curious: [Pumped Up Kicks - FtP Cover by Ray Gervais](https://soundcloud.com/ray-gervais-711531601/pumped-up-kicks-ftp-cover)

It was recorded & mixed in a Reaper session which turned out much better than expected with only the use of stock ReaPlugins. This begged the question, which would hit like a kick drum over and over all week, could this level of production quality be possible using only FOSS? Would Ardour be able to keep up with my OCD for multi-tracking even the simplest of parts?

# The 1st Idea

First idea is to export the Reaper stems as .WAV files into Ardour, and get a general mixing template / concept together based on previous trials / settings. This will also help me to confirm the quality of the native plugins, and if I should be worried about VST support in the case the native plugins don't meet the sound which Reaper did. I'm both incredibly nervous and excited to see the end result, but fear that most of the time will be spent configuring & fixing JACK, ALSA, or performance issues on the Fedora machines.

If all goes well, I'll probably upload the track as a rerelease mix with the settings used & various thoughts.

# The 2nd Idea

Recording a track natively (via MBox 2 OSS drivers) into Ardour, and compose, mix, master all using Ardour & open source software exclusively. I feel obligated to point out that if I were to use VST for any reason, they must be freeware at a bare minimum. No paid, freemium, or proprietary formats (looking at you Kontakt).

I wonder if genres which don't demand pristine sounds such as lo-fi, ambient, post-rock, or even IDM would be easier to manage compared to that of an indie sound, or a angry metal sound. My first test would be probably dwell in the electronic genre while I setup the recording interface to work best with the configuration (reducing latency where possible, dealing with buffer overflows).

# DAW Applications & Considerations

In this small conclusion, I simply want to list the other possible applications / technologies to consider in the case that the primary ones mentioned above do not work as intended.

## DAW (Digital Audio Workstation) Alternatives

- Audacity: One of the most popular audio editors in the world, known for it's simplistic interface, ease of use plugins, and it's usefulness as a audio recording application for mediums such as podcasts, voice overs, etc. I've only used Audacity twice, both times just to experiment or to record a quick idea on the fly. See, Audacity isn't mean to be the direct answer to common DAW paradigms such as track comping. It's not meant to be used to fix a bad rhythm either.  Source code: [https://github.com/audacity](https://github.com/audacity)
- LMMS: A open source alternative to FL Studio. Useful for sequencing, and has built in VST3 support as of recent versions. I had used LMMS in the past for quick ideas and testing chords out through various loops, and dismissed using it further due to stability issues at the time (Circa 2013). I'm curious what state the project is in now.  Source code: [https://github.com/LMMS/lmms](https://github.com/LMMS/lmms)
- Qtractor: A multitrack audio and MIDI sequencing tool, developed on the QT framework with C++. This DAW I am the least experienced with, but some seem to endorse it for electronic music production on Linux.  Source code: [https://github.com/rncbc/qtractor](https://github.com/rncbc/qtractor)

I'm excited for this experiment, and hope to follow up in a much more frequent article release period. My only concern is the end product, and if I'll have a listenable song using only OSS that is not subpar in quality. Documenting the process will also help myself to understand the strengths and drawbacks to this challenge. Even if just doing a modern remix of the original track would be a unique experience, since I have all the recorded stems in multitrack format already. Can't wait to start!
