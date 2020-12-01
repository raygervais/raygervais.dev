---
title: "When Segfaulting Won’t Do"
date: 2017-03-23
draft: false
tags: ["Open Source", "Seneca", "SPO600"]
description: "Sometimes, you have a great idea which may improve one of the worst processes a developer routinely experiences over and over, and sometimes your idea is so grand that reality escapes your grasp quicker and quicker with each passing second. This is what I had come to realize after discussing with Chris how I could benchmark my updated segfault function, to which his response was simply, “why?”"
---

_An SPO600 Project Update_

Sometimes, you have a great idea which may improve one of the worst processes a developer routinely experiences over and over, and sometimes your idea is so grand that reality escapes your grasp quicker and quicker with each passing second. This is what I had come to realize after discussing with Chris how I could benchmark my updated segfault function, to which his response was simply, “why?”

It seems, that in my excitement to optimize a common issue, I never thought to wonder if it would make a difference. I don’t mean the performance metric, but I mean to the developers. Segfault is not an attractive state to have in your code, nor is it a ‘feature’, so why would I improve a system which would not benefit the developer in anyway aside from shaving a few nano seconds off of their application’s crashing descent into a closed state? Chris raised quite a few points, expanding on the above and also looking into the code and quickly estimating the differences being negligible at best for the upstream developers; a factor which would make the persuading of said developers of the relevancy of my optimizations more difficult.

So, with my original suggestion being shelved, it’s time to look for a new function! That also means that, once I do find a new one; and granted it can be optimized, I’ll post about said optimizations or what I’m thinking. Hopefully, this is the last time I have to search in the GLibC library since I’d argue 80% if not 85% are very well optimized already.
