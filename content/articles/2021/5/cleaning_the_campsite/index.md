---
title: "Leaving the Campsite Cleaner Than You Found It"
tags: ["Life Update", "Software Development", "Lessons", "Open Source"]
date: 2021-08-13
Cover: images/xiaokang-zhang-0iQVFeCfb9Q-unsplash.jpg
description: "Today marks my last day working as a Cloud Engineer at Scotiabank, and I thought that in this bittersweet reminiscence, I'd like to share a few lessons and initiatives which the team and I observed as we went about `cleaning the campsite`. See, I've had the chance to work with incredible people here at Scotiabank for the past two years, but incredible is joined hand in hand with opinion and hard lessons along the way; resulting in critical questions being asked, compromises being debated and arguments around the term `friction` occurring."
---

_Would you believe me if I said I had rewritten this one article five times?_

Today marks my last day working as a Cloud Engineer at Scotiabank, and I thought that in this bittersweet reminiscence, I'd like to share a few lessons and initiatives which the team and I observed as we went about `cleaning the campsite`. See, I've had the chance to work with incredible people here at Scotiabank for the past two years, but incredible is joined hand in hand with opinion and hard lessons along the way; resulting in critical questions being asked, compromises being debated and arguments around the term "friction" occurring. Even more-so recent, the team the opportunity had the chance discuss some of the frictions and "smells" which existed within our everyday tasks and went about trying to improve them each sprint. I thought I'd document some of the lessons around the concept of developer "friction" (or more so, how to improve the developer experience) below so that you, kind reader, may discover similar themes in your own team and start the discussion of how to improve them. Lastly, stick around to the end for a little heart-to-heart with my dear teammates as my closing remarks since I'm terrible with them when put on the spot.

## Address Technical Debt In Everything You Do

> The bill always comes
> 
> \- Ernest Hemingway

For every decision in a project, there's a corresponding technical debt which is often created. If we are lucky, it's documented somewhere in a JIRA backlog to die a slow and quiet death as sprints roll on without it. For the unlucky, it festers and creates issues behind the scenes which the team is bound to run into at the least convenient time. I cannot recall the amount of time our own work and releases have been blocked -or at risk of not being released, due to technical debt revealing itself at the worst of times. In my case, I can map out known technical debt areas such as:

- Shell scripts untouched since 2018, clustered in a folder leveraged by `Outdated Vendor Platform`
- Ruby gems without `Gemfile.lock` which haven't run through CI/CD since 2017. Godspeed with your `bundle install` and min Ruby Version!
- Abandoned Puppet modules which *seemingly* string the entire project together *it feels*.
- Python 2 code bases that haven't seen the light of day since their creation.
- Duplicate, out of date documentation everywhere. This one is partially my doing for the team, as I'm in the process of rewriting and organizing as apart of my off-boarding. *Sorry Ali & Kiran*.

Every project has it's own debt, both big and small. These are very appropriate for an enterprise environment, that's for sure.

A similar theme that you'll see in this post and my other writings, I like to introduce and leverage concepts which come from software-centric companies such as Amazon, Microsoft, Google, etc. Though I cannot for the life of me find where the original idea derives from, a common practice is to `pay down` technical debt whenever the opportunity presents itself. During the pandemic, I imagine many of us grew out our hair or buzzed it entirely, but in a normal world many address their growing weeds ~monthly. Technical debt should be the same, always addressed when the chance arrives and not forgotten about in a JIRA backlog dating back to the land before time.

## Research, Test and Propose Modern Updates to Software Platforms & Practices

While learning to understand how one does configuration as code unit, acceptance and smoke tests, I had learned that the overall concepts and platforms (used internally) had originated in a blog post from 2014. Never changed. Since 2014. Modern, you may think. Out of date I'd argue given the rapid update cycle of modern SaaS & IaaS platforms. Sure, it may be "safe" to use the tested approach, but after writing enough boilerplate with the inability to squander any additional value from it, you begin to wonder, "could there not be anything better?". Perhaps out of ego, pride or spite, I sought out to discover how other companies leveraged these platforms and what their codebase looked like when it came to writing tests, configuring their test-harnesses, and also what tooling was used for automation or reporting. To my surprise, one of the first things I had discovered for Puppet was the release of the PDK (Puppet Development Kit) CLI containing built-in unit-testing orchestration as of their 2.0 release. Why was this a surprise?

