---
title: "Learning From Two Mistakes How Easily You Can Halt Production as a Software Developer"
date: 2017-09-17
published: true
tags: ["Lessons", "Software Development", "NodeJS"]
description: "Wow. That is quite the mouthful of a title; a title appropriate for one who's position is described between an intern and full-stack developer with less than two years under his belt."
---

Wow. That is quite the mouthful of a title; a title appropriate for one who's position is described between an intern and full-stack developer with less than two years under his belt.

First, some background context symbols which will be found throughout the article:

- ${SD}: Senior Developer
- ${UD}: UI Developer
- ${BD}: Backend Developer
- ${IFUG}: ME. _I Forked Up Guy_

# Mistake #1: Return Promise<A, B, C, D>().then(DeliverDemCodes());

Even if you're the best estimator the world had ever seen, learn as I never did that story ${A} will take an incredibly long time to develop due to stability issues. Acknowledge that ${D}, though perhaps an easy 2 hour task, may result in quite a bit of refactoring of ${C}. Perhaps you don't have enough resources to even consider ${B} in the timeframe allocated.

In other words, in the world of bleeding-edged production and inexperience, never assume that development is a linear and constant variable.  Regardless of experience, knowledge, sleep deprivation; nothing is ever a 'simple' task which can be remedied in a defined time frame.  I was once delayed by two hours because my main workstation -with uncommitted code ready for attention,  decided 10AM would be the optimal time to update it's security protocols and packages.

## **Mistake #1 Lesson:**

${A} took 3 days, which is what the ${UD} and ${IFUG} expected. We did not expect ${C} to take a good chunk of 2 weeks, effectively causing us to leave ${D} on the storyboard. ${SD} was not mad, but also curious as to how I factored in the original estimation…. I told him I'm horrible at gambling.

# Mistake #2: // TODO: Remove Legacy Code From Awesome Project!

You know how parent's always respond to inquisitive questions with 'because I said so'? I never enjoyed that as a kid, and thus is helped to form a overly-confident egocentric behavior that I wear at times; instead of asking 'why', or 'should', I simply do. I do, with zest and vigour. This can translate into questionable decision making skills at times, and even more questionable conclusions to basic logic.

Where am I going with this? Well one day I while developing around ${SD}'s code base with ${UD}, we had noticed a bit of UI work which was used only in a single, non-visible use case which had no application to the current scope. In the eyes of ${IFUG}, and the ${BD}s who were testing our work, it was an eyesore and issue to be tackled.  With precious time before the next presentation, one had to act brash and swiftly to remove the issue; not considering the potential risks / issues it would cause in the immediate future. My overconfidence that this was simply just a dead code from a legacy base was at an all time high, so I commented it out, recompiled, and committed the change.

Even if your IDE claims your code is unreachable / never used… don't blindly comment it out and commit. When the tests pass, and the features aren't breaking, don't pass it off as a 'fix' and move on, neglecting to mention it.

## **Mistake #2 Lesson:**

${SD} was not overly pleased with my actions the next day, for it turns out it was his configuration which was used on another branch of the same UI…. I had cost him hours of debugging only for his eyes to see the recent git diff, and discover that this genius right here (${IFUG}) commented out the code which configured his current feature. We had a good talk about that for the next few hours.

# Conclusion

It's very easy to get caught up in the development of a project, even more so when you're given the keys to build the _arguably_ most important layer. In the past few months, I've taken on more leadership roles & positions which resulted in my judgement also becoming a questionable state of mind at times. In that state, it's very easy for flaws to burst through and expose themselves in your decision making skills. Ego, confidence, recklessness, these are the flaws which I had exposed in the later half of summer, and just a few of the lessons that I had to experience to truly understand.

Are ${SD} and I on good standing you may ask? Of course! Only after we established some rules which were settled on with fresh peaches.
