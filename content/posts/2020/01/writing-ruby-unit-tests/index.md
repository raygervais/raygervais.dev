---
title: Starting Ruby Software Development With Unit Tests
date: 2020-01-13
published: true
tags: ["Open Source", "Ruby", "Testing", "Lessons"]
series: false
cover_image: ./images/nihonorway-graphy-nCvi-gS5r88-unsplash.jpg
canonical_url: false
description: "Since joining my current employer, I've found myself working with Ruby programs more often so than other scripting languages. I can't really say just yet whether or not I enjoy working in the language, but it's syntax is no beauty such as Python. Instead, once getting past syntax which is comparable to a blended mix of multiple 2000s languages, it's built-in idioms draw you into a new level of thinking and designing. With all the recent exposure, including inheriting a legacy Ruby project and it's surrounding components, I decided for 2020 that I wanted to learn proper software testing and enterprise designs."
---

_A Lesson on Testing_

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

This is the easiest, a test which is where we define the expectations of the correct behavior. For example, When I supply the value of "World" to the `greet` function I an anticipating the returned string to be `Hello, World!`. The test implementation would be the defined `test_hello_world` above. Having these scenario tests allows us to be confident that the logic is following business requirements, and also ensure updates to the code do not break key functionality.

### Error Handling & Data Integrity

This test is critical for ensuring you're code handles unexpected [_and yet common, quite the interesting paradox_] use-cases. Being aware of your beautifully [_poorly_] written code's error handling can make or break a good night's sleep, especially when it was just deployed into Production. Just remember, regardless of your testing and confidence, never ever ever ever ever ever deploy on a Friday. This is a key reminder often posted by Software Developer, Entrepreneur, and Co-Host of Ladybug Podcast, [Kelly Vaughn](https://kellyvaughn.co):

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">A development haiku:<br><br>Hooray, it&#39;s Friday!<br>Don&#39;t deploy to production -<br>Wait until Monday!</p>&mdash; Kelly Vaughn 🐞 (@kvlly) <a href="https://twitter.com/kvlly/status/1068608545862619141?ref_src=twsrc%5Etfw">November 30, 2018</a></blockquote> <br /> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

When testing for data integrity, I often like to check for type definition handling (this is more common for non-typed languages such as Ruby, Python and JavaScript) along with `Null/Nil` values for example. For functions which process input, be-it from user, api, or files, I find this critical to always test. The cost of verbosity and extra code ensures that edge cases such as carriage returns from a DOS machine doesn't break your Linux-powered script for example. Below are a few examples of Ruby type checking that I have employed (including a sane default option) playing off of our earlier example.

_Because of Ruby's loose-type system, we cannot test passing in NO value to our function, but your milage will vary by language._

```rb
# hello.rb
class HelloWorld
    def greet(name = "World")
        # Handle non-expected params
        if name.empty? || !name.kind_of?(String) || name == nil
            name = "Error Handler"
        end

        @greeting = "Hello, #{name}!"
    end
end
```

```rb
# hello_test.rb
require 'test/unit'
require_relative '../hello'

class YourFirstTest < Test::Unit::TestCase

    # Tests must begin with test_ to be properly picked up
    def test_hello_world
        greeting = HelloWorld.new().greet("World")

        assert_equal("Hello, World!", greeting)
    end

    def test_hello_empty
        greeting = HelloWorld.new().greet("")

        assert_equal("Hello, Error Handler!", greeting)
    end

    def test_hello_nil
        greeting = HelloWorld.new().greet(nil)

        assert_equal("Hello, Error Handler!", greeting)
    end

    def test_hello_number
        greeting = HelloWorld.new().greet(1)

        assert_equal("Hello, Error Handler!", greeting)
    end
end
```

### Logging and Reporting

I've had the opportunity to dive heads-deep into 20+ page log files, and my god can that be both a nightmare and blessing. In these logs, standardized formatting and semantics make or break how easily you're able to debug your program, evaluate the runtime executed as expected, or validate business behaviors. Knowing that your application is logging properly is a reassurance that is only truly appreciated in the war room and during developer demos. Here is a simple example that I incorporate into my applications to ensure that after running the unit tests, I am confident that the application will operate and write to the correct directories.

```rb
require "logger"

class LoggingController
    def initialize(log_location, application_id)
        @logger = Logger.new("#{log_location}/#{application_id}.log")
    end

    def write(action, level = "info")
        if action.empty?
            @logger.error("Invalid Logging Call")
            abort()
        end

        if

        case level
            when "info" then @logger.info(action)
            when "warn" then @logger.warn(action)
            when "error" then @logger.error(action)
            else
                @logger.error("Invalid Logging Level for: #{action} ")
            end
        end
    end

    def close
        @logger.close
    end
end


```

