---
title: "Writing Good Contribution Messages"
date: 2017-03-16
published: true
tags: ["Open Source", "Seneca", "OSD600"]
description: "On Tuesday, the class was told a key fact that I imagine not a single in the room had ever thought before; commit messages, pull requests, and even issue descriptions, are the sole most challenging item for any developer to get right. This was in the context of working in an open source community. I was curious, so I looked into my pull request titles, commit messages and pull request descriptions."
---

**An OSD600 Lecture**

# My Contribution Messages

On Tuesday, the class was told a key fact that I imagine not a single in the room had ever thought before; commit messages, pull requests, and even issue descriptions, are the sole most challenging item for any developer to get right. This was in the context of working in an open source community. I was curious, so I looked into my pull request titles, commit messages and pull request descriptions. I’ve included a few of each below for the curious:

## [Fixed package.json to include keywords](https://github.com/isaacs/node-glob/pull/317)

### Issue Description

I noticed that you did not have keywords for this module, so I added ones that seemed relevant. If you'd like others, or different ones, I'd be happy to add them. (Relating back to the fixed package.json to include keywords pull request)

### Commits

- Added keywords to package.json
- Updated package.json to include keywords (formatted properly)
- Fixed spelling of Utility in Keywords

## [Implements Thimble Console Back End](https://github.com/mozilla/brackets/pull/624#pullrequestreview-26614900)

### Issue Descriptions

This is the first step toward implementing the suggested [Javascript console](https://github.com/mozilla/thimble.mozilla.org/issues/1675)

### Commits

These are all based around the Thimble Console enhancement mentioned above, with each commit deriving from my add-new-console branch (which I may add, according to Mozilla’s repository standards, is not a good branch name, and instead should be named “issue ####”).

- Added ConsoleManager.js, and ConsoleManagerRemote.js.
- Added ConsoleShim port. Not Completed yet.
- Added data argument to send function on line 38 of PostMessageTransportRemote.js
- Removed previous logic to PostMessageTransportRemote.js
- Added ConsoleManager injection to PostMessageTransport.js
- Syntax Fix
- Fixed Syntax Issues with PostMessageTransportRemote.js
- Fixed Caching Reference (no change to actual code).
- Added Dave’s recommended code to ConsoleManagerRemote.js
- Added consoleshim functions to ConsoleManagerRemote.js
- Added isConsoleRequest and consoleRequest functions to consoleManager.js
- Changed alert dialog to console.log dialog for Bramble Console Messages.
- Fixed missing semicolon in Travis Build Failure.
- Removed Bind() function which was never used in implementation.
- Removed unneeded variables from ConsoleManager.js.
- Fixes requested changes for PR.
- Updated to reflect requested updates for PR.
- Console.log now handles multiple arguments
- Added Info, Debug, Warn, Error console functionality to the bramble console.
- Implemented test and testEnd console functions.

### Looking Back

Analysing the commit messages alone had shown that though I tried, my commit messages alone were not as developer friendly, a contradiction to a few-weeks back me who thought his commit messages were the the golden standard for a junior programmer. Perhaps a fusion of previous experience and recent teachings, but there is a definitive theme to the majority of my commit messages -often describing a single action or scope. This was a popular committing style among some of the professors at Seneca, and even Peter Goodliffe who wrote the must-read Becoming a Better Programmer claims short, frequent commits that are singular in changes or scope as a best practice. The issue which can be seen above, is not that I was following this commit-style, but the I described in the commit. Looking back now,

removed bind() function which was never used in implementation

would be arguably the best of the commit messages had I not included the ‘()’. Here is why:

1. It address a single issue / scope, that being the dead code which I had written earlier.
2. Explains in the commit message the reason for removing the code, making it easier for maintainers to get a better sense of context without viewing the code itself.

There are some items I’d improve from that commit message, such as rephrasing ‘which was never used in the implementation’ to ‘which is dead code’. This is being much more specific to the fact that the function is never being used, whereas the current message is claiming only in the current implementation alone is it not used. Much clearer.

Furthermore, I think it’s clear that the pull request messages are simply not up to a high enough standard to even be considered ‘decent’. This area is one that I will focus on more in the future, for it is also the door between your forked code, and the code base you’re trying to merge into. Not putting a worthwhile pull request description which provides context for the maintainers, an explanation of what the code does and even further comments or observations which may help down the road.

To conclude this section, I’ll touch briefly what was the most alien concept to yours truly, and how this week’s lesson open my eyes to developer and community expectations. Regardless of commit messages, one of the most important areas to truly put emphasis on is the Pull Request title, which is what you, the maintainers and code reviewers, and even the community see. Though mine encapsulate the very essence of what my code’s purpose is, the verbosity may be overlooked or identified as breaking a consistent and well established pattern; which is the ‘fix #### ’ pattern. This pattern allows for GitHub to reference said issue in the pull request, and close it when the request is merged into the master branch. My titles did not follow said pattern, meaning that a naive developer such as yours truly would reference the issue itself in the description, which means the code maintainer also has to find your issue and close it manually after the merge.

## Suggestions

Dave shared with us this [link](https://github.com/mozilla/thimble.mozilla.org/pull/1559), describing it as one of the best pull requests he had discovered from a contributor. Analysing it, it was apparent that the contributor put effort, time and energy into everything related to his code and description. His outgoing and enthusiastic style of writing was mixed with humble opinions and emojis, creating a modern piece of art; mixing color and text, before and after, code. His commit messages follow a playful theme where appropriate, and a much more to-the point description where essential (such as major code changes). Looking back now, I can see why Dave and a few others regard this pull request as a pivotal teaching tool for proper documentation techniques when working in an open source community.

Such suggestions are not aimed at the hobbyist or junior developer alone, for a quick search of various popular open source projects points out that all developers struggle with the above at times. An interesting note, since we as juniors also strive to emulate the style of said more experience, creating a trickle-down effect at times. This isn’t to point the flaws of bad messages to the average programmer, or senior developer, but to simply share it with those who’ve been in the industry as well. We are all at fault, and the learning experience is eye-opening.
