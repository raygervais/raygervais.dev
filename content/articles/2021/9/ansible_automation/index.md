---
title: "Automating Fedora Developer Desktop Onboarding using Ansible"
tags: ["Software Development", "Linux", "Open Source"]
date: 2021-09-23
cover: images/louis-reed-wSTCaQpiLtc-unsplash.jpg
description: "About once a year, I typically wipe out both my Windows and Linux systems, do a clean install and setup them up again with a fresh outlook on the needs of their uses. I find this to be a sane practice given that in a year, there's a whole bunch of junk one may download, install and forget about that was useful at the time. I have good friends like James who follow similar practices, albiet not by their choosing. Twice now I believe he's had to reset his new Dell XPS (first with the provided Ubuntu, then I moved him to the vastly more interested jokes Fedora), and it got me wondering how we could improve the onboarding and setup process."
---

*Nothing screams confidence like being able to setup your Fedora Linux desktop with a few lines of SHELL script and offloading to a dedicated tool*

About once a year, I typically wipe out both my Windows and Linux systems, do a clean install and setup them up again with a fresh outlook on the needs of their uses. I find this to be a sane practice given that in a year, there's a whole bunch of junk one may download, install and forget about that was useful *at the time*. I have good friends like James who follow similar practices, albiet not by their choosing. Twice now I believe he's had to reset his new Dell XPS (first with the provided Ubuntu, then I moved him to the vastly more interested *jokes* Fedora), and it got me wondering how we could improve the onboarding and setup process.

See, from my perspective there's always a list of items that I want on my Fedora machines, majority are often found within the standard repositories and a line or few away. But where's the fun in writing out a big install command such as this?

```bash
sudo dnf install -y \
	golang \
	rust \
	python3 \
	neovim \
	podman \
	kubectl \
	tmux \
	htop \
	...
	ibm-plex-fonts-all \
	jetbrains-mono \
	fira-code-fonts \
```

