---
title: "Unit Testing a NodeJS Driven Project"
date: "2017-03-26"
---

An OSD600 Lab

This lab extends the previous OSD600 Lab, which had us creating a NodeJS project with which utilized ESLint, choosing a JavaScript coding guideline, and finally testing our efforts with the powerful Travis CI. This time, we were introduced to the process of unit testing; another important developer tool which is often overlooked in smaller projects. Unit testing involves the process of programmatically asserting the expected results of your functions, providing both valid or invalid arguments or any item which may considered edge cases. For those searching for a better definition, I’d recommend looking into [Wikipedia’s definition](https://en.wikipedia.org/wiki/Unit_testing). One thing that Wikipedia doesn’t have, is the process of which this lab had us going through, which I’ve included below. Let’s jump in!

# Setting Up The Testing Framework

Unit tests are not an exclusive to JavaScript, one could even assume that every programming language had multiple testing frameworks, all unique to the pitfalls and strengths of said language. In this case, our choice of popular frameworks included:

1. [Jest By Facebook](http://facebook.github.io/jest/)
2. [Moacha](https://mochajs.org/)
3. [Chai](http://chaijs.com/)
4. [Sinon](http://sinonjs.org/)
5. [Cucumber](https://github.com/cucumber/cucumber-js)

I feel as if these frameworks are popular by name alone, and by that I mean: what self-respecting developer wouldn’t associate himself with a framework named after a caffeinated drink? No one. But in all seriousness, I these frameworks are popular because they make unit testing a cohesive and quite lovely experience. I picked Jest, which is what the majority of the class had also been recommended which meant that when I run into an issue, help was not far away.

Installing Jest was simple, only requiring a simple command in the terminal:

$ npm install --save-dev jest

This would install the Jest testing framework into the development environment, and enable us to test all of the previously implemented functions using the following example, which described how to write a proper Jest unit test:

var seneca = require('./seneca');
test('isValid returns true for simple myseneca address', function() {
  var simpleEmail = 'someone@myseneca.ca';
  expect(seneca.isValidEmail(simpleEmail)).toBe(true);
});

# A Brief Introduction to Test Driven Development

Dave’s follow-along documentation provided an interesting overview of test driven development, or TDD for short; which summarized the emphasis on writing tests before writing the code. This way, when your implementation of various functions are complete, you’ve already got the test suite which defines how the functions should respond logic-wise  with valid arguments, invalid arguments, broken logic, and the works! I have only heard faint whispers of TDD before, but after the small introduction to it I can say that I am intrigued to see how far I can utilize it in upcoming projects, while at the same time finding the limits and moments which scream “why would you do that!?” when working with grander items such as mobile applications, web applications, and even desktop applications.

In his example, which showcased the above unit test, Dave explained how the function was not written at the time, and thus we could write and improve the function as we wrote more tests to either handle more edge-cases, handle invalid arguments, or expand functionality within the scope of the function itself. Below, I’ve included my isValidEmail tests, along with the final version of the function as of this time which handles each case flawlessly.

To better organize the test file, the class was introduced to Test Suites, which is specifically a plethora of your tests all related to a single function, bundled by the describe function in this case. It’s cleaner, and also provides a better overview of all the functions and scope that you are testing if well organized.

## Seneca.IsValidEmail Function

/\*\*
 \* Given a string \`email\`, return \`true\` if the string is in the form
 \* of a valid Seneca College email address, \`false\` othewise.
 \* @param {email} email address to be validated
 \* @return {boolean} Indicating successful validation (true), or false.
 \*/
exports.isValidEmail = function isValidEmail(email) {
  return /^\\w+(\[.-\]?\\w+)\*@\\w\*(seneca)\\w\*(.ca)/.test(email);
};

## Seneca.Test.JS IsValidEmail Suite

// First require (e.g., load) our seneca.js module
const seneca = require('./seneca');

/\*\*
 \* Tests for seneca.isValidEmail()
 \*/
describe('seneca.isValidEmail()', () => {
  test('isValidEmail returns true for simple mySeneca address', () => {
    expect(seneca.isValidEmail('somebody@myseneca.ca')).toBe(true);
  });

  test('Returns true for a staff email address', () => {
    expect(seneca.isValidEmail('david.humphrey@senecacollege.ca')).toBe(true);
  });

  test('Returns false for a invalid mySeneca address', () => {
    expect(seneca.isValidEmail('someone@hotmail.ca')).toBe(false);
  });

  test('Returns false for a malformed mySeneca address', () => {
    expect(seneca.isValidEmail('  rmgervais@senecacollege.ca')).toBe(false);
  });

  test('Returns false for invalid argument being passed', () => {
    expect(seneca.isValidEmail(123)).toBe(false);
  });

  test('Returns false for an array argument being passed', () => {
    expect(seneca.isValidEmail(\[1, 'rmgervais@myseneca.ca'\])).toBe(false);
  });
});

# Automating the Process

The next process, one which is standard in many open source projects, is the automating of unit testing. That is, once you write the tests, you always want to test your code against them during uploads or builds of the application. Adding the node\_modules/.bin/jest execution call to the package.json file allowed for us to call Jest with just a simple ‘npm run jest’ command. We then integrated it with our linter to create a new script, titled ‘test’. It would first check your code for any syntactical errors, illegal operations and any item which went against the predefined style guide, and only after those passed would it proceed to run your tests. Seeing both Travis CI, and your local development machine show passing results for each test is quite addicting, an interesting item which Dave had mentioned previously. No one believed him, thinking it was misplaced developer humor, but seeing the following on my screen, perhaps from the way the colors are displayed or the easy to digest layout of the data and metrics, makes unit testing much more exciting than my previous foray with Java’s JUnit.

# Conclusion & Thoughts

Unit testing was never a topic that I was exposed to throughout my education at Seneca, and I thought that I would hate it after the JUnit introduction with a less-than-stellar explanation from the professor at the time. I was partially wrong, as of this moment I am reluctant to try JUnit again, simply from that previous lesson, but this experience with unit testing has been quite the different story. As I said above, I never thought a single results page would bring so much content to someone who prides himself on being a perfectionist; which in doing so makes sense, but I never would never thought that way prior to this exercise. To see the final code for this lab, you can find my repository [here](https://github.com/raygervais/OSD6002017)!
