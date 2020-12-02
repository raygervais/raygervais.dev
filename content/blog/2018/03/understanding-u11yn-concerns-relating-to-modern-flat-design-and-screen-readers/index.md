---
title: "Understanding U11YN Concerns Relating to Modern Flat Design and Screen Readers"
date: 2018-03-19
draft: false
tags: ["Open Source", "A11Y", "Opinions"]
description: "Accessibility is one topic which not many take into account when designing and developing an application, website, or printed media even. The concept of visual and interactive accessibility relates to any medium which the user uses to discover and consume content from, and how different impairments hinder the common forms and designs useless and nonconsumable."
Cover: "images/photo-1449087989455-465ae815dbf2.jpg"
---

# Introduction & Screen Readers

Accessibility is one topic which not many take into account when designing and developing an application, website, or printed media even. The concept of visual and interactive accessibility relates to any medium which the user uses to discover and consume content from, and how different impairments hinder the common forms and designs useless and nonconsumable. Easiest way to explain that last statement is this example: Imagine being unable to read the standard news headline found on newsprint or websites, but still wanting to know what the world around you is doing. How might one approach this if they don't wish to listen to a TV or Radio? How might one discover headlines around a certain topic that the locals gloss over? Screen Readers and accessible websites. This [video](https://www.youtube.com/watch?v=7Rs3YpsnfoI) can explain the concept and need far better than I ever could, and hopefully also provides a foundation which segues into the important attributes which screen readers utilize in more detail.

## Element Hierarchy

_[Resource](https://www.w3.org/WAI/tutorials/page-structure/headings/)_ Many developers disassociate the levels and semantics of element hierarchy when designing and developing, opting for H2's because H1 is too big for example in article titles. Often, I've seen cases where the H2s were used for titles, and H4s used for subtitles. Though the overall aesthetic may look better for your needs, this does not comply with the established semantics which screen readers / interceptors read to the end user, furthermore it also messes with Search Engine bots looking for content on your website.

If it's a more unified overall font sizing you're looking for, use a normalizer stylesheet such as [NormalizeCSS](https://github.com/necolas/normalize.css/) or a css framework such as [Bulma.IO](https://bulma.io) which dictates all text the be the same normalized size among supported browsers (implying that you will edit / extend for custom font sizing).

## 'Fake' Elements

_[Resource](https://www.ebayinc.com/stories/blogs/tech/how-our-css-framework-helps-enforce-accessibility/)_ When is a button not a button? Well, aside from the philosophical test which also has us questioning what truly is, and what isn't, we can discuss again how different element tags provide unique attributes which are useful to screen readers and screen interpreters. Likewise, as the blog explains, these attributes are critical to proper understanding of a screen and the contents on the page. Using fake a tags styled to look like buttons, or divs with backgrounds meant to impersonate an image make interpretation of the page borderline difficult.

## Contrast and Colors

_[Resource](http://accessible-colors.com/)_ It's a good thing that most developers admit that they should never design, because in truth it's not a skill many have in their genes. I suppose the opposite can be said for designers attempting to program, but I digress. Perhaps a different day's story. When it comes to design, there is a ratio which many choose to ignore because modern aesthetic demands it, contrast ratio.

WCAG Level AA sets the golden standard for how the contrast ratio is defined, that is the difference between two colors (_commonly background and foreground_) such as text and parent element or borders and container backgrounds. AA compliance is a ratio of 4.5:1, which demotes many of the grey on gray choices of modern design. This is important because too little of a ratio makes text unreadable, and too high of the ratio is semi-literally blinding to even the common user.

# Part One Conclusion & Examples

I hope to update this article later in the week with real-world examples and explanations of these details more, along with following up with the next segment which would include aria tags! If you made it this far, thank you for reading and I hope you enjoyed!
