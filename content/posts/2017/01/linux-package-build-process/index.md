---
title: "Linux Package Build Process"
date: 2017-01-19
published: true
tags: ["Open Source", "Seneca", "SPO600",]
description: "Today we learned how to build GNUChess from source" 
---

# Code Building on Xerexes (x86_64)

SPO600 Week 1 Code Building Deliverable

GNUChess

1. Download newest file directory of gnuchess from ftp://alpha.gnu.org/gnu/chess/gnuchess-5.9.90.tar.gz 
2. Unpack into playground using `gzip -d`, followed by `tar -xf` 
3. Ran ./Configure which presented no issues. I think someone else has already installed this packaged before 
4. Ran `make`, followed by `make install`. 
5. Had to specify a local directory for the install files to avoid the program attempting to install itself globally on the server. 
6. In the src folder, copying the `gnuchess.ini` file to the specified folder (because it does not copy correctly?) is required to run the application. 
7. Enjoy terminal chess by running `./src/gnuchess`

## VIM

1. Cloned the git repo from github.com/vim/vim into my plaground directory 
2. Ran ./configure --prefix=/home/####/playground/vim_install for predefined install directory 
3. Ran make, followed by make install. 
4. Vim runs perfectly by running ./src/vim
