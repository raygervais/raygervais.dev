---
title: "Leaving the Campsite Cleaner Than You Found It"
tags: ["Ruby", "Python", "Software Development", "Lessons"]
date: 2021-05-30
Cover: images/clem-onojeghuo-XW-Z9L930CY-unsplash.jpg
description: ""
---

_Or, how to annoy the established norm within your enterprise environments_

Recently, organizational changes had occurred within my team which provided a unique opportunity to focus on paying down tech debt and improving the (rather shoddy) developer experience. Being the new senior-esque of the team, I opted to find improvements in how we went about general development and maintenance of our product, it's surrounding platforms and the legacy codebase and processes which we had inherited in 2019. I hoped this task would resonate with new-hires the most since they were not exposed to how "things are done around here", and thus weren't cemented yet in with the routines of the current day. They would be test subjects, and also my direct feedback loop. This experience which details the learnings themselves below is undoubtedly inspired by _the Phoenix Project_, but more-so by the sister book, _The Unicorn Project_. Instead of reiterating Gene's explanations found in the books, I'll instead relate my own experience, experiments and learnings below.

## Identify and Remove Friction In Everyday Processes

### Pay-down Technical Debt In Everything You Do

> The bill always comes
>
> \- Ernest Hemingway

For every decision in a project, there's a corresponding technical debt which is often created. If we are lucky, it's documented somewhere in a Jira backlog to die a slow and quiet death as sprints roar on. For the unlucky, it festers and creates issues behind the scenes which the team is bound to run into at the least convenient time. I cannot recall on a both hands the amount of time our own work and releases have been blocked due to technical debt revealing itself at the worst of times. In my case, I can map out known technical debt areas such as:

- Shell scripts untouched since 2018, clustered in a folder leveraged by Packer
- Ruby gems without `Gemfile.lock` which haven't run through CI/CD since 2017
- Abandoned Puppet modules which _seemingly_ string the entire project together _it feels_.
- Python 2 code bases that haven't seen the light of day since their creation
- Duplicate, out of date documentation

Every project has it's own debt, both big and small. These are very appropriate for an enterprise environment, that's for sure.

A similar theme that you'll see in this post and my other writings, I like to introduce and leverage concepts which come from software-centric companies such as Amazon, Microsoft, Google, etc. It's well advised to plan for and accommodate technical debt within your sprints and quarterly plans, but more so to pay-down technical debt _whenever_ the option presents itself. Though I cannot remember who

### Software Development

Though I cannot where I read the concept, an item that struck me was the advice to always prioritize the developer experience over the product's features. The logic being, anyone with enough time can write and implement new features, but the time to onboard and enable them can be drastic to the original ask. In my experience, it takes an average of 6 months to learn some of the platforms that I work with, and an additional few to learn how to be `somewhat` effective in developing on them. How can we improve that?

#### Research Modern Updates to Your Platforms & Software Practices

While learning to understand how one does Puppet testing via Unit, Acceptance and Smoke tests, I had learned that the overall concepts and platforms used originated in 2014. Modern, you may think. Out of date I'd argue given the rapid update cycle of modern SaaS & IaaS platforms. Sure, it may be "safe" to use the tested approach, but after writing enough boilerplate with the inability to squander any additional value from it, you begin to wonder, "could there not be anything better?". I cannot think of a single individual who wants to actively use a tool which hasn't been updated since 2016 when there are far better approaches provided directly by the Vendor in more up
to date versions of their platform.

I decided to spend some time researching and understanding how modern day Puppet looks in the testing department, and if I had to sum it up in a single word: seamless. In my case, Puppet's PDK (Puppet Development Kit) CLI has built in unit-testing as of the 2.0 release, which enables a single tool we can leverage for the entire end-to-end lifecycle of the Puppet module. A great blog post by Nick Howell which covers this subject more is can be read [here](https://nickhowell.uk/2020/05/26/Acceptance-testing-puppet-modules/).

#### Learning from Open Source Projects

Forking, Testing & PR back to main

When my team inherited the project, we had one primary focus: stabilize the platform. How bad could such a product be that we only had that focus? Well, this platform broke depending on the direction the wind blew that morning, and was also great at crashing just as the output would start to spew green, happy pipeline processes. It was a heartbreaker to the core. It took months to learn and improve the platform's software, the aim being to achieve consistent performance for being run monthly with minor middleware updates in between. Identifying the next step towards improving the overall project means dissecting the software development lifecycle(s) and questioning the `why` of various aspects. For example, in my case we had discovered there was no true developer environment for testing of changes prior to merging into the `stable` project code base. This implies constantly breaking the stable build while testing out modules with the only fix being a revert after each failed build. Sounds rather simple right? Well, what if I explained that there's multiple builds, builder(s), packages, and systems which all integrate into this setup where a single change to `stable` would impact them all. Certainly there has to be a better way, right?

Enter, the beautiful world of project `forking`! This semantic of forking a project, developing and testing, and merging back I learned from the world of Open Source. Instead of merging changes directly into the sacred `stable` project repository, what if we have a duplicated, always up-to-date version dedicated for development, testing, and breaking? A developer package variant of our product! Atlassian [wrote](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow) about the process in vast more detail, but essentially we enable a method of rapid testing and feedback through this developer-based

#### Automated Developer Environment Provisioning & Setup

# Resources

- [Cover Image: Photo by Clem Onojeghuo on Unsplash](https://unsplash.com/photos/XW-Z9L930CY)
- [Microsoft Dev Blog: Technical Debt - The Anti-DevOPS Culture](https://devblogs.microsoft.com/premier-developer/technical-debt-the-anti-devops-culture/)
- [AWS: The CIO-CFO Conversation: Technical Debt](https://aws.amazon.com/blogs/enterprise-strategy/the-cio-cfo-conversation-technical-debt-an-apt-term/)
- [Atlassian: Escaping the Black Hole of Technical Debt](https://www.atlassian.com/agile/software-development/technical-debt)
- [The Verge: Nadella's Microsoft](https://www.theverge.com/2018/5/7/17324920/microsoft-ceo-satya-nadella-interview-windows-10-build-2018)
- [Atlassian: Git Fork Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)
