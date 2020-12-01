---
title: Being Apart of the Telescope Open Source Project
date: 2020-04-19
draft: false
tags:
  [
    "Open Source",
    "Life Updates",
    "OSD600",
    "NodeJS",
    "Docker",
    "Opinions",
    "Software Development",
  ]
description: "David Humphrey's (and Seneca's) open source project, titled Telescope (for those who've been living under a rock) has reached the end of semester milestone goal of 1.0! Along with that, the 1000th issue and pull request was created, marking the classes internal milestone from what I understand. Watching this from an external perspective is quite the thrill. I remember telling Dave recently just how life changing telescope could be for some of the graduates; it truly is a project that unearths and shapes interests, teaches real software development and the combined rush / peril one can feel at any given second, version control when working in a team, and being proud of your work. In my opinion, I believe every single individual who frequents that Slack channel will see the dedication and pride that each contributor exerts into telescope."
images: ["./images/julian-lozano-7KsEAafSnWk-unsplash.jpg"]
---

_I've probably rewrote aspects of this post three times, let's see how the fourth turns out._

## Reflecting on Telescope, Version 1.0

David Humphrey's (and Seneca's) open source project, titled Telescope (_for those who've been living under a rock_) has reached the end of semester milestone goal of 1.0! Along with that, the [1000th issue and pull request](https://github.com/Seneca-CDOT/telescope/issues/1000) was created, marking the classes internal milestone from what I understand. Watching this from an external perspective is quite the thrill. I remember telling Dave recently just how life changing telescope could be for some of the graduates; it truly is a project that unearths and shapes interests, teaches real software development and the combined rush / peril one can feel at any given second, version control when working in a team, and being proud of your work. In my opinion, I believe every single individual who frequents that Slack channel will see the dedication and pride that each contributor exerts into telescope.

### Comparing to First Steps in Open Source

When I was in OSD500 and OSD600, I remember those classes teaching me how to contribute (_poorly, I contributed poorly if I may add_) to Mozilla's Thimble, Visual Studio Code and Angular Material. Those lessons directly impacted (in the best of ways) my internship which followed. The internship was revolving around a micro-service MEAN (MongoDB, Express, Angular, Node) stack architecture, and I was quite comfortable on day one.

That was then, which doesn't even begin to contrast the experiences that these brave hackers are going through as they endure and conquer far more complex battles:

- Regular need for rebasing of branches based on others working in the same area.
- Identify and debug key performance areas, striving for [optimization!](https://github.com/Seneca-CDOT/telescope/pull/994)
- [Proper Logging](https://github.com/Seneca-CDOT/telescope/pull/651), [NodeJS Development Patterns](https://github.com/Seneca-CDOT/telescope/pull/897#discussion_r399868410) (Dave, I know my bias against JavaScript is unwarranted, but I will admit that you're teaching of the best practices allows my unease with some of the language rest easier.)
- Learning how front-end and back-ends interact via Proxies, Ports, and life cycle requests.
- Iterating on a platform, following a very robust software development life cycle.
- Leveraging and integrating modern technologies and platforms ([Redis](https://github.com/Seneca-CDOT/telescope/pull/748), [Elastic Search](https://github.com/Seneca-CDOT/telescope/pull/822), Docker)
- Figuring out how to develop while on a [Windows 10 Home](https://github.com/Seneca-CDOT/telescope/pull/948)...

These experiences (I'm sure there are dozens more, the above are ones that I've witnessed in the past three months alone) are ones that interns and junior developers strive for. These are the moments which I think truly make all the toil which got each individual to this point worth it. It's the teaching style and community which has formed around it which makes me proud every time that I recommend Dave's course to anyone who listens. I knew that come Friday, some would check the channel for the last time. So I wanted to leave my own words of encouragement from a senior external contributor:

> Before graduating, you and the others have officially shipped a Software Project which provides value, can be deployed anywhere via Docker, and is modern. The shipping alone of 1.0 is amazing, the rest being additional points in experience and resume lines which make you far more capable and credible compared to junior developers. I look forward to seeing where we go with Telescope, and also where you go as developers.

### Contrasting To The Current Trends and Needs

I'm not going to pretend that I understand technological trends outside of my Cloud Engineering field, but I can explain the very trends that I and my graduate peers have experienced since stepping outside the College-era of our lives. I want to explain from my perspective how Dave -and in extension, the students themselves- have positioned themselves into the best place they can be in prior to graduation.

#### JavaScript Front-ends Define Our UIs

React, Angular, VueJS can be found literally everywhere. In my various internships and full-time careers, I've yet to not run into a Front-end codebase which was powered by one of the JavaScript front-end platforms -among other variants of course. Having a familiarity with modern Node development and JavaScript enables you to jump right into front-end roles with confidence.

#### Everyone Writes and Reviews Bad NodeJS Code

My last PR which was submitted prior to 1.0 included over 50 comments, mostly from Dave, Ana, Cindy, and Rafi. Though I am often quite confident in my programming skills, and understanding how runtime affects performance and the _feel_ of an application, there's always ways to improve and iterate over a codebase. The `error.jsx` component which I was contributing was a new page, and with that came questions of how to style it, how we'd pass data from the back-end, and also how React did things. With that, I knew changes would be coming and better ways to express features and use-cases would be suggested. It's in writing this code, though I wouldn't consider it bad, that I also learned how Code Reviews were treated. It's how Cindy and Ana learned to truly "own" the front-end code base, which also meant ensuring that no code made it in without first meeting their criteria and requirements, alongside Dave's. The same can be said for back-end submissions, where other students including Josue and James would dictate the quality and requested changes that would best add to the growing codebase. Learning how to conduct constructive code reviews is a skill which cannot be understated in it's importance. The code reviews, and keeper's of "code best practices" of a project are the last line of defence for a project and it's growing sprawl of features, technical debt, and stability. I can confidently say that the reviews that we see in Telescope rival and often beat some of the reviews and codebases found at start up companies that I've been apart of.

#### The Age of Monoliths Has Dawned

Legacy applications will always be confined to the architecture decisions and technical sacrifices which defined their usage at the time, but the past two decades have shown interest in microservices, and dedicated components which makeup a system. [Uber](https://eng.uber.com/building-tincup-microservice-implementation/) went so far to make thousands of services, eventually leading to the experimental internal migration of [macroservices](http://highscalability.com/blog/2020/4/8/one-team-at-uber-is-moving-from-microservices-to-macroservic.html) (more explanation [here](https://twitter.com/GergelyOrosz/status/1247132806041546754)) to enable better orchestration and sustainability. Who says too much of something can be a bad thing? Those who had the chance to learn how dedicated front-end and back-ends (along with the caveats which come with such decisions along the way) interact and provide clear separation of concerns will be able to take on greater platform architectures. The orchestration of Redis, Elastic Search, and SAML using Docker-Compose truly showcases modern platform integration with various services in one of the best lessons I could ever imagine a class providing. Dave's advocating of the [Twelve-Factor App](https://12factor.net/) as a development methodology is one

#### But It Works On My Machine!

I love that saying, it's the best when said in a confused tone during your Demo which had worked yesterday. Even moreso when the CTO decided to sit in on the demo!
The concept of having a a consistent and easily reproducible environment must have been a dream for many prior to the days of Docker. Imagine the closest path to environment configuration and consistency being scripts which had to be manually executed on each environment. The concept of the immutable infrastructure really would have been a pipe dream back then; impossible to rely on. Say before that deployment on Friday, that cursed Friday, a developer modified their environment by installing different versions of Ruby which changed a datetime output which I function relied on. How easily could that be reproduced if they had not mentioned the upgrade? Docker and the concept of containers allows for dedicated immutable environment which is defined as code (`Dockerfile`, `docker-compose.yaml` to be exact) that can be versioned, tested and reproduced without behaviors changing in any way between the different hosts. In the modern ambitions of development and DevOps, containers and the concept of immutable infrastructure is the endgame.

#### In the End, Unix Won.

As you've seen from countless blog posts of yours truly, along with other developers on Telescope, there truly is a bias to developing on Windows. Or, there was it what I should say. See, there's nothing wrong with the operating system or the company behind it from a high level, but the many who were struggling to develop basic web applications on the system should point out the common flaw: just because an operating system works, doesn't mean it works for all use-cases. Just as many had predicated and hoped for, the concept of running Unix anywhere it could possibly run became the defacto standard for development environments. The Linux layer in newer builds of Windows is great proof of this, and those who suffered and toiled can now find peace with the recent Docker / WSL 2 integrations which I had talked about previously. At the end of the day, Unix runs the world from a set of back-end servers behind every project. Learning how to navigate, edit and deploy projects in Linux environments is a skillset which will never run out of fashion. Fun fact, it was my Linux / SysAdmin experience which actually helped me land my first Cloud Engineering job! See, in a sea of developers and engineers, knowing how to deploy and navigate a server truly allows you to stand out in the crowd. Be like Brent (from the [Phoenix Project](https://itrevolution.com/book/the-phoenix-project/), a must read in my opinion!), but learn to also not fall into the same traps as Brent did.

## DevOps, Cloud Engineering, and The Next Steps

Many of my generation have found careers under the guise of `DevOps` or `Cloud Engineering` titles, which truly does sum quite a bit of where the industry is heading. This isn't to scare or even advise perusing such titles unless the interest is already there, because every team is going to always need another engineer on the front-end, back-end, database, and deployment tooling. Instead, I'd advise to reach out into your passions and interests and explore how that sector is transforming. Before the concept of DevOps and their respective toolchains, there was painful deployments and the fear of downtime of a major project; just as before the Cloud Engineer and Public Cloud came into fashion, there was -and will be, for the forseeable future- On-Premises hardware which ran the entire company's software. Single-Page Applications powered by JavaScript came about when the power of the language evolved, opening the next level of interactive dynamics without a reload of the page, leading way to new development paradigms as well in the process. That's only going into details which relate in fashion to Telescope now! The world of programming is a fantastical place which is constantly evolving into new shapes and sizes.

Where we take Telescope is uncertain, I know James and Dave have grand ideas of integrating streaming, community building, and further extensions which I believe is vital right now for all who are out of reach. In these odd times, spending time on Telescope has been an experience that I wouldn't throw away. Likewise, I'm looking forward to seeing how the platform grows as we (including myself) contribute towards 2.0. Some of the items I think we'll need before then are:

- Kubernetes Deployment and Orchestration
- Macroservices, for better tooling integration and deployments
- Front-end optimizations and features
- An easter-egg, perhaps buried in the console? That's too easy, let's think bigger!

So, with that being said, who wants to help me with the easter egg first!

## Resources

- [Cover Image: Photo by Julian Lozano on Unsplash](https://unsplash.com/photos/7KsEAafSnWk)
- [Uber: Rewriting Uber Engineering: The Opportunities Microservices Provide](https://eng.uber.com/building-tincup-microservice-implementation/)
- [Uber: Why We Leverage Multi-tenancy in Uber’s Microservice Architecture](https://eng.uber.com/multitenancy-microservice-architecture/)
- [Twelve-Factor App](https://12factor.net/)
- [The Phoenix Project](https://itrevolution.com/book/the-phoenix-project/)
