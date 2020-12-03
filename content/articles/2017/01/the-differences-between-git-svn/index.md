---
title: "The Differences between Git & SVN"
date: 2017-01-19
draft: false
tags: ["Open Source", "Seneca", "OSD600"]
description: "With the start of the new year, and a semester which contains a promising set of courses that many are excited for, it's appropriate that open source technologies have become the leading topic of this semester."
---

OSD600 Lecture Summary

Subversion (SVN) technologies used to be the go to for version control among developers, providing a workflow that many web developers endorsed comprising of a trunk directory which represented the latest stable release, and sub directories for new features that was labelled under individual branches in the directory structure. Furthermore, SVN utilized a centralized revision control model, citing this model would enable developers to have access to each part of the code base.

## SVN

An Open Source technology licensed under the Apache license, but even with developer contributions the platform was limited in functionality and features. In recent years, SVN 1.8 attempted to remedy some of these limitations client side, while the server side repository followed SVN 1.5 operations. This included the concept of “renaming files” being a loosely stitched together feature which pre-1.8, would copy the file with the new name into the same directory, then delete the old file.

## Git

Created by Linus Torvalds quickly gained traction in the developer community for being more robust, feature-dense, and containing a workflow that was much more flexible in contrast. Git was built around the distributed revision control model, which allowed developers to work on separate branches and code bases without fear of destroying previous work. Git is now the leading version control system, employed across local and server repositories all over the world.
