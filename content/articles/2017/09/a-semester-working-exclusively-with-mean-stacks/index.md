---
title: "A Semester Working Exclusively with MEAN Stacks"
date: 2017-09-06
draft: false
tags:
  [
    "Open Source",
    "Experiments",
    "Overview",
    "NodeJS",
    "MongoDB",
    "ExpressJS",
    "Angular",
  ]
description: "Since May, I've had the unique experience of working with MEAN stacks on a daily basis, each varying in complexity and architecture to reflect a different end goal. A semester ago, I'd never guessed how little time I'd be spending writing C++, Java, Swift, or even Python applications compared to JavaScript-powered web applications. Furthermore, this is the first time in my life that I'd been exposed to a technology stack not taught at Seneca, which during the time of my attendance examined LAMP, and C# / ASP.NET stacks."
---

Since May, I've had the unique experience of working with MEAN stacks on a daily basis, each varying in complexity and architecture to reflect a different end goal. A semester ago, I'd never guessed how little time I'd be spending writing C++, Java, Swift, or even Python applications compared to JavaScript-powered web applications. Furthermore, this is the first time in my life that I'd been exposed to a technology stack not taught at Seneca, which during the time of my attendance examined LAMP, and C# / ASP.NET stacks.

# What is a MEAN stack?

Each letter in MEAN stands for the technology platform used - similar to a LAMP stack (Linux, Apache, MySQL, PHP), MEAN stands for MongoDB, Express, Angular, and Node.

**MongoDB** - The persistence Layer

**Express** - The back-end layer

**Angular** - The front-end layer

**Node**    - The renderer layer

# The Learning Experience

I explained in a different blogpost how little I knew of modern-day ES6+ JavaScript, and how easy it was to fall into a spiral of constant peril while trying to learn said new technologies. If it weren't for David Humphrey's brilliant instruction, I can imagine within a matter of hours I'd quickly become discouraged to the point of dropping the stack all together. Luckily, that was not the case.

## MongoDB

Luckily for me, I've only had to learn the basics about MongoDB and how it relates to the data you see in your various mediums. It's a fantastic NoSQL database tool which really helped me to learn the benefits and downsides to non-relational databases in a variety of contexts.

Having data saved as BSON (Binary JSON) is quite the freeing experience compared to the programmed constraints of SQL-centric databases. Being able to insert entire JSON objects, regardless of the document's structure, allows for a much more scalable and flexible database in my opinion.

Granted, this depends entirely on the purpose of the database. Need data to remain constrained to preset rules, configurations, and relations? SQL. Need a place to store your marked up blog posts, or to save the comments of an article within the article structure itself? NoSQL!  You wouldn't want to save one's most important information for example in a database which doesn't enforce any constrains natively (though, drivers / mappers such as Mongoose do alleviate this issue very well).

## Express

Express was an interesting beast, full of new paradigms and JavaScript-centric programming habits.  Coming from a PHP / .NET background, the flexibility of Express allowed for rapid prototyping and scaling of applications.

In this technology, I also learned how to write proper REST API programs which would power the back-end in the cleanest (at the time) way possible. I'm certain GraphQL (a newer technology which is already taking web development by storm) will become the successor to the REST API back-ends, but for my needs I'm content with the knowledge accumulated on REST practices. My URL end-points have never looked better.

## Angular 4

This semester was my first foray into Single Page Applications (SPAs), which have an internal routing mechanism allowing for a single page load to access most if not all of the views. You learn rather slowly just how powerful Angular can be from my experience, because many opinionated workflows and APIs are hidden behind  a seemingly unforgiving platform complexity. Once you learn the basics, such as routing, services, components, child-views, then you realize just how much can be achieved by surrendering one's self to such a framework.

Angular 4 does have it's limitations, and this goes back to a similar topic of 'what is the end goal for this program'? For example, I made my life a living hell by choosing Angular for a project which really, didn't receive any of the benefits Angular 4 could offer, simply because it was used out of 'hype' and not 'logic'.

Would I recommend learning / using this for other novice web developers? Absolutely! Angular 4 is a hot topic among enterprise and startups alike, and equally valuable for web applications which revolve around a SPA architecture.

# Conclusion & Thoughts

If I had to describe the experience in a single word, it would be 'perplexing'; this is a different word than I would describe the technology stack itself, which would be 'influential'. There are quite a few hurdles that one has to get through before seeing truly remarkable results, but once one looks back at all the programming paradigms relating to a JavaScript-centric stack that was implemented, I'm certain they'd be amazed.

Working with MEAN technologies for the vast majority of the summer has allowed me to learn quite a few bleeding-edge technologies such as Web-Sockets, Webpack, Web Components, and SPA front-end frameworks. These technologies, though niche to the software developer or desktop programmer, have paved the landscape of open standards which must be supported by browsers, and likewise how one approaches the concept of a modern web application. Open Source advocates such as Netflix have contributed tens of thousands of lines of revolutionary code, all relating to the modern web & it's various uses to the end user. I truly am grateful that I could immerse myself in such a trend which is transforming the literal internet for everyone, and though communities and developers alike are segregated on the current state of the world wide web, I am forever content knowing what I had learned, and what I was able to accomplish.
