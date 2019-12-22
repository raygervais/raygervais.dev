---
title: "Giving Life to the Console in Thimble"
date: 2017-03-30
published: true
tags: ["Open Source", "Seneca", "OSD600"]
description: "This short article will elaborate recent developments to the Thimble developer console that I’ve been implementing, with the previous progress post located."
---

_An OSD600 Contribution Update_

This short article will elaborate recent developments to the Thimble developer console that I’ve been implementing, with the previous progress post located [here](http://raygervais.ca/bramble-console-self-console/). Since then, the interface has been ported from a [Bracket’s extension](https://github.com/mozilla/brackets/pull/672) which will serve as the base for the Thimble version. Below, is the current styling and functionality, which is all up for debate and experimentation to further extend the features and usability for developers and educators alike.

[caption id="" align="alignnone" width="3142"]![Original Console State](./images/b50ec7a6-13c7-11e7-87c2-8c522c61b739.png) Console Extension, Original State.[/caption]

In the original state, a few items were scrutinized, leaning on the development cycle to remove, update, fix, or completely reinvent various aspects of the console as I’d work on implementing deeper functionality, usability or features requested. These items are being shifted out, replaced with more appropriate behaviour, which I’ll describe below.

The current implementation of the console takes data from the ConsoleManager, which one of the object managers I had implemented in my previous release which would be used for this exact reason. What this means, is that through all the clutter and warnings which originate from external files, scripts and errors, the user’s console statements stands alone on the console screen. If you wanted to see what is occurring in the outside world -the world outside your code specifically, then the developer console, inspector and various other tools are meant for such the task.

A new [pull request](https://github.com/mozilla/brackets/pull/672) has been created which this time, is an implied work in progress so that [Luke](https://github.com/flukeout) can give criticism and opinions which pertain to the look and feel of the console. Already, Luke’s given some great idea’s including minimizing the console, instead displaying a message badge beside the toggle element for said element. The idea itself I find very useful, and has sparked ideas from yours truly, Dave, and Luke. Another idea, once which may be more useful for the user, is to display the console when a console function first occurs. That is, to have it pop up at the current position only when the User’s JavaScript code requires it, and then be closed by the user when they are done.

[caption id="" align="alignnone" width="448"]![Minimized Console Idea #1](./images/4e2ac034-1495-11e7-89b7-9a89d21f7e69.png) Minimized Console Idea #1[/caption]

Once completed, I’m looking forward to explaining how it works, along with items I learnt over the course of this adventure in another article. I’m incredibly excited, not even for the ‘contribution to an open source project’ aspect of it, but because this console enables a plethora of tools to educators and developers alike inside Thimble. Is this the next big thing? No. It’s just a simple console window. I do think that, by allowing users to even have a dedicated surface for their console.logs, the opportunity to better educate new JavaScript developers while granting access to standard debugging tools -their variables; warning messages, data logs, timers, asserts, is invaluable.