1.  We were still on early 1.X of PDK
2.  This built-in tooling for unit tests means we can leverage the PDK module for initialization, creation, and testing of a Puppet module end-to-end.
3.  I no longer had to battle with `Gemfile.lock` files which were always created out of date with our development version pinnings!

It's the little things, ya know? A great blog post by Nick Howell which covers how the 2.X PDK works with Ruby unit tests can be read [here](https://nickhowell.uk/2020/05/26/Acceptance-testing-puppet-modules/) for those interested. See, for the above topic to truly be monumental to you dear reader, you have to understand that prior variations of testing Puppet modules involved multiple (volatile, in my opinion) frameworks whose API updates kept breaking our Public Cloud CI/CD. What's worse than a pipeline returning a red build due to your bad code? A pipeline which cannot run the tests at all due to a breaking change in the APIs of said pipeline.

I decided to spend some time researching and understanding how modern day Puppet looks in the testing department, and if I had to sum it up in a single word: seamless. In my case, Puppet's PDK (Puppet Development Kit) CLI has built in unit-testing as of the 2.0 release, which enables a single tool we can leverage for the entire end-to-end life cycle of the Puppet module. A great blog post by Nick Howell which covers this subject more is can be read [here](https://nickhowell.uk/2020/05/26/Acceptance-testing-puppet-modules/).

## Learning from Open Source Projects: The Art of Forking

When my team inherited the project, we had one primary focus: stabilize the platform. How bad could such a product be that we only had that focus? Well, this platform broke depending on the direction the wind blew that morning, and was also great at crashing just as the output would start to spew green, happy pipeline processes. It was a heartbreaker to the core. It took months to learn and improve the platform's software, the aim being to achieve consistent performance for being run monthly with minor middleware updates in between. Identifying the next step towards improving the overall project means dissecting the software development lifecycle(s) and questioning the `why` of various aspects. For example, in my case we had discovered there was no true developer environment for testing of changes prior to merging into the `stable` project code base. This implies constantly breaking the stable build while testing out modules with the only fix being a revert after each failed build. Sounds rather simple right? Well, what if I explained that there's multiple builds, builder(s), packages, and systems which all integrate into this setup where a single change to `stable` would impact them all. Certainly there has to be a better way, right? Within the year, it was clear that building your highway as cars drove on it was clearly not the best approach.

