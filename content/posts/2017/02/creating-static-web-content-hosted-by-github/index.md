---
title: "Creating Static Web Content hosted by Github"
date: 2017-02-04
published: true
tags: ["Open Source", "Seneca", "OSD600", "Version Control"]
description: "When we were given the instructions to search, locate and eventually implement fixes or upgrades to Mozilla’s Thimble or Brackets, I found what perhaps was the most challenging enhancement I could possible implement."
---

_OSD600 Week Four Deliverable_

Developers, programmers and even the occasional hobbyist are a hot topic this decade, knowing just their contributions alone can shape modern day enterprises and the technological stack of tomorrow’s gadgets. Google, a company familiar to anyone who’s rejected the living-under-rocks lifestyle is renown for providing their employees with perks that make even the most well-established yearn for. Perks so unique and sometimes life changing in fact, that they influence your reasons as to why you’d ever need anything else -or seek anything else.

It’s no secret that corporations attempt to entice as many developers as they can with perks, platforms and offerings that can sway even the hobbyist to their side. Github, the ‘go to standard’ of all forms of version control hosting has played their own moves in the same game, with the ever-so-popular Github Pages being their first means of developer seduction.

Created to ‘celebrate’ your projects, this platform allowed one to host a static website directly from their respective repository without too much work. These static websites allowed for elegant, simplistic means of conveying content, project details and relevant information for developers to pour their celebrations, contributions and modifications into with ease. Because they are legitimate, static web pages, even search engines provide promotion and easy discovery of your project at no extra cost.

For this week, our assignment was to go through a obstacle course of instructions, related to Git which would come to a closing Github Page being published under a forked Spoon-Knife repository. The first task was learn how to interact with branches, starting with commands such as:

```bash
git checkout -b new-branch
git show new-branch
```

After, we were granted the unfortunate opportunity to work with unfriendly git merges, all the while creating more branches to add to the chaos. By the end of the assignment, too many branches were created (a few on my part due to ‘experiments’) than should have existed. To remedy this issue, I quickly consulted Google’s wisdom which suggested:

`git branch -d branch_name`

Which would delete a local branch. Deleting from a remote branch it suggested, would look like the following:

`git push origin --delete`

Once the merging madness was complete, it was time to show off this item to the world. After converting the animals.txt file which we used above to HTML, the next step was to commit the file to this unique branch, `gh-pages`

Once this was done, the page was accessible just like a standard web page using the following link: https://raygervais.github.io/Spoon-Knife/animals.html. I must promote this work of art here for I doubt Google’s web crawlers will value mine above the _EXACT SAME FILE_ as my peers. Regardless, this introduction to Github’s Pages was an interesting lesson which I’m certain will be valuable for future projects.

## Common Git Commands

Command

Description

- `git init` - Creates a new local repository in the current directory
- `git clone username@host:/path/to/repository` Create a working copy of a remote repository
- `git status` - List tracked changes in your files on the current branch
- `git checkout -b` - Create a new branch, then switch to it
- `git tag 1.0.0` - Mark a release or changeset in the repository

For more commands, I'd recommend referencing [Atlassian's](https://confluence.atlassian.com/bitbucketserver/git-resources-776639766.html) resources
