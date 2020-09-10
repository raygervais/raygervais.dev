---
title: Embracing Terminal-Centric Workflows using Alacritty, Tmux, and Vim
published: true
date: 2020-09-10
cover_image: ./images/kilyan-sockalingum-8NH2_f5TxAA-unsplash.jpg 
description: ""
tags: ["Linux", "Vim", "Tmux", "Terminal", "Experiments"]
---

_Or, How To Look Like A Hacker at Starbucks_

I've long been inspired by the often beautiful -yet vastly nonfunctional- desktop setups found on /r/UnixPorn and other Linux-based forums. Often, _starterpacks_ describe a aesthetic and futuristic configuration to comprise of `Arch Linux`, `i3-gaps`, terminal-based interfaces, and `Vim`.

The terminal applications have intruiged me for as long as I've been a developer, -the bias being that the terminal will always be faster than GUI-based interfaces and processes. In some workflows, I 100% agree and wanted to explore how far I could get. This experiment would expand to not just my personal laptops and desktop setups, but also my development workflow while working! -No- Some pressure, that's for sure. The real reason why I want to explore is also to reduce the amount of context switching which results in dozens of terminal tabs being open and forgotten about over the course of the day. Instead, I can dynamically creating and closing as I need on a single pane. 

For this experiment, I'm going to be using Fish as my Shell, Alacritty for my Terminal emulator, Tmux for session/pane management and Vim as my text editor. Let's get started with the Shell. I find Fish to be faster thanks to it's autocompletion, hinting and prompt customizations compared to BASH; it fits in perfectly with my terminal-centric goals. Once installed via your standard repository, some customizations I had made including adding the following functions: 

| Function | Implementation | Reasoning | 
| - | - | - |
| cdev | | I end up doing `cd ~/devel` (or similar) quite often, why not make a shortcut? |
| gpm | | For when you're working in a git repository and want to grab the latest changes from master. Which I do daily. |  
| gpo | | For when you're really lazy and just want to do a `git push origin` with your branch |

## Vim

It goes without saying, that I have a love/hate relationship with this iconic editor. When SSH'ed into a machine, connected to a Docker container or debugging pipelines, my goto tool has always been Vim for both editing and going through files. Every week, I learn something new -often by accident- that improves my workflow and draws awe from others. Did you know with `wc`, you can replace an entire word without having to delete it first and be dropped straight into insert mode? I really should do Vimtutor at some point! Plus, isn't it always grand to be apart of a topic which drives holy-war levels of argument and fragmentation among developers? Don't get me started on the Nano advocates *coughs* Ali *coughs*.

## Alacritty

![Terminal Forever Comic by CommitStrip](https://www.commitstrip.com/wp-content/uploads/2016/12/Strip-Lignes-de-commande-english650-final-2.jpg)

GPU-accelerated terminal emulator. I would never have thought of such an application description last year, and then I discovered the open source project Alacritty. The idea didn't make sense to me at first, but after watching DistroTube's overview and explanation of what makes Alacritty so fast I had to test it myself. Installing is simple via `apt`, or your prefereded package manager of choice and all can be configured via the `alacritty.yaml` file found often in your home directory. From there, it was a matter of putting the terminal through it's paces if I were to deem it an asset for the terminal-driven experiment -afterall, the terminal is quite the most important aspect to this. Oddly enough, even after testing similar to Derek with `ls -laR` on my root and being impressed at the fludity on both my five-year old Dell XPS and newer Desktop setup, it was the fludity and responsiveness of editing in Vim where I truly notice the smoothness. I'm an odd one, I know.

For those curious, I've included my (initial) Alacritty configuration file which I customized to leverage the following so far: 

- Fira Code as my primary font
- Fish Shell
- Inksea Dark color theme (more on that below)
- 12dp padding for both X and Y

So, we have our terminal, but what will it house? 

## Tmux

## Color Theme

Similar to `/r/unixporn`, I too have found a comfort in having a shared aesthetic and color scheme among all my applications and interfaces -I imagine it's why Apple is revered in the design world, since iOS and MacOS often follow each other in tandem as they share UI elements and interface semantics. I often achieve some semblance of this when on Linux (more often compared to Windows) thanks to GTK or QT themeing, or MacOS with native applications. My favorite Gnome theme which embodies much of the color choices I enjoy is `Orchis`, or on the KDE front, `Layan`. `Dracula` for both Gnome and KDE do look quite appetizing, and moreso is availble everywhere on almost any application which supports theming. But, this post is on terminal-based interfaces so let's focus. 

Dracula themes can be found for Alacritty, Fish, tmux, and vim; so that's what I set up. On vim, I found the semantic highlighting color choices to be hit or miss depending on language which created a rather janky experience at times. Maybe I'm being picky, but the bright colors I also didn't jive with as much as I thought I would. It's great in VSCode on my MacBooks (oddly enough), but when open in Linux or VS Code the colors just look like a rainbow exploded with yellows and purples all over the place. So, though I still run it on my MacBook, I opted to try a different approach: port over a recent VSCode theme that I've been using on my non-MacOS systems: inksea dark.


# Resources

- [Cover Image: Photo by Kilyan Sockalingum on Unsplash ](https://unsplash.com/photos/8NH2_f5TxAA)
- [UnixPorn Starter Pack](https://www.reddit.com/r/starterpacks/comments/9qjrm1/runixporn_starter_pack/)
- [UnixPorn Subreddit](https://www.reddit.com/r/unixporn/)
- [Fish Shell](https://fishshell.com/)
- [Alacritty](https://github.com/alacritty/alacritty)
- [Tmux](https://github.com/tmux/tmux/wiki)
- [Vim](https://www.vim.org/)
- [dotfiles](https://github.com/raygervais/dotfiles)

