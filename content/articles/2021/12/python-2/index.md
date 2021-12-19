---
title: "Learning Python with Doom, Part 2"
tags: ["Python", "Open Source", "Linux"]
date: 2021-12-19
Cover: images/kal-visuals-1p_GtkK0SbQ-unsplash.jpg
description: "In the previous segment, which I can apologetically say was released just over month ago, we started on a death counter terminal application. I thought, let's continue on explaining the application and expand on the following topics:"
---

# B.2021.12.01: Learning Python with Doom, Part 2

*Continuing on with our Death Counter Application, or, how, many times can a floating skull kill me?*

In the previous segment, which I can apologetically say was released just over month ago, we started on a death counter terminal application. I thought, let's continue on explaining the application and expand on the following topics:


* Getting setup with the Pyright LSP
* Prompting the user for input
* Refactoring to dedicated functions
* Reading and writing to CSV files

So, let's stop wasting time, after all, I've already been MIA for too long it feels!

## Getting Setup with a Language Server and Formatter

This wasn't on my original list, but after writing enough Python myself for work recently along with watching Dad's practice, I realized that having a built-in guide to enforce and recommended Python idioms along with language practices would be ideal. So, let's get that setup on in our Fedora 35 environment to be used by our code editors. For my editor, not that it'll matter beyond this section, I'll be leveraging [helix](/app/joplin-desktop/resources/app/github.com/helix-editor/helix).

### Language Server

For our Language Server, I've chose to use Microsoft’s [pyright](https://github.com/microsoft/pyright)!


```bash
pip3 install pyright
```


According to GitHub, `pyright` ships as both a command-line tool and a VS Code extension which is perfect for those using VS Code as well! But, this asks the question, what does a language server do? Why use one?


