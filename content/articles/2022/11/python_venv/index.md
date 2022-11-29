---
title: Leveraging Python Virtual Environments in VS Code
date: 2022-11-28
tags: ["Open Source", "VS Code", "Python"]
Cover: https://images.unsplash.com/photo-1615309662472-4ca77a77a189?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8
---

This past week, I learned an interesting trick which completely changed how I'll approach writing Python projects in VS Code.

See, my previous workflow was the following, which all things considered I'd like to think is sane:

```bash
# Create a new directory for the project, let's name it `example` in this case
mkdir example

cd example

mkdir src

# Create a virtual environment
python3 -m venv venv

# Activate the virtual env
source ./venv/bin/activate.sh

# Install some modules
pip3 install azure-mgmt-resource azure-mgmt-keyvault

# Start writing using your editor of choice
code ./example
```

The problem was, when open in VS Code or any other editor which works alongside a LSP (Language Server), the virtual environment which contained all the modules installed with
`pip3 install` aren't seen by editor. Essentially, it's like working with modules which you haven't downloaded locally. In some ways, I believed this to be normal, having experienced
similar behaviour as early as 2017, accepting this as both a limitation of the setup, or user error / ignorance.

Then, in the past few days _while I was still doing my normal workflow_, VS Code prompted me to setup a virtual environment despite my `venv` already being present. I humored it.
VS Code then created a `.venv` folder in the root of my workspace and asked me which interpetter to use. So, I was curious.

```bash
mkdir -p corrected_example/src
python3 -m venv corrected_example/.venv
pip3 install azure-mgmt-resource azure-mgmt-keyvault
code corrected_example
```

Lo-and-behold, Visual Studio Code picks up my installed modules!

So, I learned two small items when working with Python virtual enviroments + vs code! 

1. Store your virtual environment (`venv`) at the root of your workspace
2. Ensure that the virtual environment is called `.venv`, not `venv`.

For the curious, you can find this writeup on [working with Python interpreters in VS Code](https://code.visualstudio.com/docs/python/environments), which
goes much deeper into the setup and configuration of a Python Environments, along with Node, Typescript, Java, C++,, Docker, along with other setups.

## Resources

- [Cover image: Photo by Sigmund on Unsplash](https://unsplash.com/photos/EJe6LqEjHpA)
- [Visual Studio Code: Using Python environments in VS Code](https://code.visualstudio.com/docs/python/environments)
