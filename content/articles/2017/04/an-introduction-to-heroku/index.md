---
title: "An Introduction to Heroku"
date: 2017-04-01
draft: false
tags: ["Open Source", "Seneca", "OSD600", "NodeJS"]
description: "This week, the class was introduced to Heroku, which is described as, “a platform as a service (PaaS) that enables developers to build, run, and operate applications entirely in the cloud”."
---

_An OSD600 Exercise_

# Heroku

This week, the class was introduced to Heroku, which is described as, “a platform as a service (PaaS) that enables developers to build, run, and operate applications entirely in the cloud”. It was a first step for many of us into PaaS concepts, along with interact with such a concept. Luckily, Heroku which is a paid service, can be used  freely to open source projects such as our tutorial. Below, I’ve included Dave’s instructions which guided us through the process, along with any thoughts I had along the way before concluding with a link to my “healthcheck” function, and my repository which houses all the code. Without further delay, let’s begin.

# Process

## Express Framework

The first item, was installing the [Express](https://expressjs.com/) web framework, which allows for flexible Node.js web applications which are both minimal, and robust. To install, we followed the standard command `npm install express --save`, which added the express dependency to the project.

## Writing The Server Code

Provided with the code below, the server would utilize Express’s routing for REST API calls. I found this routing to be easy to understand, mirroring how Laravel handles API routing. My only complaint with the code below, which I sure has an answer for that I have yet to discover, is the lack of organization. All the API routings are displayed in the single file, which in this case is easy to read, but what of bigger projects?

```js
// Load the express web framework module
var express = require("express");
// Load our seneca module
var seneca = require("./seneca");

// Create an instance of express
var app = express();

// Use port 3000 unless one is set in the env
var port = process.env.PORT || 3000;

// Define some HTTP routes (e.g., URLs) users can access on our server

// GET http://localhost:3000/
app.get("/", function (req, res) {
  res.send("My Server is working!");
});

// GET http://localhost:3000/validate/someone@myseneca.ca
app.get("/validate/:email", function (req, res) {
  var email = req.params.email;

  // Return a JSON formatted response indicating that the given
  // email address is valid or invalid.
  res.json({
    email: email,
    valid: seneca.isValidEmail(email),
  });
});

// GET http://localhost:3000/format/someone
app.get("/format/:name", function (req, res) {
  var name = req.params.name;

  // Return a JSON formatted response with the given name
  // formatted as a valid email address.
  res.json({
    name: name,
    email: seneca.formatSenecaEmail(name),
  });
});

// Start our web server on port 3000
app.listen(port, function () {
  console.log("Server started on http://localhost:" + port);
});
```

Running the server locally requires the following command: `node server.js`

. If all is successful, you can access the server through [http://localhost:3000/](http://localhost:3000/), and test your previously implemented functions through ~/validate and ~/format. If working, the server will return a JSON response.

## Deploying to Heroku

After creating an account on Heroku, the next step would involve installing the Heroku CLI -which is supported on Windows, MacOS, Debian / Ubuntu with native installers, and a standalone which I used on both of my Linux distributions (Fedora, Arch). Once installed, we’d login with `heroku login`, providing the credentials created previously. The next step for this item would be creating the Procfile, which describes to Heroku which command to run when running the application. Finally, we deploy to Heroku itself. This is done by first running `heroku create` in your terminal, which provides you with a random name for the application which is also the application. Pushing to both Github and Heroku is simple, as the previous command added your application’s Heroku repository, and requires only this command after adding and committing your respective files: `git push heroku master`.

## Launching the API

To launch the application we just deployed to Heroku, we use the following command `heroku ps:scale web=1`, followed by `heroku open`

if you wish to visit your application’s domain in the browser. My REST API for this tutorial can be found at this [link](https://pumpkin-pudding-95440.herokuapp.com/healthcheck).

# Conclusion

This was my first introduction to utilizing a PaaS both in an open source context, and a developers. Every week, It seems that I’m introduced into another universe, driven by technologies and platforms, names and languages; all of which I had never heard before. Last week I learned of TravisCI, and this week’s introduction to Heroku only expands upon an already interesting set of topics which are beyond the reach of the standard curriculum. Curiosity demands my exploration of Heroku, and perhaps for future endeavors into REST APIs will be powered by the platform. Only time will tell.
