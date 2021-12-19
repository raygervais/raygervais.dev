---
title: "Learning Python with Doom, Part 1"
tags: ["Python", "Open Source", "Linux"]
date: 2021-11-07
Cover: images/nathan-dumlao-YPfyDFiNfcg-unsplash.jpg
description: "For the past month, I've been living at my dad's after a retinal detachment surgery left him both unable to drive or conduct detail sensitive work for a few weeks. In that time, he's been asking me about how the modern technical landscape compared to his previous experience where Visual Basic, Lotus Script and the early builds of .NET dominated the late 90s, Y2K, and early 2000s scenery."
---

*Or, how to teach a newer language to someone acquainted with Visual Basic while keeping the interest relatable*

For the past month, I've been living at my dad's after a retinal detachment surgery left him both unable to drive or conduct detail sensitive work for a few weeks. In that time, he's been asking me about how the modern technical landscape compared to his previous experience where Visual Basic, Lotus Script and the early builds of .NET dominated the late 90s, Y2K, and early 2000s scenery. More so, I wanted to find a tangible way to learn instead of repeating the lessons of yesterday and explaining "This is an `int`, here's how to convert it to a `str`". Instead, I wanted to make him Google that when he had an objective which he believe needed it. To begin with, I had him watching YouTube tutorials as I sought out the best course of learning.

While up north, I had also got Doom 3 running on the Fedora 34 setup and had been playing with him watching, similar to how we had done so a decade earlier. After dying so many times on one of the simplest of difficulties, it hit me. A death count script which would do simple logic to read, increment and write the new death count. It was a tangible little box of supply and demand; of joy and learning; of the road towards Python 3.10 mastery. Below is an example of the of the file and description:

```python
#!/usr/local/bin/python3

# File: main.py
# Author: rayzor


"""
When running ./dead.py, it should read the value from
counter.txt which is located in the same directory and
increment the value before overwriting the value back to the 
same file
"""
```

And the final implementation after he had done some Googling.

```python
data = None
with open("./count.txt", "r") as f:
    data = f.read()
    
print("You've died " + data + " times!")

with open("./count.txt", "w") as f:
    f.write(str(int(data) + 1))

print("We've incremented your death count by one.")
print("Try to do better, ok?")
```

## So What's Next

Right now, as we go about this process he's also learning quite a bit on his own via YouTube tutorials which have him recreating Tetris, Pong, and Space invaders. These are fantastic learning exercises which will help boost his Python understanding alongside my more functional-assignments which explain more of the concept of an application being good at a single task. In a few posts over this month, I hope to publish on the following topics (and also have him implement) and am of course open to feedback and suggestions:

*Python Basics*

- Introduction to Python, reading and writing from a file
- Reading and writing to a CSV file
- Adding a terminal prompt for level / comment
- Refactoring logic into functions
- Adding application logging

*Application Basics*

- Adding CI/CD lint checks via Github Actions
- Reading and interacting with SQLite databases
- Formatting data

*GUI Basics*

- Using the Qt GUI Framework to Print Death Count
- Adding a new Death via GUI
- Adding a Level Dropdown field

*Distribution*

- Bundling for Linux Distributions
- Bundling for MacOS
- Bundling for Windows


## Resources

- [Cover Image: Photo by Nathan Dumlao on Unsplash](https://unsplash.com/photos/YPfyDFiNfcg)