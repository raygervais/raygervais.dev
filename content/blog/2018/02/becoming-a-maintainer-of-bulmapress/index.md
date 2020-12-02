---
title: "Becoming a Maintainer of BulmaPress"
date: 2018-02-03
draft: false
tags: ["Open Source", "CSS", "WordPress", "Theme"]
description: "I love Bulma, I love contributing to projects instead of spinning up my shoddy implementation of a need, and I love when the two come together in such harmony it's as if fate meant it. I discovered BulmaPress while looking for Bulma / Non-Bootstrap WordPress themes for a CMS project I'm working on. It looked to be relatively abandoned, sporting an old version of Bulma 0.2.1 and last being updated half a year ago."
---

I love Bulma, I love contributing to projects instead of spinning up my shoddy implementation of a need, and I love when the two come together in such harmony it's as if fate meant it. I discovered BulmaPress while looking for Bulma / Non-Bootstrap WordPress themes for a CMS project I'm working on. It looked to be relatively abandoned, sporting an old version of Bulma 0.2.1 and last being updated half a year ago.

Still, this didn't deter developers including yours truly from forking and fixing or updating; a relatively painless experience since the project was built on-top of the underscores project, providing a solid foundation which only needed the Bulma part to be updated instead of the WordPress theme functions. It took several iterations to get the modern Bulma navigation pattern to work as expected, but once that was in place (you can see the code change required [here](https://github.com/teamscops/bulmapress/pull/9)), the rest fell much quicker.

Instead of keeping the fix to myself, I decided that any updates should make it upstream to benefit other users who discover the project. These fixes included removing the outdated Bulma code (replaced with a CDN), fixing the [SASS compiler](https://github.com/teamscops/bulmapress/pull/10), and now writing a stable override structure which provides easy modification of Bulma [variables](https://github.com/teamscops/bulmapress/pull/12).

The SASS was priority in my mind after correcting the navigation since no one sticks with the defaults, almost ever. Writing in CSS is a pain when it's a full website theme, and once you learn SASS, SCSS, or LESS, CSS functions like assembly in comparison. Literally! For my project, I also needed the SASS configurable since this project would involve multiple different overrides and branding elements too.

As my first contribution got merged in, I became a contributor to the project and was also promoted to maintainer (meaning I could merge, triage etc). It's a cool experience to see yourself at the top of a contributor board on an abandoned project: https://github.com/teamscops/bulmapress/graphs/contributors. The numbers do seem off, but I'll let the GitHub magicians assume what they will about code changes. Later on, I'd begin to have questions tweeted or emailed to me on BulmaPress, which was another cool moment because I realized this abandoned project still had love from developers who perhaps like me, needed exactly it.

This is my first time working inside-out on a WordPress theme, my only previous experience being changing the default layout of the theme to support Bootstrap headers for a client two years ago. Working with only foundation, knowing that everything else can change if needed was an opportunity that I didn't expect from BulmaPress. I had different 'implement this feature so you can use it' styled expectations, not so much 'update this because a lot has changed in recent years'. There is still a lot to update and fix, such as the `navwalker` used for multi-tiered navigation menus (Which I don't believe ever worked to begin with according to comments in the code), and fixing the demo domain issue where you which expired in January.