```rb
# log_controller_test.rb

require 'test/unit'
require 'file'

require_relative '../log_controller'

class LogControllerTest < Test::Unit::TestCase
    def test_can_open_logger_var_log
        logger = LoggingController.new("/var/log", "unit_testing")
        assert_equal(!nil, logger)
    end

    def test_can_write_logger_var_log
        logger = LoggingController.new("/var/log", "unit_testing")
        logger.write("Automated Testing Rules", "info")


        # Close logger instance so we are not reading blocked I/O
        logger.close

        # Ensure we wrote to file successfully
        assert_equal(false, File.zero?("/var/log/unit_testing.log"))
    end

end
```

## Setting Up More Complex Tests and Putting it All Together

The last small item I want to add, purely so that we don't leave this example in a complete code nightmare is to standardize some of the tests, and utilize the `setup` and `teardown` functions built into the `TestCase` Ruby class so that we can ensure our code is following both DRY and DAMP development principals. These functions execute before and after each test case, removing much of the setup work where it's not needed. For this example, let's leverage the same `LogController` code as before and rewrite the tests.

```rb
require "test/unit"
require_relative '../log_controller'

class LogControllerTest < Test::Unit::TestCase
    def setup
        @log_location = "./output/"
        @application_id = "unit_testing"
        @file_location = "#{@log_location}/#{@application_id}.log"
        @logger = LoggingController.new(@log_location, @application_id)

    end

    def teardown
        File.delete(@file_location) if File.exist?(@file_location)
    end

    def test_can_write_local_system
        @logger.write("Wrote to #{@log_location} successfully")
        @logger.close

        assert_equal(false, File.zero?(@file_location))
    end

    def test_can_write_logger_var_log
        @log_location = "/var/log"
        @logger = LoggingController.new(@log_location, @application_id)

        @logger.write("Automated Testing Rules", "info")

        # Close logger instance so we are not reading blocked I/O
        @logger.close

        # Ensure we wrote to file successfully
        assert_equal(false, File.zero?("#{log_location}/#{@application_id}.log"))
    end

end
```

Running the above with `ruby tests/log_controller_test.rb` on MacOS 10.15.2 results in the following, which informs me that my account (as expected, thanks Apple!) doesn't have permissions to write to the /var/log folder. Having not known this prior to deploying the application, my application may have failed to start entirely due to this issue! This is a real-world example (sans blaming Apple, this one was on a Red Hat Enterprise Linux 7.7 production machine) that had I not run the tests before, may have had a very differently handled weekend.

```sh
Loaded suite tests/log_controller_test
Started
.E
=========================================================================================================================================================================
     24:
     25:     def test_can_write_logger_var_log
     26:         @log_location = "/var/log"
  => 27:         @logger = LoggingController.new(@log_location, @application_id)
     28:
     29:         @logger.write("Automated Testing Rules", "info")
     30:
tests/log_controller_test.rb:27:in `test_can_write_logger_var_log'
tests/log_controller_test.rb:27:in `new'
/Users/raygervais/Developer/Ruby/LoggingController/log_controller.rb:5:in `initialize'
/Users/raygervais/Developer/Ruby/LoggingController/log_controller.rb:5:in `new'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:387:in `initialize'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:387:in `new'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:671:in `initialize'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:736:in `set_dev'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:742:in `open_logfile'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:746:in `rescue in open_logfile'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:752:in `create_logfile'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:752:in `open'
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/logger.rb:752:in `initialize'
Error: test_can_write_logger_var_log(LogControllerTest): Errno::EACCES: Permission denied @ rb_sysopen - /var/log/unit_testing.log
=========================================================================================================================================================================

Finished in 0.012552 seconds.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2 tests, 1 assertions, 0 failures, 1 errors, 0 pendings, 0 omissions, 0 notifications
50% passed
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
159.34 tests/s, 79.67 assertions/s
```

## Resources

- [Cover Image](https://unsplash.com/photos/nCvi-gS5r88)
- [Ruby Install](https://www.ruby-lang.org/en/documentation/installation/)
- [Ruby Testing Documentation](https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing)
- [Dev.TO Writing Test Code in Ruby](https://dev.to/exampro/testunit-writing-test-code-in-ruby-part-1-of-3-44m2)
- [DRY vs DAMP](https://stackoverflow.com/questions/6453235/what-does-damp-not-dry-mean-when-talking-about-unit-tests)

```

```
