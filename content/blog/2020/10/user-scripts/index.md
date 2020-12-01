---
title: Four Rules for Writing Scripts in Enterprise Environments
draft: false
date: 2020-10-14
tags:
  [
    "Linux",
    "Lessons",
    "BASH",
    "Microsoft Azure",
    "Google Cloud Platform",
    "Open Source",
  ]
images: ["./images/robynne-hu-HOrhCnQsxnQ-unsplash.jpg"]
description: "Simply put, every environment I've worked in has had it's varied segregation of both MacOS and Windows-based workstations. When writing scripts in BASH, I found out the hard way that opening such a file in Windows (such as Notepad.exe, a classic for many) would automagically convert the line endings which would lead to the script breaking. When an entire team was using Windows 7 laptops and my team on MacOS, I had to explicitly put in both release notes for the script-based utility along with the repository header to not open the files in Windows."
---

_What three years working in Enterprise Environments has Taught Me About Scripts_

## Always Provide Confirmation Prompts

You've heard the term fat-fingering, which implies the slip of a key leading to production going down when you `accidentally` click said button which runs the `destory_production.sh` script lurking on your desktop terminal. Well, here's a great way to remove such a risk which I'd advise for any scripts that have any of the `CRUD` (Create, Read, Update, Delete) concepts in it's logic: provide the user a prompt they must enter a phrase into prior to committing any logic.

```bash
PROCEED_PHRASE="Proceed"

echo "To continue, enter '$PROCEED_PHRASE'"
read proceed

if [[ $proceed != $PROCEED_PHRASE ]]; then
    echo "Task aborted, failed to enter confirmation prompt"
    exit
fi
```

Mine is often `Enter 'Proceed' to continue ...`, which forces the user running with said script to type "`P`, `r`, `o`, `c`, `e`, `e`, `d`" thus, making it far more intentional instead accidental. The most basic of forms looks like the above. Getting to this point implies logic is behind just this barrier which I don't particularly feel comfortable with when it comes to destructive scripts, so there's always another feature of the script which I put into these scripts to ensure that fat fingering is not possible.

## Don't Make It Too Easy For the User

In a CLI, `-no-op`, `-debug`, `-dry` are common elements found which imply "Run this script without executing any of the logic which changes the data, infrastructure, etc". I prefer to go a different direction to ensure that when scripts which migrate, delete or update entire environments are used, it's 100% intentional: adding `--enabled` as an optional parameter. This parameter MUST be supplied along with the confirmation prompt being successful for said transformative logic to be executed in the script. If not, none of the operational logic occurs and the script in question acts like a dry run. I have found this, though tedious to be the safest way to deliver scripts and tooling to users of varying proficiencies. Now that we have the safety measures in place (fun fact, I was going to name this blog post "How to be write user-hostile scripts"), let's discuss the audience's environment and how they'll consume (or mess up) the script.

## Broken Line-endings Everywhere

Simply put, every environment I've worked in has had it's varied segregation of both MacOS and Windows-based workstations. When writing scripts in BASH, I found out the hard way that opening such a file in Windows (such as Notepad.exe, a classic for many) would automagically convert the line endings which would lead to the script breaking. When an entire team was using Windows 7 laptops and my team on MacOS, I had to explicitly put in both release notes for the script-based utility along with the repository header to not open the files in Windows.

Where it's possible, I'd opt to write scripts using Python or Ruby which are far more resilient to line-endings in contrast, but that leads down a slippery path full of pain and technical support which this next topic covers well.

## Reduce Dependencies At All Costs

![Python Environment Hell, XKCD Comic](https://imgs.xkcd.com/comics/python_environment_2x.png)

When writing code which will be used by others in your environment, I've witnessed dependency hell of earth-shattering magnitude. That pretty_printer Python module which makes the JSON look `just right`, yeah that's not apart of the `stdlibs` and is troublesome for your audience who don't have the environment setup similarly to you. Some languages handle this better than others, I find Go and Rust (though not scripting languages by any means) handle dependency management far better for example compared to Python for example (see comic above). There will always be dependencies, and I don't mean to fault languages such as Python because there have been fantastic tools which address and improve some of the shortcomings such as the Virtual Environment `venv` tool built directly into Python 3.

More so, what I want to highlight is the reliance on third party dependencies for the sake of convenience where the payoff is minimal. I'm unsure if anyone would care if the JSON output of your Python script came out in black/white vs multi-colored and rendered emoji unless that's the specific usecase you're looking for. Of course, I'm highlighting the visual "helper" libraries because logic based dependencies such as SDKs should be a no-brainer decision: you need them to do your job.

# Resources

- [Cover Image: Photo by Robynne Hu on Unsplash](https://unsplash.com/photos/HOrhCnQsxnQ)
- [The Nine Circles of Python Dependency Hell](https://medium.com/knerd/the-nine-circles-of-python-dependency-hell-481d53e3e025)
- [XKCD on Python Environments](https://xkcd.com/1987/)