> The Language Server Protocol (LSP) defines the protocol used between an editor or IDE and a language server that provides language features like auto complete, go to definition, find all references etc. The goal of the Language Server Index Format (LSIF, pronounced like "else if") is to support rich code navigation in development tools or a Web UI without needing a local copy of the source code.
>
> [Microsoft Language Server Protocol](https://microsoft.github.io/language-server-protocol/)


Essentially, this allows contextually aware code suggestions, definitions, linting, and error-discovery all through a language server dedicated to the language you’re writing. Some such as `solargraph` exist which cater to many languages, but I’ve always preferred to use one per language in attempts to leverage the “best at one thing” tool.


 ![Language Server Python Example](https://raygervais.dev/articles/2021/3/neovim-lsp/images/PythonErrorsAnalysis.png)


I’ve used language servers since the moment I heard about them, and they are a technology which I believe I can never come back from. To program without one to point out your flaws or function definitions is to degrade oneself back to the stone age.

### Code Formatter

and for the dedicated source code formatter, I was intrigued to try [black](https://github.com/psf/black), which is described as,

> The uncompromising Python code formatter
> Python Software Foundation


We can install `black` with `pip install black`, which requires Python `3.6.2` to run.


```bash
❯ pip3 install black
Defaulting to user installation because normal site-packages is not writeable
Collecting black
  Downloading black-21.11b1-py3-none-any.whl (155 kB)
     |████████████████████████████████| 155 kB 23.6 MB/s 
Collecting platformdirs>=2
  Downloading platformdirs-2.4.0-py3-none-any.whl (14 kB)
Collecting typing-extensions>=3.10.0.0
  Downloading typing_extensions-4.0.1-py3-none-any.whl (22 kB)
Collecting pathspec<1,>=0.9.0
  Downloading pathspec-0.9.0-py2.py3-none-any.whl (31 kB)
Collecting tomli<2.0.0,>=0.2.6
  Downloading tomli-1.2.2-py3-none-any.whl (12 kB)
Collecting mypy-extensions>=0.4.3
  Downloading mypy_extensions-0.4.3-py2.py3-none-any.whl (4.5 kB)
Requirement already satisfied: click>=7.1.2 in /usr/lib/python3.10/site-packages (from black) (8.0.1)
Requirement already satisfied: regex>=2021.4.4 in /usr/lib64/python3.10/site-packages (from black) (2021.10.23)
Installing collected packages: typing-extensions, tomli, platformdirs, pathspec, mypy-extensions, black
  WARNING: The scripts black, black-primer and blackd are installed in '/home/raygervais/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed black-21.11b1 mypy-extensions-0.4.3 pathspec-0.9.0 platformdirs-2.4.0 tomli-1.2.2 typing-extensions-4.0.1
```


From there, we can use the tool with `black *.py` and also enable auto formatting in tools such as VS Code to take the use of this tool to the next level. In my case, I can leverage the `!` keybinding in Helix to call the shell command when I feel like it.


*Before, with badlly-formatted Python I wrote in 2018*


```python
# Hacker Rank Challenges - 06
## Challenge: String Formatting
def print_formatted(number):
    length = len(bin(number)[2::])
    
    for i in range(1, number + 1):
        _octal = oct(i)[2::]
        _hex = hex(i)[2::].upper()
        _binary = bin(i)[2::]
        
        if length == 1:
            spacer = ' ' * (length + 1)
        else:
            spacer = ' ' * length
        
        final_line = str(i).rjust(length) + ' ' + _octal.rjust(length) + ' ' \
            + _hex.rjust(length) + ' ' + _binary.rjust(length)
        
        print(final_line)
        
if __name__ == '__main__':
    n = int(input())
    print_formatted(n)
```


*After, notice the final_line variable is now a multi-line declaration instead of a weird two line item. Much cleaner*


```python
# Hacker Rank Challenges - 06
## Challenge: String Formatting
def print_formatted(number):
    length = len(bin(number)[2::])

    for i in range(1, number + 1):
        _octal = oct(i)[2::]
        _hex = hex(i)[2::].upper()
        _binary = bin(i)[2::]

        if length == 1:
            spacer = " " * (length + 1)
        else:
            spacer = " " * length

        final_line = (
            str(i).rjust(length)
            + " "
            + _octal.rjust(length)
            + " "
            + _hex.rjust(length)
            + " "
            + _binary.rjust(length)
        )

        print(final_line)


if __name__ == "__main__":
    n = int(input())
    print_formatted(n)
```

## Prompting the User for Input


What good is a script if it doesn’t remind you of your failings every time it’s run? Below I’ve added a snippet which allows us to prompt the user for any comment they have when the run script. Because of the perverse profanities and unapologetic frustrations while trying to play Doom III, I cannot show the actual file that saved my thoughts as I traversed the haunted mars base.


```python
#!/bin/env python3
# file: main.py
# author: RayGervais

if __name__ == "__main__":

    # Prompt the user for input
    comment = input("Do you have any comment regarding how you died?\n> ")

    print("\n")
    data = 0

    with open("./count.txt", "r") as f:
        data = f.read()
        print("You've died " + data + " times!")

    with open("./count.txt", "w") as f:
        f.write(str(int(data) + 1))

    print("We've incremented your death count by one.")
    print("Try to do better, ok?")
```


When running the script now, I’d be prompted with the following.


```javascript
$ python3 main.py
Do you have any comment regarding how you died?
> Don't pet big dogs when they have bigger teeth than you.

You've died 21 times!
We've incremented your count by one.
Try do to better, ok?
```


Now my comments are stored in the aptly named `comment` variable, but it’s not stored anywhere. Because of how we read and write the death count, it would take some string parsing logic to separate the count from the comment using a delimiter, but what if there was a simpler way? Enter, the comma separated value format! But first, let’s clean up the logic here with dedicated functions.

## Refactoring to Dedicated Functions

A good habit that I’ve picked up when writing in *any* language is the rule of separating logic into dedicated functions. The conversation for what’s worthy of being a function is often started with, did I already write this logic more then twice? More so, I find that having logic cleared away improves the readability of your `main` and how we could approach testing. Spaghetti logic doesn’t ensure job security anymore, and I like the quote that the code reviewer is a killer who knows where you live. So, let’s separate the logic based on scope!


```python
#!/bin/env python3
# file: main.py
# author: RayGervais


def retrieve_file_contents(location: str) -> int:
    with open(location) as f:
        return int(f.read())


def write_contents_to_file(location: str, contents: int) -> None:
    with open(location, "w") as f:
        f.write(str(contents + 1))


if __name__ == "__main__":
    FILE_LOCATION = "./count.txt"

    # Prompt the user for input
    comment = input("Do you have any comment regarding how you died?\n> ")
    print("\n")

    data = retireve_file_contents(FILE_LOCATION)
    print("You've died " + data + " times!")

    write_contents_to_file(FILE_LOCATION, data)

    print("We've incremented your death count by one.")
    print("Try to do better, ok?")
```

## Reading and Writing from a CSV File


Comma-separated-value files, or CSV for short, have been around since \~1972, and have provided the opportunity to bundle various data into a row/column-like format similar to a SQL table would. The difference being, at the end of the day they are plain-text files which use a `,` as the delimiter between fields. For those interested, you can read more here on a [brief history of the CSV file](https://blog.sqlizer.io/posts/csv-history/). Most importantly, it will allow us to save both the death-count and the user comment into our temporary DB-esque file. For Python 3.x, CSV support is built into the [standard library](https://docs.python.org/3/library/csv.html) which means no third party module imports are needed just yet. So, taking our previous implementation, how would we add support for CSVs?



```python
import csv


def retrieve_file_latest_contents(location: str) -> list:
    with open(location, "r") as f:
        return f.readlines()[-1].strip().split(",")[0]


def write_contents_to_file(location: str, death: int, comment: str) -> None:
    with open(location, "a") as f:
        writer = csv.writer(f, delimiter=",")
        writer.writerow([str(death), comment])


if __name__ == "__main__":
    FILE_LOCATION = "./count.csv"

    last_death = retrieve_file_latest_contents(FILE_LOCATION)
    current_death = int(last_death) + 1

    print("You've died " + last_death + " times already!")

    # Prompt the user for input
    comment = input("Do you have any comment regarding how you died?\n> ")
    print("\n")

    write_contents_to_file(FILE_LOCATION, current_death, comment)

    print("We've incremented your death count by one.")
    print("Try to do better, ok?")
```


The following snippet allows us to interact with the `count.csv` file (see below) and store a user’s comment into the file as well. Finally, instead of you the player being just a number, you’re now a number with thoughts and feelings. Express how ever you like, the program will never judge.


```javascript
count,comment
0,"I'm a pro gamer"
1,"Turns out, the big dog is really mean."
2,"Still, very angry doggy"
```

## resources

- [Cover Image: Photo by KAL VISUALS on Unsplash](https://unsplash.com/photos/1p_GtkK0SbQ)