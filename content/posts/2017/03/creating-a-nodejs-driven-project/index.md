---
title: "Creating a NodeJS Driven Project"
date: "2017-03-20"
---

OSD600 Week Nine Deliverable

# Introduction

For this week, we were introduced to a few technologies that though interacted with during our contributions and coding, were never described or explained the ‘why’, ‘how’, or even the ‘where to start’ aspects. The platforms on trial? Node, Travis CL and even ESLint -curse you linter, for making my code uniform.

# Init.(“NodeJS”);

The first process was simply creating a repository on GitHub, cloning it onto our workstations, and then letting the hilarity of initializing a new NodeJS module occur. Why do I cite such humour for the later task? Because I witnessed few forget which directory they were in, thus initializing Node in their Root, Developer, You-Name-It folder; anything but their repository’s cloned folder. Next, was learning of what you could, or could not, input into the initialization commands. Included below is the example script which was taken from Dave’s README.md which showed how the process should look for \*Nix users. Window’s users had a more difficult time, having to use their Command Prompt instead of their typical Git Bash terminal which would fail to type ‘yes’ into the final step.

$ npm init

This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See \`npm help json\` for definitive documentation on these fields
and exactly what they do.

Use \`npm install <pkg> --save\` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
name: (Seneca2017LearningLab) lab7
version: (1.0.0) 1.0.0
description: Learning Lab
entry point: (index.js) seneca.js
test command:
git repository: (https://github.com/humphd/Seneca2017LearningLab.git)
keywords:
author:
license: (ISC) MIT
About to write to /Users/dave/Sites/repos/Seneca2017LearningLab/package.json:

{
  "name": "lab7",
  "version": "1.0.0",
  "description": "Learning Lab",
  "main": "seneca.js",
  "scripts": {
    "test": "echo \\"Error: no test specified\\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/humphd/Seneca2017LearningLab.git"
  },
  "author": "",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/humphd/Seneca2017LearningLab/issues"
  },
  "homepage": "https://github.com/humphd/Seneca2017LearningLab#readme"
}

Is this ok? (yes)

# Creating The Seneca Module

The next step was to create the seneca.js module, which would be expanded upon in further labs. For now, we had to write two simple isValidEmail and formatSenecaEmail functions respectively. This task took minutes, thanks to W3 School’s email validation regular expression, which along with my code, is included below. The bigger challenge, was getting ESLint to like my code.

/\*\*
 \* Given a string \`email\`, return \`true\` if the string is in the form
 \* of a valid Seneca College email address, \`false\` othewise.
 \*/
exports.isValidEmail = function(email) {
  if (/^\\w+(\[\\.-\]?\\w+)\*@\\w+(\[\\.-\]?\\w+)\*(\\.\\w{2,3})+$/.test(email)) {
  	return (true);
  }
  return (false);
};

/\*\*
 \* Given a string \`name\`, return a formatted Seneca email address for
 \* this person. NOTE: the email doesn't need to be real/valid/active.
 \*/
exports.formatSenecaEmail = function(name) {
  name.trim();
  return name.concat('@myseneca.ca');
};

# Depending On ESLint

ESLint, up to this point I had only dealt with in small battles, waged on the building process of Brackets where my code was put against its rules. Now, I am tasked with instead of conquering it (in the case of a developer, meaning to write code which complies with the preset rules), but creating the dependency which will build it into my development environment of the project. Installing ESlint requires the following command, followed by the initialization which will allow you to select how you’d like the linter to function along with style guides. The process that we followed is below.

$ npm install eslint --save-dev

$ ./node\_modules/.bin/eslint --init

? How would you like to configure ESLint?
  Answer questions about your style
❯ Use a popular style guide
  Inspect your JavaScript file(s)

? Which style guide do you want to follow?
  Google
❯ Airbnb
  Standard

? Do you use React? (y/N) N

? What format do you want your config file to be in?
  JavaScript
  YAML
❯ JSON

Running Eslint manually would involve running $ ./node\_modules/.bin/eslint , which could then be automated by adding the following code to the package.json file.

"scripts": {
  "lint": "node\_modules/.bin/eslint \*.js",
  "test": "npm run -s lint"
}

This would allow for one to call linting at any time, with the npm command followed by “lint” in this case.

# Travis CI Integration

When writing the next evolutionary script, program, even website for that matter, you want to ensure that it works, and once it does ‘work’, you double check on a dedicated platform. That’s where the beauty which is Travis CI comes to play, allowing for automated tested (once properly configured) of your projects and repositories. We were instructed to integrate Travis with this exercise with [Dave’s provided instructions](https://github.com/humphd/Seneca2017LearningLab) below.

> Now that we have the basics of our code infrastructure set up, we can use a continuous integration service named [Travis CI](https://travis-ci.org/) to help us run these checks every time we do a new commit or someone creates a pull request. Travis CI is free to use for open source projects. It will automatically clone our repo, checkout our branch and run any tests we specify.
> 
> - [Sign in to Travis CI](https://docs.travis-ci.com/user/getting-started/) with your GitHub account
> - Enable Travis CI integration with your GitHub account for this repo in your [profile page](https://travis-ci.org/profile)
> - Create a .travis.yml file for a [node project](https://docs.travis-ci.com/user/languages/javascript-with-nodejs/). It will automatically run your npm test command. You can specify "node" as your node.js version to use the latest stable version of node. You can look at how I did my [.travis.yml](https://github.com/humphd/Seneca2017LearningLab/blob/master/.travis.yml)file as an example.
> 
> Push a new commit to your repo's master branch to start a build on Travis. You can check your builds at [https://travis-ci/profile/](https://travis-ci/profile/)/. For example, here is my repo's Travis build page: [https://travis-ci.org/humphd/Seneca2017LearningLab](https://travis-ci.org/humphd/Seneca2017LearningLab)
> 
> Follow the [Getting started](https://docs.travis-ci.com/user/getting-started/) guide and the [Building a Node.js project](https://docs.travis-ci.com/user/languages/javascript-with-nodejs/) docs to do the following:
> 
> Get your build to pass by fixing any errors or warnings that you have.

Once that was complete, the final step was to integrate a Travis CI Build Badge into the README of our repository. This final step stood out to me, for I had seen many of these badges before without prior knowledge as to their significance. Learning how Travis CI could automate the entire integration testing of your project on a basic Ubuntu 12.04 (if configured to that) machine within minutes has opened my eyes up to a new form of development testing, implementation, and more open-source goodness. The final repository with all that said and done can be found for the curious, [here](https://github.com/raygervais/OSD6002017).
