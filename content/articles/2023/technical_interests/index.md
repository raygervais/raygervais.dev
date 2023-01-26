---
title: Technical Interests for 2023
date: 2023-01-25
tags: ["Open Source", "Rust", "Kotlin", "Go", "Elixir", "Cloud Native", "Cloud"]
Cover: https://images.unsplash.com/photo-1496715976403-7e36dc43f17b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8
---

*Ray, what are your goals? What are your aspirations for 2023? Where do you want to take your career next? How’s the music coming along?*

I cannot express the number of times I’ve been asked questions like these, and sadly I never could give a good answer to them, it was simply something that I didn’t have the mental capacity or energy to think of at the time. Over the Christmas holidays, whereas I should have started thinking about exactly these topics, I opted instead to have a lazy, non-future-forward-looking holiday; I delegated the thought experiment to be January’s problem. Yet, time, though linear, doesn’t feel to be linear and so, we’re nearing February.  So, let me share with you some of my thoughts and interests that as of this moment, I want to pursue and explore this year *when possible*. Wait, what does that last part mean? Well. I’m familiar with burnout, and even with these interests, I don’t wish to dance the same dance I’ve done before which flirts so well with burnout, so I’m not holding myself strictly to the following interests as a *must achieve*, but more so as possibilities. As a metaphor, if given the keys to a candy shop, and you’re in the mood for candy, here are the candy that I’d select depending on the day. Terrible metaphor, I know. I hate candy, but you get the point I hope.

## Programming Languages

### Rust

![Rust Logo](https://www.vectorlogo.zone/logos/rust-lang/rust-lang-ar21.svg)

I truly enjoy writing little CLI applications and other small items which run on a system, so the interest in such a language shouldn’t be a surprise. Furthermore, I want to build a few projects using it’s ecosystem so that I can attempt to understand all the developer hype which no one can escape from; plus, I have my own gripes with Go and want to compare the two. I’m not blind to the difference in common use-cases between the two languages, but when I’m feeling brave enough, perhaps I’ll experiment with melding my Cloud Native practice with an up and coming concept, https://github.com/awesome-rust-cloud-native/awesome-rust-cloud-native! Lastly, I want to revisit a practice of learning which I haven’t utilized since college, books! Specifically, 2022 release: [the Zero to Production in Rust](mazon.ca/) which I received as a gift over the holidays.

In some ways, I suppose I also have my friend [Tryton](https://trytonvanmeer.dev/) to both thank and blame for the growing interest. These past few years have had us sharing interesting Linux tools & applications, comparisons between platforms, and evaluating how you’d write an application in Go vs Rust.

### Kotlin

![Kotlin Logo](https://www.vectorlogo.zone/logos/kotlinlang/kotlinlang-ar21.svg)

In my professional career, I’ve had the interesting circumstance where there’s never been a requirement which required me to work with a JVM language, not even a Springboot API yet. Having worked quite deeply with Go for the past two years, along with switching from iPhone to Pixel purely to see how the Android world has evolved, why not see how the developer experience and process has evolved as well? You may remember my blog post [My First Impressions of Udacity's Kotlin for Android Development](https://raygervais.dev/articles/2019/01/my-first-impressions-of-udacitys-kotlin-for-android-development/), where I went through the available three lessons course provided by Google and was left wishing that they had released all of the lessons listed back in 2019. Upon reviewing earlier in 2022, I noticed that more lessons where added! Even-more-so, it appears that Google’s been going absolutely crazy partnering with various platforms to release a multitude of training and courses:

- [Android Basics with Compose](https://developer.android.com/courses/android-basics-compose/course)
- [Android Basics with Kotlin](https://developer.android.com/courses/android-basics-kotlin/course)
- [Jetpack Compose for Android Developers](https://developer.android.com/courses/jetpack-compose/course)
- [Modern Android App Architecture](https://developer.android.com/courses/pathways/android-architecture)
- [Accessibility](https://developer.android.com/courses/pathways/make-your-android-app-accessible)
- [Kotlin Coroutines](https://developer.android.com/courses/pathways/android-coroutines)

So, I have my eyes on completing the original course I had started, along with trying out Jetpack Compose for Android Developers this year!

### Elixir

![Elixir Logo](https://www.vectorlogo.zone/logos/elixir-lang/elixir-lang-ar21.svg)

As you know from the occasional blog post, I’ve been diving into more and more functional programming concepts in my everyday work, and distracting myself with the excuse of learning “better ways to program” as I read various articles and tutorials at 2am. Haskell, though incredible according to the majority, seems too out of reach for me just yet, and Scala or Clojure don’t fit into my JVM curiosity while Kotlin is still the plan. Perhaps in the future if Kotlin doesn’t pan out, I’ll explore Scala or Clojure, but for now, I want to explore a language which has a platform of it’s own. Elixir fits that bill, and I can’t help but be intrigued at what it’s capable of. Plus, the Pipe `|>` operator language feature looks damn cool, and I’m scared that if I were to learn and use it, I’ll miss it everywhere else I go. I only have two concerns, but they don’t detract from the overall curiosity: 

1. Elixir is a dynamic language, which isn’t a problem by any means, but goes against my current preferences to write with statically typed languages where possible.
2. Elixir is heavily influenced by Ruby, and thus uses Ruby syntax, which I have never really enjoyed. I know, call me the odd one out.

## The Cloud Native Computing Foundation

![Cloud Native Computing Foundation Logo](https://www.cncf.io/wp-content/uploads/2022/08/cncf-color.svg)

In the past year, I’ve had the opportunity to dive deeply into working with a few projects from the [CNCF landscape](https://landscape.cncf.io/). Notably:

- Argo, Flux: Continuous Integration & Delivery
- Helm: Application Definition & Image Build
- Operator Framework, Kubebuilder: Application Definition & Image
- Tigera: Security & Compliance

And yet, there’s so much more within the CNCF! I could be naive and say that I want to learn them all, but that’s incredibly unrealistic and equally less possible without going absolutely insane.  Instead, I want to approach what I believe to be a much saner and reasonable goal: test out and leverage a service from each category (of interest) in some project of my own. This way, I enable myself to be exposed more so to the cloud native concepts which elude me day-in-day-out while also equipping my understanding of how all the pieces fit together in smaller, targeted pieces. For those who see the CNCF landscape as an absolute mess, I’d highly recommend giving [Navigating the CNCF Landscape, The Right Way](https://www.youtube.com/watch?v=u7vUA61sZI4) a watch. Though the following could change, and I’m certainly just listing projects which seem appealing here, not so much implying they’ll be `used` in my own project and research, here’s where my gaze is dwelling:

- Database: [CockroachDB](https://github.com/cockroachdb/cockroach)
- Service Proxy: [Traefik](https://github.com/traefik/traefik)
- Monitoring: [Prometheus](https://github.com/prometheus/prometheus)
- Application Definition & Image Build: [Podman](https://github.com/containers/podman)
- Security & Compliance: [Open Policy Agent](https://github.com/open-policy-agent/opa)

## Resources

- [Cover image: Photo by Billy Huynh on Unsplash](https://unsplash.com/photos/W8KTS-mhFUE)