What if we could over-engineer this ask? What if we could move away from BASH scripts and leverage a concept that dominated the early 2010s: `Configuration as Code`! In the past, I had professionally worked with `Chef` and `Puppet`, and wanted to see how `Ansible` compared. So, taking some instruction from my good friend and fellow Linux geek [Tryton Van Meer](https://trytonvanmeer.dev/) (who had previously written [Ansible scripts for his Arch setup](https://github.com/tryton-vanmeer/dotfiles)), I dove in.

## What is Ansible

> Ansible is a universal language, unraveling the mystery of how work gets done. Turn tough tasks into repeatable playbooks. Roll out enterprise-wide protocols with the push of a button.

## How My Ansible Configuration is Implemented

There's a beauty to open source code, it serves as a great learning opportunity. Tryton's Arch implementation (which was reworked into a more concise Fedora configuration after much convincing on my part for him to try it) was my initial reference point. He had already put in quite a bit of work to implement an optimized Ansible configuration along with the setup scripts which made the process of execution a few line terminal input:


```bash
sudo dnf install git make

git clone github.com/raygervais/dotfiles && cd dotfiles
make setup
make run
```

The above commands focus on three essential parts of the setup process:

1. Install git and make, both of which are needed for the automation
2. Retrieving the dotfiles & Ansible roles git repository
3. Install Ansible from the fedora standard repositories
4. Run our primary developer role!
5. ???
6. Profit!


But, what are we doing? Let me explain my standard Fedora (Gnome since it is the default desktop environment, but I do plan on experimenting with KDE and creating a KDE variant) setup for 2021.

### Role: CLI

This role really emphasizes the `dotfiles`,  containing all my terminal application installations and configurations. This includes:

* `bat`: a `cat` command replacement written in Rust with syntax highlighting.
* `exa`: a `ls` command replacement written in Rust with more customization.
* `fish`: My SHELL of choice. Tryton wrote about his experience with FISH coming from ZSH [here.](https://trytonvanmeer.dev/posts/fish-is-great-dnf-completion/) Overtime, I've written a bunch of fish functions for quicker navigation and command invocation that I always miss when SSHing into a system that uses BASH.
* `git`: Duh.
* `starship`: A shell prompt which overrides Fish and displays useful project metadata. Written in rust btw!
* `tmux`: A terminal multiplexer, which is fantastic for when I want to keep all my context(s) consolidated into a single terminal window
* `alacritty`: A GPU accelerated terminal that I fall to when gnome-terminal performance starts getting me down.
* `neovim`: I'd be insane if I left the standard vim installation present.


For a further read on how I leverage my terminal setup, I recommend this fun read that I had wrote in 2020: [Embracing Terminal-Centric Workflows using Alacritty, Tmux, and Vim](https://raygervais.dev/articles/2020/09/embracing-terminal-centric-workflows/)

### Role: Container

This role installs and configures my container stack of choice!

* `podman`: The Fedora / Red Hat family container engine of choice.
* `containerd`: The container runtime found underneath everything.
* `podman-docker`: Allows for muscle memory of typing `docker ...` to not go to waste.
* `podman-compose`: Integrates docker-compose support into podman!
* `crun`: A fully featured OCI runtime needed by K8s
* `kubernetes`: Because who doesn't want to complicate their projects with modern DevOps tooling?
* `minikube`: An easy way to contain some of the insanity of the previous entry to a single docker instance. Great for local development and testing.

### Role: Development

For every great developer, there must be their tooling & language toolchain installed and ready at all times. Here's my current choice, albeit in a very stark and focused manner.

* `golang`: The language that I picked up out of curiousity, which quickly became a favorite in the past few years.  This one should be no surprise to any reader on my site.
* `rust`: Another language that many have been talking about, and though I was adverse to understand why so many enjoy writing in it, I believe I understand now. Rust is a functional-esque programmer's dream. Plus, it's a standard for writing system applications which always intrigues me.

From there, the next task in this role is to install `Code` directly from Microsoft. This includes importing their `gpg` key and adding the official `vscode` Fedora repository provided by Microsoft. Once that is installed, I have a few (there are many in rotation which I'll omit from here) extensions which are a must have:

* [Nord theme](https://www.nordtheme.com/)
* [Dash integration](https://github.com/deerawan/vscode-dash)
* [Go support](https://github.com/golang/vscode-go)
* [Rust support](https://github.com/rust-lang/vscode-rustdocker)
* [Docker support](https://github.com/microsoft/vscode-docker)
* [TODO highlight](https://github.com/wayou/vscode-todo-highlight)
* [Markdown support](https://github.com/yzhang-gh/vscode-markdown)


Lastly, I install [zeal](https://zealdocs.org/), an offline documentation viewer which I love leveraging (when I remember to) for quick searches.

### Role: DNF

So this role is rather funny because it's one of the first to be ran. The entire purpose of this (which I should rename to make it clearer) is to remove Gnome applications which I never use (or replace with other applications), remove unwanted repositories and add the RPM Free Fusion and RPM Non-Free Fusion repositories.

### Role: Fonts

In [Re: My most notable failures](https://raygervais.dev/articles/2021/5/re_my_most_notable_failures/), I highlighted the topic of always rotating and toying with fonts and color schemes. Well, since writing this, nothing has changed. What has instead been implemented in attempt to reduce some of the choices I have out of the box (and thus, eliminate the distracting illusion of choice!), I challenged myself that when setup through this Ansible configuration, I could only install Fonts which where available through the standard Fedora repositories, or the RPM repositories that were previously added. If I made that rule less granular, it would be easy to add dozens of font repositories and become once again at the mercy of what I'm feeling that day. Here's what I chose based on the choices available:


* `IBM Plex Mono`: This one I find fantastic and highly readable both in the terminal, vim, and vs code. Both Go and Rust look utterly fantastic, and it's unique italicized variants help comments and code stand out. Plus, it has [personality.](https://realdougwilson.com/writing/coding-with-character)
* `Jetbrains Mono`: For the time that I want a less opinionated typeset, this font never disappoints.
* `Fira Code`: Old reliable, for when you just want to go back home where everything makes sense.

### Role: Gnome

This role is probably the most opinionated, and equally the most volatile. I'm changing themes monthly it, but at the time of writing this item I was going through through the purple craving which only [Dracula](draculatheme.com/) can quench. But first, we must ensure the base applications are installed such as Firefox, Gnome Terminal, Nautilus for example.


This role's next file goes over all the customization changes I make to the default Gnome desktop. This includes:

* Installing the [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
* Installing the [Breeze Cursor Theme](https://www.gnome-look.org/p/999927/)
* Cloning & Setting the [Dracula Theme for GTK](https://github.com/dracula/gtk)
* Cloning and setting the [Dracula Terminal Theme](https://github.com/dracula/gnome-terminal)
* Setting the wallpaper to something by [Jr Korpa](https://unsplash.com/@jrkorpa)
* Configuring my window button layout similar to MacOS

Lastly, I install the `Gnome Tweak Tool` application along with the following extensions:

* [Clipboard](https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git)
* [Blur My Shell](https://github.com/aunetx/blur-my-shell)
* User Themes
* Native Window Placement
* [Pop Shell](https://github.com/pop-os/shell)

## Impressions

Compared to the world of `Chef` and `Puppet`, whose primary configuration syntax borrows the best and worst of Ruby -including it's dependency issues, Ansible configuration is written entirely in YAML. Not to sound overly negative, but I cannot express how refreshing of an experience writing Ansible is coming from the other two. 

A practice which differs from the others is the idea of writing "roles" vs configurations. When writing configurations in Chef or Puppet, the idea is to write a single-purpose configuration which encapsulates a very limited scope; Ansible differs where instead a "role" can contain configurations (from my understanding) for multiple applications or contexts. It feels more natural to me, writing a role such as the `Fonts` module that I wrote which encapsulates all font-related configuration.

```yaml
---
- name: Install Fonts for Development
  become: true
  dnf:
    name: "{{ item }}"
    state: present
  loop:
    - "gnome-font-viewer"
    - "jetbrains-mono-fonts-all"
    - "ibm-plex-mono-fonts"
    - "fira-code-fonts"
```

Another item of note, perhaps a placebo, but I also notice a vast performance difference between Ansible's `Python` engine and Puppet's `Ruby`.  Hard to quantify that though given I'm writing and running scripts on various machines vs virtual machines hidden behind firewalls and security processes which slow down various tasks. One can wonder!

## So, Should You Explore Ansible?

```bash
sudo dnf install git make
git clone github.com/raygervais/dotfiles && cd dotfiles
make setup
make run
```

When it's all said and done, it takes me 4 lines on a fresh install of Fedora Gnome to have my normal development environment . I could even add an additional role to clone my commonly-used repositories, but really the idea that I practically have an environment always ready (in the case of breakage) makes me feel like a technical wizard.  James, if you're reading this, I'd highly advise doing similar given your history with Linux.

My next goal: Automate the setup of my MacOS system leveraging Ansible and Homebrew. 

# Resources

* [Cover Image: Photo by Louis Reed on Unsplash](https://unsplash.com/photos/wSTCaQpiLtc)
* [Ansible](https://www.ansible.com/)
* [RayGervais Ansible Dotfiles](https://github.com/raygervais/dotfiles/tree/ansible/fedora)
* [Github: Tryton Van Meer](https://github.com/tryton-vanmeer)



