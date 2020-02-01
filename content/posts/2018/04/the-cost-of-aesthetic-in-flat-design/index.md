---
title: "The Cost of Aesthetic in Flat Design"
date: 2018-04-19
published: true
tags: ["Open Source", "Seneca", "OSD700", "Angular", "Material Design", "A11Y"]
cover_image: ./images/photo-1493462045127-9bf32e5f133a.jpg
description: "For the final release, one of the issues I wanted to focus on was [this](https://github.com/angular/material2/issues/10727), which I figured would be an easy contribution toward the project and a check off of my final release requirements. After reviewing the comments on the issue, I was under the impression that I had to learn a new accessibly standard titled aXe. aXe was going to be the driving force behind this post, but to my fortune it's more of a testing engine than a standard; testing instead web applications and pages against the WCAG 2.0 AA rulesets."
---

_A OSD700 Contribution Post_

For the final release, one of the issues I wanted to focus on was [this](https://github.com/angular/material2/issues/10727), which I figured would be an easy contribution toward the project and a check off of my final release requirements. After reviewing the comments on the issue, I was under the impression that I had to learn a new accessibly standard titled aXe. aXe was going to be the driving force behind this post, but to my fortune it's more of a testing engine than a standard; testing instead web applications and pages against the WCAG 2.0 AA rulesets.

Evaluating the issues with a page relating to WCAG AA compliance is made easy with the aXe engine: https://axe-core.org/, and even displays in the results how to better improve or fix rulesets such as contrast and sizing. So, I was on familiar ground. A ground which many never bother to consider since they avoid the cracks and spots of mud as they walk along. I decided to use the engine's results as a guide towards patching the cracks, cleaning up the mud. One has to wonder, what is the consequence of such patches?

I first looked into the Material Design stepper [specification](https://material.io/guidelines/components/steppers.html#steppers-usage) and [accessibly](https://material.io/guidelines/usability/accessibility.html) pages, where items such as contrast and sizing were addressed in a stark-yet-not-half-assed manner. The rules made sense, but they still did not comply with WCAG AA requirements and better yet, disregarded many of the colour rules to forward a flat aesthetic. The website the documentation is running on fails multiple guidelines, meaning that this correction would come from ideas, discussion, and if accepted, deviation from the very guideline which established the design of the project. Damn.

_Before_ ![](./images/38842321-47956af8-41b7-11e8-8adb-22ab405e90ad.png)

_After_ ![](./images/38842470-23a37b66-41b8-11e8-8702-5e417194b570.png)

I left a [comment](https://github.com/angular/material2/issues/10727#issuecomment-381795454) which described the most transparent way of fixing the A11y issues with the stepper, opting to darken the text to meet the bare minimum of the compliance guidelines. It was as I was typing the comment and proposed changes, that I realized just how little people would care for such a change, or how quickly I'd be thrown off the boat for attempting to go against the design specification.

[![](https://images.unsplash.com/photo-1511164657592-59a452023479?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=31d00bfc36adcf0ffcce0f452f709b10&auto=format&fit=crop&w=2850&q=80)](https://unsplash.com/@15june)

The change that I proposed is very small, bringing up the alpha layer of the RGBA font / background colours from 35% to 54%, which brings us to the compliant 4.5:1 contrast ratio. I figured this was better than changing the colours themselves which, good luck doing so since we are playing with `#FFF` and `#000` through and through. Kids, this isn't your Dad's CSS.

In the past few weeks, I've been horrendous when it came to OSD700's work, often appearing dark f or a week in span, my work for the course at a standstill in that time. Three days after posting the comment which I hoped would stir discussion, still not a single response. Perhaps I need to give them a week as well, moving onto a different issue as my secondary while waiting for the pitchforks or textbooks to fly in with fury once maintainers and developers alike stumble on it.

Regardless, one can only throw his paper plane into the sky and wait for the wind to determine it's direction.
