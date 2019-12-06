---
title: "The Importance of Properly Setting Up Your Linter"
date: "2018-04-05"
---

Or, How to Break Every Travis Build Your Commit Creates!

**An OSD700 Contribution Update Part 2**

[![](https://images.unsplash.com/photo-1471940393269-df205607fb2a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3063610257d9a5afe117170bb5029c89&auto=format&fit=crop&w=2550&q=80)](https://unsplash.com/@larisabirta)

# Preface

This week, having thought I had climbed and conquered the smallest imaginable version of Everest, I climbed into my favorite chair, put on headphones, and let hours pass by while finishing \`Haunted Empire\`. My phone went off during this time, but unless it was a call or message, I thought nothing of it. I finished the book, pleased with the epilogue and wondering if had it been updated with the current exploits and affairs of Apple, would the ending remarks differ.

# Mountains of Coding Guideline

Upon returning to the world, I was greeted with the results of my climb of Everest; a new mountain of style corrections and lint errors to be corrected. I thought I caught the majority in my previous climb? Why did my IDE (Visual Studio Code at the time) not catch the issues? Was this the first opportunity which would impact the impressions the maintainers of Angular Material have on me? On my contributions? I had to first discover why these slipped past my editor.

## ESLint vs TSLint

Before going into the issues which I had to correct, I wondered why the codebase didn't display the wonderful red lines (depending on your theme) which similar to writing your thesis, implies a mistyped item. In my case, the red lines would have displayed most of the issues listed below, but I never knew we were playing hide and seek during this playful hour. See, the reason for this game I found after a few minutes of experimenting and digging, was that my installed ESLint plugin did not bother with TypeScript files, and likewise for some reason my local instance didn't have the TSLint plugin installed at the time. That second point really drove the entire issue, since installing the plugin instantly brought back my favorite frenemies and revealed any issues relating to my TypeScript files.

The lines returned, pointing out the flaws in the components I had worked on relating to the preconfigured rules for Angular Material, and that is also how I learned about their code style more so than the previous contribution. Below I've outlined some of the items which are easier to gloss over, and my thoughts as well.

## Spaces vs Tabs, and Spacing Count

Angular Material indentation requirements is 2 spaces per indentation. Despite every source file containing this indentation style, Visual Studio Code still used 4 spaces as the defacto standard while the project was open.

Perhaps I am supposed to configure this beforehand, but the fix itself was as simple as toggle the indent settings at the bottom, \`CTRL + P\` / \`CMD + P\`, and using the \`reindent lines\` command to correct. Without getting into the whole space vs tabs argument, always ensure that your editor / IDE is configured to comply with the coding style of the project, regardless of what that specific compliance is. I'd love to push for a indentation standard which can be applied in ESLint / TSLint which editors such as Atom or VSCode can then extend into their linters. Maybe a summer project idea?

## Formatting, Trailing vs Leading

We all pick up habits from people, projects, and our idols in ways both which we are aware of, and unaware of. I didn't realize how much I favored leading commas until David pointed it out while I was working on the Thimble Editor a year ago. This habit came from my previous COOP with Technicalities, where experience there dictated that leading commas were a good design choice to be following in every project. I must have picked up and endorsed this coding practice for the vast majority of 2016 to 2017.

## Using Thoughtful Examples

[![](https://images.unsplash.com/photo-1500021804447-2ca2eaaaabeb?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=510608b1165db1e48889a8a059dd5d1e&auto=format&fit=crop&w=2550&q=80)](https://unsplash.com/@the_roaming_platypus)

So this one is more of an opinion compared to style guide, but I do believe in the point which was conveyed and the requested change. Essentially, while working on https://github.com/angular/material2/pull/10666, I used the same example content as the StackBlitz, meaning I had the following data to work with:

speciesGroup: SpeciesGroup\[\] = \[
    {
      letter : 'C',
      name : \[ 'Castor', 'Cat'\]
    },
    {
      letter : 'D',
      name : \[ 'Dog', 'Dragon'\]
    }
 \]

At first, I thought that this was appropriate since if you typed \`D\`, then \`Dog\` and \`Dragon\` would be displayed while the \`C\` option group disappeared, implying what was expected workflow wise. Expanding from there, if the user typed \`Dr\`, \`Dog\` would follow \`C\` and disappear since it no longer complied with the conditional statement. It was a to-the-point example which I thought carried the concept across in this StackBlitz fork I had [done](https://stackblitz.com/edit/angular-smg2xm?file=app/app.component.ts).

[Kristiyan](https://github.com/crisbeto), one of the maintainers of Angular Material, requested that instead of using this dataset, I use the United States (or a bigger data set), so that the users and document readers could play with the example and see more results being filtered down, brought back, or removed from the criteria entirely. It made sense, why demo a filterable list with only four elements when you could with fifty elements instead? I forked my original StackBlitz and then updated the data list to the new topic. I learned few items from this task which I've listed below, and if you want to see the final StackBlitz, you can find it [here](https://stackblitz.com/edit/angular-hb3sdt?file=app%2Fapp.component.ts).

- The USA has 50 states (yay geography teachings!)
- Compared to Letters \`D\`, \`F\`, \`G\`, \`H\`, \`L\`, \`P\`, \`R\`, and \`U\` which have a single state, \`M\` and \`N\` have a damn huge number of states. An unbalanced amount if I may say so. 16 damn states between the two, which is double the amount per letter of the other set.
- I really don't know my geography (Jack can attest to this, who enjoys pointing out this flaw when ever we somehow brought up travel).
- This is a much better example, both in content and concept. Filtering through states seems like such a common use case for some compared to sorting through 4 separate animals. It's tangible, relatable.

# Integrating Prettier Into More Workflows

I heard of the [Prettier](https://github.com/prettier/prettier/) formatter a few months ago while working on a school project, and never really thought of how valuable it would be until after this small bit of debacle. It made me think, how much time is wasted on formatting per commit and how we spend N amount of time trying to correct it. Why not let the machine format or warn of bad formatting prior to the git commit so that everything which goes through the wire is already in the \`best\` state. I wonder this not for just Angular Material, but ALL established projects which has hundreds of contributors or more. The current offerings by such a formatter is impressive, but I was equally impressed with the upcoming support for Python, Swift, and Java. Likewise, all of the major editors are already supported (Atom, Emacs, Sublime Text, Vim, Visual Studio, VS Code, IntelliJ Platform).

# Next?

Currently, both of the issues I intended to tackle for this release have pull requests by yours truly, and both pull requests have some E2E issues which I'm addressing in between writing this article. You can follow both issues here:

- [docs(autocomplete): Adds option group example #10666](https://github.com/angular/material2/pull/10666)
- [fix(slider-toggle): Fixes incorrect font size for content label #10668](https://github.com/angular/material2/pull/10668)

I really wanted to snag a third small item into the list, but time was not on my side for the past two weeks with other items and priorities had to be addressed firstly. At this rate, my current plan of attack for the final release (damn time is moving quick) is to pick similar sized issues which can be done in a few hours, and see how many are possible with valid fixes, good code, and not breaking every possible end to end test I can imagine.