Enter, the beautiful world of project `forking`! This semantic of forking a project, developing and testing, and merging back I learned from [Dave's Open Source classes](https://github.com/humphd), and once again his teachings bubbled into software approaches which improved the setup ten-fold. Instead of merging changes directly into the sacred `stable` project repository, what if we have a duplicated, always up-to-date version dedicated for development, testing, and breaking? A developer package variant of our product! Atlassian [wrote](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow) about the process in vast more detail, but essentially we enable a method of rapid testing and feedback through this `its-ok-to-break-and-iterate` fork of our `stable` version which will never hinder the green-build goodness of our stable CI/CD.

## Build the Onboarding Experience, Automate the Trivial

When my team was created, the onboarding experience for the developer environment was completely manual and filled with questions; settings put into random files without explanation, pulling of out of date Docker containers, no linting or tooling to help with the terrible code that I'd write in the following months. More so, because the setup was done entirely by hand with constant revisions to the document, it was not reproducible in the slightest. For new hires, this can be both frustrating and debilitating to the developer experience. One of my first goals was to write a module which enabled reproducible Linux developer environments which contained my Vim, Nano, Git, Ruby, Python, Go configurations for the various projects. From there, deploying a developer environment took a few lines of code, a few minutes to ponder as your dedicated environment was provisioned exactly as you expected it to. An aside, this inspired my current dive into `Ansible` for configuring my Fedora/Gnome setup!

See, the key with the onboarding experience similar to everyday goals (in my opinion) is to enable the developers. When an engineer cannot complete their work due to environment issues, friction etc, the process itself must be put to fault. The next steps that I had thought about was 

# The Heart to Heart: An End to an Era

Ali, Kiran, Yasir, Ahmed, Anthony, Gary, Cloud Infrastructure, it's been quite the adventure as we climbed Everest and battled countless dragons along the way. The concept of implementing ~99.9% CIS compliance within an already locked-down environment is mind boggling from a security point of view, and even-more-so the idea that we can claim bragging rights for being the first team to have implemented such successfully within the Bank. More so, this was my first rodeo when it came to inheriting a legacy platform (still ablaze from the lack of attention) and I wouldn't have been able to become the primary developer / maintainer of said platform had it not been for your help, leadership, and technical knowhow. 

- **Ali**, it's been quite the story these past three years, my friend. Here's to the annoyances, scope creeps, and general frustrations which I bring about which I'm sure you'll miss as much as I will. I hope that we keep in touch so I can keep you up to date with what's new in the world of Android, Linux and Music. I cannot thank you enough for being the fantastic mentor figure, good friend and empathetic opposite to my calculated persona.
- **Kiran**, You are the latest addition to the team, and have already accomplished so much in the first few months than many had within their first year. I remember when our team was formed, it took weeks for us to put the initial puzzle together when it came to understanding how a **single** Puppet module worked. Though it may seem daunting now, I know you'll do great.
- **Yasir**, I hope that your inquisitive nature when it comes to debugging and understanding the issue never falters. It's a characteristic of yours which I hope to adapt into my own similar to how you're learning audio mixing from me. Between that and you earning your Phd while working full time, I'm not sure of what could ever stop a force like you.
- **Ahmed**, **Anthony**, **Gary**, you all derive from engineering backgrounds and somehow manage to make the concepts of team management somewhat tangible. More so, I'm blown away at how technically knowledgeable you are even when so far removed from the technology itself at times. Though I'm not sure I'd ever want to take a step in similar shoes, one can hope that he'd be lucky to pick up some of your wisdom along the way and retain the technical in similar fashion.
- **Rish**, **Tommy**, I've left a fairly well sized shoe for you to fill when it comes to frustrating management. I encourage you to fill them and choose chaos where you believe appropriate in the everyday.

Cloud Infrastructure taught me so much about uplifting your peers and standing with critical decisions, some of which I imagine will become my infamy! I've always considered arguments and disagreements to be completely natural -even encouraged at times for the betterment of the product, but with those types of discussions there must of course be an understanding of agreement,  removal of emotion and understanding of respect between the peers. We are debating the solution, approach, etc; not the integrity of the developer, manager, etc. Team, you brought your A game when it came to these types of meetings which forced me to learn even more-so if I were to argue the other side, so thank you for keeping me on my toes. Still, we'll see how the playing field looks during our next Ping Pong tournament.

And so, this concludes my era at Scotiabank it seems. Though one may never know what the future holds, I certainly can say that the items I had learned while under their employ are some I'll take with me into the next office. Besides, it's a small world and I'm sure familiar faces will arrive in familiar and unfamiliar offices throughout my career; so it's never a true goodbye, but instead a farewell as I venture onto the next trip. 

## Resources

- [Cover Image: Photo by xiaokang Zhang on Unsplash](https://unsplash.com/photos/0iQVFeCfb9Q)
- [Microsoft Dev Blog: Technical Debt - The Anti-DevOPS Culture](https://devblogs.microsoft.com/premier-developer/technical-debt-the-anti-devops-culture/)
- [AWS: The CIO-CFO Conversation: Technical Debt](https://aws.amazon.com/blogs/enterprise-strategy/the-cio-cfo-conversation-technical-debt-an-apt-term/)
- [Atlassian: Escaping the Black Hole of Technical Debt](https://www.atlassian.com/agile/software-development/technical-debt)
- [The Verge: Nadella's Microsoft](https://www.theverge.com/2018/5/7/17324920/microsoft-ceo-satya-nadella-interview-windows-10-build-2018)
- [Atlassian: Git Fork Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)


