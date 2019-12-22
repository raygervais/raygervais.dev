---
title: "Approaching Accessibility with Visual Studio Code"
date: 2018-02-11
published: true
tags: ["Open Source", "Seneca", "OSD700", "Visual Studio Code"]
description: "For the last three years, I've grown a passion for extending technologies towards a direction which makes them more accessible for a wider range of users. It took a while to realize what accessibility truly meant in the world of development, software, websites and health organizations. Through the process, I took a course on behalf of my employer at the time to learn the three levels which make up the Web Content Accessibility Guidelines (WCAG) 2.0, A, AA, and AAA. This course took me through so many spirals of knowledge and issue, all-encompassing different scenarios and acceptance criteria for web development. After taking the course, I started to see software design and accessibility very differently. Contrast between colors, element organization, font-sizing even became subject of my mental focus at first."
---

_An OSD Contribution Update_

For the last three years, I've grown a passion for extending technologies towards a direction which makes them more accessible for a wider range of users. It took a while to realize what accessibility truly meant in the world of development, software, websites and health organizations. Through the process, I took a course on behalf of my employer at the time to learn the three levels which make up the Web Content Accessibility Guidelines (WCAG) 2.0, A, AA, and AAA. This course took me through so many spirals of knowledge and issue, all-encompassing different scenarios and acceptance criteria for web development. After taking the course, I started to see software design and accessibility very differently. Contrast between colors, element organization, font-sizing even became subject of my mental focus at first.

When looking for issues and improvement requests in Visual Studio Code, I decided for this round that I wanted to explore and help improve how we handle accessibility within the platform. This led me towards two bugs which relate directly to the newly released custom drop-down component which was apart of the February 1.20 release. I thought this would be a great outlet for contribution since it's a brand new component to the project, enabling me to also seat myself if possible in that domain and help update and upgrade the component over time.

## Monokai Drop-down Selection Theme

This bug was originally an issue directed towards how the Monokai theme handled drop-down selection indicates the currently selected item. After discussing in the issue how to handle the fix, a proposed quick solution was implemented and tested. Changing the `list.focusBackground` to a different color of the Monokai theme, thus 'fixing' the issue.

The reason why I said 'fixing', is because this very small, single line fix also produced evidence towards a bigger issue with the drop-down component which would span all custom themes. Essentially, there was no way to promise this improved accessibility for custom themes which set `list.focusBackground` to a non-common theme color, since the attributes used in many components alongside the drop-down.

Christopher Leidigh known as [@cleidighon](https://github.com/Microsoft/vscode/issues/assigned/cleidigh) on GitHub, developer for Visual Studio Code, and also contributor to the new drop-down component provided a non-intrusive update which provided a new attribute titled `dropdown.listBackground` which is used by the component if it exists. With this update, switching `list.focusBackground` back to the previous color and using `dropdown.listBackground` provides the bugfix without breaking the established patterns of decade old themes, and custom editor themes. I have a feeling that this will be expanded later to accommodate APIs and contrast-awareness functions. The final PR can be found [here](https://github.com/Microsoft/vscode/pull/42869)

## Escape Key Should Revert Selection to Previous State

Again approaching accessibility improvements and learning more of the drop-down component, I was introduced to this [bug](https://github.com/Microsoft/vscode/issues/42487). Essentially, it is a request to return the common behavioral pattern of when a user hits escape during text input modification, return to the original state. A simple concept, and I had an idea which is in my work in progress PR which is found [here](https://github.com/Microsoft/vscode/pull/43152).

Essentially, store the currently selected index when opening the drop-down component, and in `onExit` and `onBlur` restore the selected item back to the original state. Simple enough I think. There isn't any magical React / Redux paradigms occurring here, so I feel pretty confident in my initial approach and, based on Christopher's initial review of my attempt, we share the same mindset for this update.

## Conclusion

Was this a huge contribution / release? No. That I can admit, and if I do have time I'll try to find a bug to make up for the lack of substance. This round of open source interactions allowed me to discover a few interesting lessons, some of which I consider as valuable:

- A single one line bug fix can produce a tentacle of other bugs and or politics.
- Accessibility is a characteristic which can be easily overlooked, and is overlooked often times by the common developer.
- Working remotely with developers in different time zones can create one of the most interesting plots of disconnect and resource-management that I've ever seen. You see their replies in the morning when perhaps they are calling it a night. This grants you HOURS before they'd see your reply, providing space and resources to plan out both your intent and knowledge base towards the issue and the reply. Likewise, it's very easy to fall into the trap of waiting around for a reply as I did during segments of this release, which is ill-advised if one is seeking continuous progress and movement.

Going forward I really hope to discover more improvements or bugs relating to the drop-down component or various other UI elements, ones revolving around accessibility being preference. Code is so much bigger than I would have ever imagined, and seeing the following response from a well-respected Developer such as Christopher admitting that even he is only scratching the surface lifts my spirits when I find myself lost in endless lines of code and confusion. With each new experience, I look forward more and more towards the next step into Open Source.
