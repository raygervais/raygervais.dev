---
title: "Re: My Most Notable Failures"
tags:
  [
    "Open Source",
    "Rust",
    "Golang",
    "Ruby",
    "Python",
    "Software Development",
    "Lessons",
    "Overview",
    "Opinions",
    "Linux",
  ]
date: 2021-05-11
Cover: images/rene-bohmer-pfuoqnpClno-unsplash.jpg
description: "So this week, Mr James Inkster (grommers) himself graced us with the first look into his thoughts for the past year in the form of a blog post titled, My Most Notable Failures. It was a damn good read; full of honesty and admittance not to actually making mistakes, but realizing that there's still so much more learning to do. That's how I interpreted many of the points he had raised, even going so far to say that by Breaking Linux by following random instructions online, he was truly becoming a real software developer by learning both how to break and fix your development environment. I then reminded him of the countless times that I had messed up my systems to the point beyond repair over the years and how it backtracked me less and less each time I was also inspired by the topic, because it contributes to a theme which I believe is long overdue: normalizing failure. In the spirit of sharing my own and continuing the trend, here's my response-esque post with a few of my own."
---

_Remember when response videos where a thing? Here's mine:_

So this week, [Mr James Inkster](https://grommers.wordpress.com/2021/05/04/my-most-notable-failures/)(grommers) himself graced us with the first look into his thoughts for the past year in the form of a blog post titled, My Most Notable Failures. It was a damn good read; full of honesty and admittance not to actually making mistakes, but realizing that there's still so much more learning to do. That's how I interpreted many of the points he had raised, even going so far to say that by Breaking Linux by following random instructions online, he was truly becoming a real software developer by learning both how to break and fix your development environment. I then reminded him of the countless times that I had messed up my systems to the point beyond repair over the years and how it backtracked me less and less each time.

I was also inspired by the topic, because it contributes to a theme which I believe is long overdue: normalizing failure. In the spirit of sharing my own and continuing the trend, here's my response-esque post with a few of my own.

## Favoring Skill over People

The more and more I dig into my career, the more I've been forced to see an honest truth, I'm quite cold and methodical at times. It's a flaw that I've heard originates within my family tree and also plagues some of the more kind-hearted in that same tree. In my mind, my tone [topic depending] was never personal. It derived from the idea that skill, focus, understanding and ingenuity had to be targeted and upheld in the teams I was apart of. You say you learn this or that? Fantastic. I can't wait to see what you'll do with it. You say you don't ever think about better ways to do a task? Well, looks like your kind stories and jokes won't get us far.

Now, I can also admit that I've learned and grown thanks to my peers, teachers, and colleagues who have distilled their own approaches to working with (and on) people. It feels good to say that I've lightened up and also been inspired by those who approach their interactions in the perspective of "how can I enable you?" Dave said he focuses on the human element of the project, and I believe I'm starting to see the natural heartbeat and rhythm of a team who's learning together; enabled and lifted by each other. Fear not fellow reader and potential colleague or team member, I'm not nearly as bad as this may read. I hope. Luckily, I'm on a pretty well balanced team where the cold-methodical thinkers gets well balanced with the warm-hearted.

## Not Knowing What I Want To Do

So I wrote about [why I got into Software Development and Information Technology last year](https://raygervais.dev/articles/2020/03/why-i-got-into-programming/), which stemmed down to the theme of reaching as many people as I could. My idea orbited the landscape of Mobile Application development because who doesn't have a smartphone in 2016? 2018? 2020? 2021? It didn't have to be a new application trending on the App/Play Stores either. It was simply the idea of reaching as many people in the most meaningful way that I could do as someone who favors technology in their career. The problem was, when I was granted the opportunity to take my first step and build a "career" from it, I didn't know which to take.

Sure, I could study a lot more and perhaps get in at an Android or iOS Shop -that surely sounds like something most logical given what I stated above, but yet I was also faced with the lingering doubt of "is this what you really want?". By that time, I was well deep into my Linux understanding for an individual in their early 20s and also well-enough versed in Web Development at the time to convince a cynical prof that I could leverage a MEAN (Mongo, Express, Angular and React) stack for our final project. There were a few different paths at my feet. After completing my second internship under the guise of a Web Developer, I found an rock I could leap to which brought a new career path opportunity: Cloud Engineering. The rock? My skills with Linux and Software Development tooling. Even after being a Cloud Engineer for three years which includes learning fantastical technologies of new and old -all of which, are typically oblivious to the system and medium they're hosted on-, you can imagine my own surprise when that same question arrives even at the most normal of times.

Does this sound familiar? I know almost every one of my peers and friends I've talked to have had similar tug-a-wars with their ideas and implementations. In my case, I see this as a failure purely because I opted to follow doors and stairwells as they appeared instead of focusing on a single path that a younger me had believed was best. But, since when did we know better when younger? Even with the self-doubt, I've learned to not beat myself up over things that I could still pursue if the interest is there; and likewise I cannot deny either the fantastic career experience I've been exposed by playing this game of snakes and ladders.

## Fighting The System In the Vain of New and Shiny

For better or worse, I'm very much aware how opinionated I can be when it comes to items I work with daily. For the past three years, I've considered the Ruby language to be my own personal enemy. No matter where I went, it seemed to be the choice for some-what-legacy-some-what-modern tooling in the enterprise environment. Sure, Rails had it's time, but the popularity of it for other use-cases which I've witnessed would make a grown-man cry. I'm not even saying the language is bad, I (for some unknown reason to me) simply have deemed it my own villain with no true explanation aside from my own experiences with it's dependency hell and abstract use-cases. It's a good language, I have no reason to not claim that, and the creator has achieved his goal of making the language aimed at being better for "humans" vs the machine itself.

Yet, even after writing my own little application (still in-use today in the environment!) in Ruby with Test-cases and all (see here for my own blog article on the topic), I thought that was enough. Going forward, for the next year (at least), I maintained legacy Ruby-based projects with broken dependencies around every corner while pursuing better solutions in vastly different software stacks. Oh Ray, does that mean you wrote POCs (Proof of Concepts) proving the better solution? Well avid reader; not entirely. See I could do that, but I was also faced with a cold truth that I still reiterate to myself while bundler breaks every gem installed on my system: in some use-cases, regardless of their obscene nature, Ruby is the language of choice. It's the standard.

How did I learn this? Try searching for configuration management platforms similar to Chef, Puppet, or Salt written in a modern/typed language such as Go, Rust, or even Java. 99% of solutions I could find all leveraged Ruby. So, here was my next series of thoughts which I believe showcase my actual failings on the topic:

- Let's learn how to write it to the standard of the environment
- Let's (NOT) learn how to improve the semantics to which it is used and hope that the entire platform dies a fiery death
- ???
- Profit!

See depending on the project, I'm still somewhere in that list of thoughts with one changed mindset; I know the platform won't die. So, my learnings from such failure-centric opinions is to know learn and improve. To learn and empower really the platform so that the developer experience is better; so that others don't step on uneven ground similarly to how I did as I was on-boarding to the various projects. Perhaps an unpopular opinion, but if you write code which lands in production, the idea of maintaining that code should be a top priority if it's used outside your team. My failings to not implement this far more grounded logic is what fueled majority of my own biases with the language and our tooling funnily enough.

## You're Not Impressed by my Niche Terminal Editor and it's Color Theme? Doesn't It Make Me More Productive Than You?

If I were to list off the amount of themes I've tried and switched on any common day, it would scare you. It's not even that I'm trying to color match my entire system ala Dracula or anything like that! Maybe it's the ask of wanting a change once in a while, but in a given week (if not day), I'll cycle through the following themes (to name a few) for my tools:

- [\_Inksea Dark](https://github.com/owebudde/inksea-theme)
- [Dracula](https://draculatheme.com/)
- [Atom One Dark](https://github.com/akamud/vscode-theme-onedark)
- [Night Owl](https://github.com/sdras/night-owl-vscode-theme)
- [Github Dark](https://github.com/primer/github-vscode-theme)
- [Nord](https://www.nordtheme.com/)
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme)

Now, preference isn't a bad thing at all and I'm not even saying to have such is a fault. Where I get hung up on is the idea that I can customize so much and thus, will. You think I'd stop at theme customizations? Hahahaha. No. I cycle between the following Fonts for example daily for no true reason aside from an `urge` to:

- [Victor Mono](https://rubjo.github.io/victor-mono/)
- [Lilex](https://github.com/mishamyrt/Lilex)
- [Hasklig (Source Code Pro + Ligatures)](https://github.com/i-tu/Hasklig)
- [Fira Code](https://github.com/tonsky/FiraCode)

See, the above have all been aesthetic examples. Let me dive into what I believe to be a powerful failure which has been benefited and alienated yours truly: chasing the terminal-driven dream for all use-cases which I can. Writing this post? Neovim. Editing code? Neovim. Fixing git conflicts? Neovim. I leverage semantics from the past it appears. Even during demos at work, I leverage my iTerm + Tmux + Neovim setup for technical demos -all in the vain of mastering the concept of developer "productivity". See, for me the tools, fonts, themes they were never about "looking cool" -beyond of course my own preferences, but achieving the `10X developer productivity concept`. This is an incredibly easy failure to fall into with countless streams of others validating the idea of productivity achievements being the best thing one can muster. Let me reiterate, the idea of chasing productivity to the point of `perfection` is absurd and very hard on the mental health. My story above was referring to tooling, but this spreads beyond just that one use-case and can go so deep as to your daily habits, nuances etc.

## Taking On Too Much, Burned Out Beyond Repair

For anyone who knows me in any fraction of a way, this last lesson should be obvious. I'm the type who dives into multiple side projects all at once as if I were a dog surrounded by an endless amount of tennis balls. The thrill, the technical challenge, it's all so alluring at the start. Hell, I even thought at one point I could contribute to a bigger project such as [Caddy when there was an ask to rewrite the `FastCGI` transport module](https://github.com/caddyserver/caddy/issues/3803). Yet, there's only twenty-four hours in a day and my mental health was taking on far more coping strategies as a result. The pandemic surely hasn't helped with that, but another topic for another day.

I work a semi-standard 9-5 style job with the common after-hours if the task is important enough. I've shared similar thoughts with others, "It has to be done so we don't drown the next day". On top, I also have my only semi-sane hobby of mine which acts as both an outlet and distraction from the software development projects: music. All these projects both on and off screen involve some level of dedication, mental energy and time. This is a dangerous combination of requirements for anyone I think. It produces one absolute entirely dependent on your velocity, burnout. This is what happened with budding projects that I was involved in such as Dave's Telescope, where despite the health of the project being stellar (and my advocation for MicroServices finally paying off), I had not a single ounce of energy or motivation to action on contributing. Similar happened with my own projects (closed source for now) which I ended up completely archiving after losing any trace of interest the next day. The same I can say for my own music projects as well; if it weren't for a few friends and groups which I produce, I'd probably pack up shop entirely some days and try to not look back.

Burn out in the technical sphere is real, and despite what some think, no one knows how to beat it. It's not a state which can be fought against and likewise everyone handles it so differently. My mistake was thinking I could. My mistake was not checking my own mental wellbeing before contributing those spare hours to work, to projects, to anything really.

## Resources

- [Cover Image: Photo by Rene Böhmer on Unsplash](https://unsplash.com/photos/pfuoqnpClno)
- [Jame's Original Post](https://grommers.wordpress.com/2021/05/04/my-most-notable-failures/)
