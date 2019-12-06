---
title: "The Importance of Documented API for UI Components"
date: "2018-03-24"
---

**An OSD Contribution Update - Part 1**

[![Tutorial Header](https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=37c91c8e3f63462e0739c676dfe8fee8&auto=format&fit=crop&w=2550&q=80)](https://unsplash.com/@helloquence)

# Getting Onboard

Documentation is a topic that often splits developers into two or more camps, those who write and those who don't; an irony since both camps rely heavily on documentation with external libraries to utilize and understand it's respective API. So, when is documentation considered 'good'? When does the documentation fulfill the needs of the developers, and convey the key functionality without proposing self discovery of unknown APIs? This is what I wanted to explore while contributing to Angular Material (https://material.angular.io/), https://github.com/angular/material2. I found a great issue which was requesting for more documentation for their material stepper, https://github.com/angular/material2/issues/10381 and I thought it would be a great introduction to their community while providing a changeset which benefits more than just developers or current users of Material. Updating documentation helps everyone, and in a few examples from my task I'll explain my thoughts on why I think so.

# Current State of Stepper Documentation

As the issue suggested, the documented examples for the stepper component was lacklustre... sparse even. The API was listed in beautiful English, but no interactive examples were present which displayed the various states, attributes and data-flow which the component offered. The recommendation by [mmalerba](https://github.com/mmalerba) was to provide better examples between various state flags, icon matching, and expansion of the original example.

[![Current State of Stepper Example](images/Screen-Shot-2018-03-24-at-4.53.26-PM-1024x362.png)](http://raygervais.ca/wp-content/uploads/2018/03/Screen-Shot-2018-03-24-at-4.53.26-PM.png)

One item that I had noticed was the button to 'toggle linear' mode for the stepper never actually toggled the state, but instead set the state to true (meaning linear is enabled) and nothing else. No toggling (enabling / disabling of linear state), just moving to a single state. This was the first item I wanted to address since as a user, I'd want 1) visual feedback and 2) the option to toggle and switch between states in the example. All the foundation was already there for such an update, and it became my first commit into what would be the [Angular Material](https://github.com/angular/material2/pull/10537/commits/33c0607f5af7d286aa7d7dd4dd11dd84afb99da4) project.

# Creating Examples for Edit and Optional Steps

For the documentation, I saw that there were no tangible examples of the edit and optional attribute Inputs of the Material Stepper, a need which needed to be met. This is where my Pull Request started, with implied intent that I'd add more if mmalerba or I found more appropriate examples which could be utilized for the stepper component to display even deeper functionality.

I can say that reading the documentation gave me a thorough understanding of the components API, and that creating the examples which will be used to explain said API was also a easy task, but that is because I've worked with Angular and UI Frameworks such as Material for almost a year now non-stop. To the beginner, to the one who's experimenting with Angular Material for the first time, this documentation and API is daunting. Despite the well written content, proper examples help to truly establish a thorough understanding of the framework in my opinion.

For either example, the process was the exact same. Copy the foundation (Stepper Overview Example), and modify the attributes, title, and toggle logic to accommodate the specific example itself on one of the steps. This way, the examples mirror each other instead of presenting the reader with different context every time. The changes are borderline single line changes, but abstracted away to their own components for clarity:

// Allows one to skip over the step without validation steps rejected going to next step.
\[optional\]="true"

// Allows one to return back to this step to modify the previous value after moving to next step.
\[editable\]="true"

# Meeting Contribution Guidelines' Compliance

This is the first project I have worked on Open Source wise which has a predefined commit message structure (which I totally love!) to make the development process both more uniform and accessible to those doing the review. It took a few commits to truly embed into my habits the proper structure, which looks like this (taken straight from CONTRIBUTING.md):

(): 
 The documentation did not provide any Pull Request related specifications, so I did my norm and hoped for the best -making it clear that it's possible I overlooked, disregarded, or even added too much to a specific area. Really, I gave them the putty and asked for hands to show me how to mold it to their liking.

Mold it they did, leaving comments on the code review which suggested a better practice, more uniform styling or removal of unnecessary code blocks. More on that can be found [here](https://github.com/angular/material2/pull/10543). All of the first round of code review were stylistic changes, which I was happy to fix since it also showed a gap in my understanding of their accepted coding guidelines.

# Thoughts so Far

[![Spinning wheel of Light](https://images.unsplash.com/photo-1502085026219-54ac00e06fd9?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5d4742fb163936fc4ec6b1f5d188f408&auto=format&fit=crop&w=2814&q=80)](https://unsplash.com/@jeremyperkins)

This is the first contribution I’ve worked on which primarily dwelled on documentation, my \`niche\` being more of that relating to accessibility or editor features. I like to think this is equally, if not even more, monumental because it makes the code base itself and the components which are offered to developers more accessible; enabling their work with far less friction so they can further push the technologies farther. Mmalerba has been incredibly helpful so far, and also very accommodative to a new contributor who does not know his way around the code base or expectations when testing and documenting their changes. 

Furthermore, it’s awesome to pick up a technology that I feel proficient with for a change, instead of having to learn (which is great, don’t get me wrong) a new one including  all the bells, whistles, errors, and painful realizations that you should have started weeks before. I’m confident that I still have hundreds if not thousands of hours to learn on Angular alone, but I also see it as a tool which I can already start giving back to in any way possible.
