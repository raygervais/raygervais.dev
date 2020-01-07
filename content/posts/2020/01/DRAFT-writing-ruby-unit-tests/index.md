---
title: Starting Ruby Software Development With Unit Tests
date: 2020-01-07
published: false
tags: ["Open Source", "Ruby", "Testing", "Lessons"]
series: false
cover_image: ./images/nihonorway-graphy-nCvi-gS5r88-unsplash.jpg
canonical_url: false
description: "Since joining my current employer, I've found myself working with Ruby programs more often so than other scripting languages. I can't really say just yet whether or not I enjoy working in the language, but it's syntax is no beauty such as Python. Instead, once getting past syntax which is comparable to a blended mix of multiple 2000s languages, it's built-in idioms draw you into a new level of thinking and designing. With all the recent exposure, including inheriting a legacy Ruby project and it's surrounding components, I decided for 2020 that I wanted to learn proper software testing and enterprise designs."
---

_A Software Development Story_

Since joining my current employer, I've found myself working with Ruby programs more often so than other scripting languages. I can't really say just yet whether or not I enjoy working in the language, but it's syntax is no beauty such as Python. Instead, once getting past syntax which is comparable to a blended mix of multiple 2000s languages, it's built-in idioms draw you into a new level of thinking and designing. With all the recent exposure, including inheriting a legacy Ruby project and it's surrounding components, I decided for 2020 that I wanted to learn proper software testing and enterprise designs. The later we'll focus on throughout the year, my current project posing as the perfect segue to learn unit testing in Ruby.

## Getting Started

For this little overview, we are going to use the built-in `testing/unit` ruby gems, instead of the more common rspec and TestUnit. This means we need to have ruby installed on our machine and in our path prior to starting. See below in _resources_ for the installation link. From there, it's going to be all code baby.

## Writing Your First Test

Just as we do the iconic `Hello, World!` when learning new languages, we are going to do so with the testing example. This lesson is influenced by [Learning Golang with Tests](https://quii.gitbook.io/learn-go-with-tests/) which started off chapter one with the similar example. It's a fantastic resource as well that I'm going through, and may explain further in a different article. Just as below, let's write a class-based version of Hello World in `hello.rb` in the root of our empty project.

```rb
# hello.rb
class HelloWorld
    def greet(name)
        @greeting = "Hello, #{name}!"
    end
end
```

Once that's written, we can call the function from our unit-test file, which is appropriately called `hello_test.rb`. Following typical gem structure, your test file should be found under `/spec/` or `/tests/` in the project folder. With either, you'll notice Visual Studio Code and Atom both present a nice icon for the folder to help distinguish the importance of the folder!

```rb
# hello_test.rb
require 'test/unit'
require_relative '../hello'

class YourFirstTest < Test::Unit::TestCase

    # Tests must begin with test_ to be properly picked up
    def test_hello_world
        # Setup variable to test
        greeting = HelloWorld.new().greet("World")

        assert_equal("Hello, World!", greeting)
    end

    def test_hello_ray
        greeting = HelloWorld.new().greet("Ray")

        assert_equal("Hello, Ray!", greeting)
    end
end
```

Executing the above should result in the following output, coupled with a reassuring green progress bar which means we're on the right track. You can run this command to see your own tests run: `ruby ./tests/hello_test.rb`.

```bash
root@1a189b7ce267:/home# ruby tests/hello_test.rb                                                   Loaded suite tests/hello_test                                                                       Started                                                                                             ..                                                                                                                                                                                                      Finished in 0.0007569 seconds.                                                                      ----------------------------------------------------------------------------------------------------2 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications               100% passed                                                                                         ----------------------------------------------------------------------------------------------------2642.36 tests/s, 2642.36 assertions/s
```

This is where the magic starts. Just as David Humphrey explained to in his fantastic open source class OSD600, seeing the tests complete and come back green triggers (at least for some including me), a natural response/high to want to add more.

## What to Test

This isn't a topic that I'm well versed in, that I can admit right now as I continue to learn the optimal items to test with unit tests (say, vs integration, behavior tests). That being said, I think I can recommend a few scenarios to always ensure are tested as you develop your projects.

### Expected Behavior
This is the easiest, a test which is where we define the expectations of the correct behavior. For example, When I supply the value of "World" to the `greet` function I an anticipating the returned string to be `Hello, World!`. The test implemention would be the defined `test_hello_world` above. Having these scenerio tests allows us to be confident that the logic is following business requirements, and also ensure updates to the code do not break key functionalilty. 

### Error Handling & Data Integrity
This test is critical for ensuring you're code handles unexpected [_and yet common, quite the interesting paradox_] use-cases



## Setting Up More Complex Tests

```rb
def setup
    @greeting = HellowWorld.new().greet("World")
end
```

## On Test Driven Development (TDD)

## Resources

- [Cover Image](https://unsplash.com/photos/nCvi-gS5r88)
- [Ruby Install](https://www.ruby-lang.org/en/documentation/installation/)
- [Ruby Testing Documentation](https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing)
- [Dev.TO Writing Test Code in Ruby](https://dev.to/exampro/testunit-writing-test-code-in-ruby-part-1-of-3-44m2)
```
