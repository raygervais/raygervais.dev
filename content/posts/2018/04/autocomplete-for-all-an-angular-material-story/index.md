---
title: "Autocomplete for All, An Angular Material Story"
date: "2018-04-01"
---

**An OSD700 Contribution Update Part 1**

[![](https://images.unsplash.com/photo-1484417894907-623942c8ee29?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3f1d38bbdda690e28a81673c06325075&auto=format&fit=crop&w=3578&q=80)](https://unsplash.com/@emilep)

In this day and age, you live in one of two camps, you either love or hate autocomplete. Autocomplete (which differs from autocorrect due to contextual opposites of operation) is the answer to the mundane long dropdown lists, providing a means to both filter and evaluate a value without scrolling through the entire component _(and then some!)_. For my second foray into Angular Material, I decided I wanted to go further with the documentation while also browsing for enhancements or usability fixes. This led me to the an issue request for [documentation explaining](https://github.com/angular/material2/issues/10196) how to incorporate option groups, which revolves around a far more complex observable pattern and design pattern _(yay!)_, I'm guessing.

[Humphrey](http://github.com/humphd) mentioned while presenting previous documentation work that these forms of contributions also fall under my intended focus on accessibility, which I'm glad he said because it resolves my concern I had with accessibility not being related to usability. I agreed wholeheartedly. My goal since getting into programming was always to make technology as accessible and usable to the largest populous as possible, and I'm proud that I've been creating a path which does exactly that in small ripple-like motions. I believe that, if the technology is inaccessible to developers who devote 90% of their day to such, then how can we possible push forward without tricks which will bite us tomorrow?

_I digress. Back to the task at hand._

# Getting Started

Compared to the stepper component from my previous work, this autocomplete was a whole new component and workflow that I had to learn. I first started with the provided StackBlitz example from the issue itself, just to understand the underlying semantic patterns and components which make up the overall functionality. Link for those following along [here](https://stackblitz.com/edit/angular-nwdj9u).

In the StackBlitz example, we see the following hierarchy of components below. I've include in my explanation of each component some literal HTML code examples taken straight from material.angular.io, my argument being that they'd help to understand the semantic levels of each component and how one acts as an container to the other.

## Components

\- mat-form-field
	- mat-input
	- mat-autocomplete
		- mat-optgroup
			- mat-option

### Material Input

[Documentation](https://material.angular.io/components/input/overview) The mat-input is a custom directive which allows for standard html `input` and `textarea` elements to work with the material form field container. The easiest way to think of this directive is to describe it as a upgrade to the original input element. Let's go from 1.0, to 2.0 which includes form validation, error message styling, and responsive modern design. This is the component that we'd input our text into _(duh)_, and also manipulate the autocomplete / filter.

   

   

### Material Autocomplete

[Documentation](https://material.angular.io/components/autocomplete/overview) Extending the material input even further, the autocomplete component provides a list component which can be filtered. This component acts as the container and main driving functionality when extended with coupling mat-option components for each list item.

  

 {{ option }} 

### Material Option Group

[Documentation](https://material.angular.io/components/select/overview) [Older](https://material.angularjs.org/latest/demo/select) This component acts as a container for an array of mat-option components, allowing one to group multiple under a single heading / text.

 \-- None --
    {{ pokemon.viewValue }} 

### Material Option & Material Select

[Documentation](https://material.angular.io/components/select/overview) The list component used by mat-autocomplete, these act as the list item 2.0 of the HTML semantic world. Used in both the mat-autocomplete and mat-select components as display items, the material option is a very powerful component.

 None
    Option 1
    Option 2
    Option 3 

## Updating the StackBlitz Example

When I first discovered the bug and the corresponding StackBlitz example, I thought that the component itself was broken and that I had a lot more work than what the issue had described. I was relieved while looking into the code (for the above analysis) to see this code snippet which implied that completion would show true progress and remaining work.

// NEED HELP !!!
filterGroup(val: string): SpeciesGroup\[\] {
// TODO
return this.speciesGroup;
}

I [corrected](https://stackblitz.com/edit/angular-smg2xm?file=app/app.component.ts) the issue using common sense with option groups, meaning my logic (which is below and in the link) focuses on filtering the option groups themselves, instead of the individual options (following what the issuer's logic described). I love functional programming, and even small traces such as these makes me so happy to come up with since I think they are where many languages are heading; utilizing powerful paradigms sans the verbose 100+ lines of code to achieve such.

filterGroup(val: string): SpeciesGroup\[\] {
return this.speciesGroup.filter(item =>
item.letter.toLowerCase().indexOf(val.toLowerCase()) === 0 );
}

## Thoughts on the Current Documentation and Next Steps

[![](https://images.unsplash.com/photo-1464618055434-20b22e97995a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=2b81999604de6c183fe5f2a21e10db2f&auto=format&fit=crop&w=2550&q=80)](https://unsplash.com/@farrelnobel)

In a word, complete. Realistically, the work that's required of me is minimal, simply expanding the code snippet to a full blown example which is tangible to others. After confirming that the logic is all there, and the autocomplete works as expected, this is another case of directing the readers and users towards a proper implementation so that they can push it further in their own code. Compared to the stepper, this component's API and documented attributes is very thorough and explained using multiple examples. Working with such makes it even easier since I have a good foundation to base my work off of.

Next steps is putting the work into a pull request, verifying the expected behavior of the component. Stay tuned for a follow up coming soon!
