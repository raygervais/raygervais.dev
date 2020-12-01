---
title: "Visual Studio Code Plugins I Use for Modern Web Development"
date: 2017-11-20
draft: false
tags:
  ["Open Source", "Software Development", "NodeJS", "Web Development", "Setups"]
description: "Visual Studio Code has quickly become my go-to text editor for many languages, even replacing XCode for Swift-centric programs or IntelliJ for light-weight Java programming. This article focuses more on the web development plugins which have provided a smoother experience for the past eight months of my internship at SOTI while learning the ways of the full-stack developer. If you have suggestions or alternatives to the listed plugins, I'd love to hear about it in the comments!"
---

[![Visual Studio Code Setup](./images/Screen-Shot-2017-11-19-at-10.20.14-PM-1024x564.png)](http://raygervais.ca/wp-content/uploads/2017/11/Screen-Shot-2017-11-19-at-10.20.14-PM.png)

Visual Studio Code has quickly become my go-to text editor for many languages, even replacing XCode for Swift-centric programs or IntelliJ for light-weight Java programming. This article focuses more on the web development plugins which have provided a smoother experience for the past eight months of my internship at SOTI while learning the ways of the full-stack developer. If you have suggestions or alternatives to the listed plugins, I'd love to hear about it in the comments!

I'll segregate the list based on the web technology, which will help to separate the primary use case for the plugin via yours truly.

# HTML

## [Emmet](https://code.visualstudio.com/docs/editor/emmet)

I cannot for the life of me explain Emmet via text properly, so instead I'd recommend this video by Traversy Media if you truly want an overview and in-depth explanation: [Emmet For Faster HTML & CSS Workflow](https://www.youtube.com/watch?v=5BIAdWNcr8Y&t=6s). Visual Studio Code bundles this plugin now, but the functionality is available found in almost every IDE and text editor which supports third-party plugins. It has saved me hours of CSS / HTML syntax typing, while also providing fantastic configurability for my coding style.

# Stylesheet

## [SASS](https://marketplace.visualstudio.com/items?itemName=robinbentley.sass-indented)

When not writing in SCSS, I write in SASS. SASS as a language is tenfold more efficient than standard CSS, and compiles down to CSS in the end of the day. The need for this plugin is due to the current lack of built-in support for SASS on a stock Visual Studio Code, and this plugin provides syntax highlighting. The official [website](http://sass-lang.com/) is well documented, and switching between SCSS and SASS for different projects is relatively seamless due to the similar syntax.

## [IntelliSense for CSS class names](https://marketplace.visualstudio.com/items?itemName=Zignd.html-css-class-completion)

Depending on the project, I end up with 100+ class names for specific elements or mundane states which are configured differently. This helps by parsing and suggesting through the IntelliSense engine relevant class names as soon as I start typing.

## [StyleLint](https://marketplace.visualstudio.com/items?itemName=shinnn.stylelint)

Following a well established style guides enable a clean and maintainable project, but up until this point I had not yet learned Style related properties inside out, front to back. This plugin points out redundant styles, non-applicable calculations / dimensions and other issues that my style sheets contain, allowing for a cleaner and less hack-filled workflow.

# TypeScript

## [TSLint](https://marketplace.visualstudio.com/items?itemName=eg2.tslint)

Similar to StyleLint for style sheets, TSLint enables one to adhere to predefined coding guidelines in their TypeScript files. This has been an absolute godsend when working with others, or even keeping myself disciplined in those late hours where lazy 'any' types start to arise. If I could only choose a single plugin to  recommend on this list, it would be this TypeScript linter. It has transformed code bases from mess to organized chaos, and unfamiliar object types to defined and well tested structures.

## [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)

I find that the usage of this plugin derives from my introduction to Firefox's Scratchpad. Because of this common habit of prototyping code in a dedicated scratchpad environment,  utilizing Code Runner in a similar fashion only seemed natural. I found prior to my introduction to unit testing, Code Runner also allowed me to isolate and test functions without having to worry about environmental variables.

# Git

## [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)

This plugin mimics the lens functionality found in Microsoft's Visual Studio, showing last commit detail involving the current line of code. Whether it's quickly figuring out where a new function is introduced, a style class changed, or comments added, this plugin makes the process effortless and efficient. So far, I had yet to see any lag on the system with the plugin active 24/7, and the experience itself doesn't leave me wishing the plugin was anymore less obtrusive than the current implementation. To me, it's a perfect representation of the data I'm interested in seeing as I work with a complex code base.

# Editor Themes & File Icons

## [Material Icons](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)

I found this icon pack to offer the best overall aesthetic when mixed with One Dark Pro or Nord Dark, while also providing a coherent design language which still described the folder structure and file types with ease. Overall, this is one of the first plugins installed on any workstation.

## [One Dark Pro](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)

Having come from Atom before, I actually found their standard One Dark theme quite attractive during the early hours in contrast to Visual Studio Code's dark theme. I still have some gripes with the default background - which, I find is simply too bright on the standard Dell 1080P matte monitor. Still, an excellent theme which deserves all the recognition that is has, and looks utterly fantastic on my 4K screens.

## [Nord](https://marketplace.visualstudio.com/items?itemName=arcticicestudio.nord-visual-studio-code)

Ever since I had discovered Nord, I had discovered a truly amazing color pallet which seemed to have found itself supported 99% of every tool that I'd ever use. From IDE to GTK themes, Nord is supported or being developed with upcoming releases occurring weekly. I highly recommend looking into the repository and projects by Arctic Ice Studios, which is located here: https://github.com/arcticicestudio/nord. For the latest of hours, I typically switch to the settings found [here](https://marketplace.visualstudio.com/items?itemName=sldobri.nord-5-stars) for 'Nord Dark', which simply darkens the background and menus.

# Settings

## [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)

This plugin has become an utter godsend when it comes to working on multiple machines and operating systems while keeping all of my settings, plugins and configurations synchronized. By keeping everything synchronized through a secret Gist, I can focus on learning and optimizing my workflow instead of matching functionally from one workstation to another.

# Conclusion

In the end of the day, I'm constantly trying new plugins and workflows when I find an annoyance or void in my current, so this list is really a snapshot as of recent workflows and settings which work well for my setup. By tomorrow, it could change easily and with that, luckily my settings would synchronize among all devices. This is the beauty of Open Source, that you can mix and match until your heart's content. I love that fact more than words can describe, for it means to me that you are never thrown into the cage with only the plugins provided by the jail staff.
