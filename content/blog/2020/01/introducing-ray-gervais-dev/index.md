---
title: Introducing My Jamstack Site!
date: 2020-01-06
draft: false
tags:
  [
    "Markdown",
    "VueJS",
    "Apollo",
    "Web Development",
    "Life Updates",
    "Overview",
    "2020",
  ]
series: false
Cover: "images/takahiro-sakamoto-qW2F8rZGEWw-unsplash.jpg"
canonical_url: false
description: "I decided to depart from the tried-and-true LAMP stack (powered WordPress of course) for what appears to be the future of websites, the allure of the shiny and new: JavaScript, Apollo, Markdown. In truth, the later is what truly got me interested in committing to such as stack; editing a post like such as this one in Markdown simply feels ten times better, even compared toWordPress' admittedly fantastic modern editor. Throughout my note-taking life cycles, I've always opted for the ones which supported Markdown and allowed for file exports in the same format."
---

_Warning: I have no clue what I'm doing, but it seemed pretty enticing after months of playing around._

## Why a JAMStack?

I decided to depart from the tried-and-true LAMP stack (powered WordPress of course) for what appears to be the future of websites, the allure of the shiny and new: JavaScript, Apollo, Markdown. In truth, the later is what truly got me interested in committing to such as stack; editing a post like such as this one in Markdown simply feels ten times better, even compared toWordPress' admittedly fantastic modern editor. Throughout my note-taking life cycles, I've always opted for the ones which supported Markdown and allowed for file exports in the same format _-my logic being that the data itself should be accessible both inside and outside the application (OneNote, please learn from this!), in the case that I also need to switch applications or provide a portable format to friends, colleagues, etc_.

Furthermore, the idea of modern JavaScript frameworks such as VueJS and React being utilized to power a-more-static HTML-than-SPA front-end ensured that modern development lessons wouldn't hinder performance or result in a 2010's web experience. Who remembers querying the server for every URL click and reloading the page? _Yuck_. Having learned VueJS in the past year, the chance to use it in the context of a non-web-application context (as opposed to a web site) seemed incredible. My past experience as a MEAN stack developer means that I'm more familiar developing both websites and application in the platform compared to modifying WordPress themes; This is a different canvas, with a different brushstroke requirement.

Lastly, Netlify's platform offerings have opened up a plethora of hosting options for modern web application stacks, including Python, JavaScript, and Ruby. Though aimed for static site hosting, I've seen countless examples of React, VueJS, Flask all working on the same platform with great success. GoDaddy's offerings and lack of support towards anything beyond LAMP stack setups -depending on tier of course, I found their private server's to be too expensive. Having a dedicated CI/CD platform which enables SSL-enabled deployments of your web applications is an incredibly powerful resource for modern developers; their onboarding and developer experience being so top notch is the cherry on top.

## What's New?

![Barney Self-Fiving Himself](https://media.giphy.com/media/rT8d2mle5AK6A/giphy.gif)

- This site is open source! All of the beautiful (and not so beautiful) code can be found [here!](https://github.com/raygervais/raygervais.dev)
- The site is powered by Gridsome (duh!), and is aimed at maintaining a 100% score on Google Chrome's Lighthouse platform. That being said, I'm not targeting this for as PWA learning experience just yet.
- So far, there are no CSS frameworks in use. My beloved Bulma is sitting in the corner waiting to be used and alas, I'm trying to maintain the template's minimalism for the time being. I know in time I'll replace majority of the template code with my own ideas, but it's a good starting point which allows me to launch the MVP of this site.
- With the release of this new site on Netlify's platform, HTTPS certificates [free 90-day expiry] from Let's Encrypt are built and deployed with every publish, meaning no longer will I have to worry about out-of-date certificates. This is a major improvement for me since I've neglected updating Let's Encrypt SSL certs for my own site for quite some time. I noticed an interesting issue where my Work's proxy fails to validate the certificate properly, but have not heard of this issue outside of that network from anyone else, so I'm assuming it's a special blend of unique variables being mixed together.

## What's Broken?

- You tell me! Ah, I miss XDA's Android ROM scene and developer humor. So many bricked devices, so many awesome features and tweaks.
- Formatting! I'm not expecting all the posts to have been exported and converted to Markdown properly! It'll be addressed as noticed, but I'm not paying too much to old content unless they were vital posts and require major revisions. Looking forward to better things and learning from the old is a way to ensure progress.
- Mobile Responsiveness. Because I'm opting to start off without a CSS framework, I'm anticipating some responsive issues on the smaller devices such as the simplistic navigation bar for example.
- SEO is going to be interesting, I'm expecting my Google Analytics to report a drop in interest if Gridsome's default crawler settings are too aggressive or restrictive for search engines. We'll fix that in time and laugh about it once all resolved.

## Follow Up Posts

- [Porting my WordPress Site to a JAMStack](/article/migrating-a-word-press-site-to-jam-stack/)
