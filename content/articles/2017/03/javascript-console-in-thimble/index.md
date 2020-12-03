---
title: "JavaScript Console in Thimble"
date: 2017-03-07
draft: false
tags: ["Open Source", "Seneca", "OSD600", "Experiments"]
description: "Originally, my aspirations had drawn my contribution choice to a recently suggested UI enhancement, which can be found in my previous [blog post here](http://raygervais.ca/brackets-enhancement-proposal/). Though it led to some valuable discussions for said implementation, it was decided that until such topic is further conceptualized, my contributions should be spent otherwise in a more concrete topic."
---

_OSD600 Assignment Two Deliverable_

## Introduction

Originally, my aspirations had drawn my contribution choice to a recently suggested UI enhancement, which can be found in my previous [blog post here](http://raygervais.ca/brackets-enhancement-proposal/). Though it led to some valuable discussions for said implementation, it was decided that until such topic is further conceptualized, my contributions should be spent otherwise in a more concrete topic.

## A New Course of Action

Dave recommend the following [bug](https://github.com/mozilla/thimble.mozilla.org/issues/1675), which I can say is an incredible venture from my typical comforts or project scope. For one, I had never worked on a JavaScript application of this scope, let alone one which had multiple iframes which transfer data between the two. This task would be a daunting one. At the time of writing this post, the console-injection functionality is not yet completed. Instead, it flashes on my screen both mocking, and inviting me to dive deeper into the source of the error messages, like an old enemy beckoning you to visit the odd time.

Having no fathomable idea where to start, Humphrey explained the best course of action from his experience with Thimble; and sent me on my way down the rabbit hole. Being the fantastic guide that he is, I’ve emailed and queried his knowledge of the data binding, script injection, and various listeners which make Thimble the beast that it is. His responses have always been helpful, and as consequence for my lack thereof modern JavaScript practices, I learned a new syntax, tool, or even just pattern every time I looked at a new file.

## Console.log(“Help”);

I have taken the standard browser’s developer console for granted. That much is evident, with a simple hit of the F12 key bringing up it’s familiar user interface and a list of error messages, GET requests, and other web oddities. Never would I have realized, how advanced the console technology was underneath, looking into simple Console shims for example to see how one ‘steals’ the console.log functionality away from the default implementation. Upon further review, I was told that my first attempt at implementing this issue was in the wrong direction entirely -a fact which should have been obvious to me after attempting to rebuild the project multiple times with no changes to the code.

Once directed to the correct directory, and pointed to similar functions to use as a base, the adventure begun. The first item of question, was simply the syntax of the files. I’ve compiled a table below which gives a few syntax - explanation like entries which may be useful for those who like me, never worked with ES6 JavaScript before.

Syntax

Explanation

Source

“Use Strict”

Strict mode helps out in a couple ways:

1. It catches some common coding bloopers, throwing exceptions.
2. It prevents, or throws errors, when relatively "unsafe" actions are taken (such as gaining access to the global object).
3. It disables features that are confusing or poorly thought out.

[Here!](http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it)

define(function (require, exports, module)

If you wish to reuse some code that was written in the traditional [CommonJS module format](http://wiki.commonjs.org/wiki/Modules/1.1.1) it may be difficult to re-work to the array of dependencies used above, and you may prefer to have direct alignment of dependency name to the local variable used for that dependency. You can use the [simplified CommonJS wrapper](http://requirejs.org/docs/commonjs.html) for those cases:

[Here!](http://requirejs.org/docs/api.html#cjsmodule)

var x = function()

A JavaScript function can also be defined using an **expression**. After a function expression has been stored in a variable, the variable can be used as a function.

[Here!](https://www.w3schools.com/js/js_function_definition.asp)

# Thoughts on ES6 && JavaScript

One item I had come to learn from the first release, is the coding standard when it comes to naming conventions, spacing and formatting of the Javascript files, since this was applied to all of the .LESS files too. With that being said, I feel confident that my code being pushed to my [forked repository](https://github.com/raygervais/brackets/) meets their conventions. Perhaps inherit to ES6, RequireJS and modern frameworks, I found the code being written and the previously written source code to be incredibly readable in stark contrast to that of C, C++ or even Java in some cases. This could be the case with my overexposure to JSON files creating a illusive blanket of familiarity.

Why do I say this blanket is not what it may seem to be? Simply put, the code I’ve attached below is the embodiment of all I never knew was possible with a scripting language. Having spent a large amount of time swimming through the documentation of SWIFT 3, some of these concepts are relatable at best. I suppose once I develop more and more with these technologies, it will become second nature.

// Returns a function which calls the specific function in scope
var bind = function(func, scope, args) {
var fixedArguments = Array.prototype.slice.call(arguments, 2);
return function() {
var args = fixedArguments.concat(Array.prototype.slice.call(arguments, 0));
(func).apply(scope, args);
}
}

Ironically, Dave provided me with an interesting request he had come by recently, describing how some teachers were using Thimble as their primary teaching environment and were longing for such a JavaScript console to exist. This only signified the importance of such feature to be added to Thimble, and left yours truly with a stronger drive to get it done.

## Implementation

For this release, my task was to create what would be the background data-intercepting tasks that would drive the custom console for Thimble’s preview window. At the moment, my implementation of said back end is almost complete, a [pull request has been set up sent for the maintainers review.](https://github.com/mozilla/brackets/pull/624) The initial pull request had a single syntax error detected by the Travis CLI, which was fixed in a later commit. This allowed for integration tests to pass the request, making the pull request much more enticing for the developers.

As you can see from the pull request link above, it wasn’t all sunshine and rainbows. Instead, to my surprise, the developers requested changes. These changes, though minor in complexity and not an issue in any form, proved one thing; I still had the faintest clue how JavaScript, and Thimble itself worked.

After changing the requested fixes, which included deleted unnecessary variables and replacing a function with a cleaner method, there was only one fix left before the request would be merged with master. Hope, was but a few keystrokes away. After some debate between a few maintainers on the implementation of the script injection -one of which, I attempted to follow their practices as if following a treasure map to gold simply for I had no experience which would equate to a valued opinion, it was decided that my original implementation was appropriate for the scope of the function, with their preferred methods not working in this case.

## Next Steps

Below this, I’ve included a screen of the current functionality of the implementation,which as you can see, is still bare. The next steps revolve around making a user interface centric to the bramble console, and also fleshing out the console to incorporate more functionality including common methods such as .error, .warning, .assert, and .table to name a few. Though now a discussion is required to dictate the best area, layout and functionality to implement first, I will keep building out the console to best accommodate it’s uses for educators and hobbyists alike. [![Bramble Console V1](./images/Screenshot_20170306_212440-1024x494.png)](http://raygervais.ca/wp-content/uploads/2017/03/Screenshot_20170306_212440.png)
