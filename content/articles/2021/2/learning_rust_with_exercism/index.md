---
title: "Learning Rust with Exercism"
tags: ["Open Source", "Rust", "Lessons", "Overview", "Linux"]
date: 2021-02-16
description: "I've wanted to try out Rust for the past few months, my curiosity deriving from it's rise in systems programming
and being rated the number one developer loved language for the fifth year in a row. A friend had pointed me towards
Exercism.io, which is another take on the LeetCode and HackerRank style coding challenges with their own
rust 'track'. I thought, why not try to learn the language this way? In this article, I want to describe the process and my thoughts
after trying a few questions with _Exercism.io_ on the passive (vs mentored) mode."
Cover: "images/startae-team-8RX3W79_UTE-unsplash.jpg"
---

_The path to staying sharp means always learning_

I've wanted to try out Rust for the past few months, my curiosity deriving from it's rise in systems programming
and being rated the number one developer loved language for the fifth year in a row. A friend had pointed me towards
[Exercism.io](https://exercism.io), which is another take on the LeetCode and HackerRank style coding challenges with their own
rust "track". I thought, why not try to learn the language this way? In this article, I want to describe the process and my thoughts
after trying a few questions with _Exercism.io_ on the passive (vs mentored) mode.

## Getting my Environment Setup

For this endevour, I turned to my trust Fedora 33 Workstation install. It makes the most sense in my experience given run-times such as rust, go, and python (to name a few) can be found directly in the standard repositories and I found the language server's performance to be far greater in a native \*Nix environment vs my last test with WSL2.

Installation of rust along with `rustup` (which is, the rust tool chain installer) can be done with the following commands:

```bash
# Install Rust Compiler
sudo dnf install rust

# Install RustUp Toolkit
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

From here, installing the Rust extension in VSCode and [rust.vim](https://github.com/rust-lang/rust.vim) was the last requirements for my editors of choice. Now on to installing Exercism. This can be done by following the instructions on their website, which described me downloading from their Github Release page the appropriate `tar.gz` archive and extracting with `tar -xf exercism-linux-64bit.tgz`. Once extracted, I moved the `exercism` binary to `/usr/local/bin/` so that it would be accessible within my PATH environment.

The last item is to authenticate and connect your Exercism account with the CLI, which can be done with

## Completing Exercises

With the CLI now installed and configured, we can pull exercises with `exercism download --exercise=proverb --track=rust` which will place all the files required in `~/exerism/rust/`. While writing this little article, I had completed the following exercises (with Googling only where possible, trying to avoid looking at direct solutions unless I had already completed and was curious of better implementations):

### Hello World

```rust
pub fn hello() -> &'static str {
    "Hello, World!"
}
```

### Leap

```rust
// solution: https://exercism.io/tracks/rust/exercises/leap/solutions/8e94607e2a69474e86b757c596969299
// The match tuple solution that others have called 'Rusty'.
// Looks like a matrix. Harder to read as a noob.
// There's a couple not so immediately obvious things going on here.
// Of great importance is the order of the matches.
//
// In the (,0,) line we don't care about two of the results,
// because the 400 case was already checked before we return
// false for divisible by 100. If we make it to the last match
// arm, clearly it's not a leap year.
//
pub fn is_leap_year(year: u64) -> bool {
    match (year % 400, year % 100, year % 4) {
        (0, _, _) => true,
        (_, 0, _) => false,
        (_, _, 0) => true,
        (_, _, _) => false
    }
}
```

### Raindrops

```rust
pub fn raindrops(n: u32) -> String {
    let mut result: String = String::from("");

    if n % 3 == 0 {
        result.push_str("Pling");
    }

    if n % 5 == 0 {
        result.push_str("Plang");
    }

    if n % 7 == 0 {
        result.push_str("Plong");
    }

    return match result.len() {
        0 => n.to_string(),
        _ => result,
    };
}
```

### Nth Prime

```rust
pub fn is_prime(n: u32) -> bool {
    return !(2..n - 1).any(|i| n % i == 0);
}

pub fn nth(n: u32) -> u32 {
    let mut primes: Vec<u32> = vec![];

    return (2..)
        .filter(|candidate: &u32| {
            if !primes.iter().any(|i| candidate % i == 0) {
                primes.push(*candidate);
                true
            } else {
                false
            }
        })
        .nth(n as usize)
        .unwrap();
}
```

### Beer Song

```rust
pub fn verse(n: u32) -> String {
    let phrase = match n {
        1 => one_bottle(),
        0 => no_bottle(),
        _ => some_bottle(n),
    };

    return phrase.to_string();
}

pub fn some_bottle(n: u32) -> String {
    return format!("{} bottles of beer on the wall, {} bottles of beer.\nTake one down and pass it around, {} {} of beer on the wall.\n", n, n, n-1, plural(n-1));
}

pub fn one_bottle() -> String {
    return "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n".to_string();
}

pub fn no_bottle() -> String {
    return "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n".to_string();
}

pub fn plural(n: u32) -> String {
    return match n {
        1 => "bottle".to_string(),
        _ => "bottles".to_string(),
    };
}

pub fn sing(start: u32, end: u32) -> String {
    let mut song = String::from("");

    for n in (end..start + 1).rev() {
        song.push_str(verse(n).as_str());

        if n != end {
            song.push_str("\n");
        }
    }

    return song;
}
```

### Reverse String

```rust
// https://stackoverflow.com/questions/26915472/how-do-i-return-a-reversed-string-from-a-function
pub fn reverse(input: &str) -> String {
    return input
        .chars()
        .rev()
        .collect();
}
```

## Comments on the Exercism approach

### This is a practice tool, not a learning

Just in my experience with the few exercises mentioned above, there is no direct guide / step-by-step approach explaining how to achieve even a subset of the ask. I'd compare this to the likes of Algoexpert where it's more of a practice platform vs learning platform. Not an issue so much since we are living in the information age and Googling esoteric programming concepts should be second nature. I imagine with this approach, I'd want to learn and revisit earlier questions in attempts to rewrite the solutions in a must `rust` fashion.

_Coincidentally, as I listen to [Ask the Expert: Rust at Microsoft](https://www.youtube.com/watch?v=1uAsA1hm52I) which is streaming as I write, they had just mentioned [Github: Rustlings](https://github.com/rust-lang/rustlings) which appears to contain small exercises which would help bridge the learning gap. I will have to review._

### Tests

Cargo's tests are quite adequate for learning in a TDD environment, but I really hate the output compared to Golang's in-house testing framework, Jest, or Rspec even. Here's an example where I purposely added an additional character to trigger a failed test(s), but it's not ever clear (if the issue wasn't already known) which line contains the error. I had to train myself to always reference the `left` line as the expected result. Not a terrible thing by any means, just an initial experience which confused yours truly at the time. Unsure if this is a configuration detail that I missed or an exercism/rust thing, so I'll leave it here.

```bash
running 5 tests
test test_full ... FAILED
test test_one_piece ... FAILED
test test_zero_pieces ... ok
test test_three_pieces ... FAILED
test test_three_pieces_modernized ... FAILED

failures:

---- test_full stdout ----
thread 'test_full' panicked at 'assertion failed: `(left == right)`
  left: `"For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nFor want of a horse the rider was lost.\nFor want of a rider the message was lost.\nFor want of a message the battle was lost.\nFor want of a battle the kingdom was lost.\nAnd all for the want o a nail."`,
 right: `"For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nFor want of a horse the rider was lost.\nFor want of a rider the message was lost.\nFor want of a message the battle was lost.\nFor want of a battle the kingdom was lost.\nAnd all for the want of a nail."`', tests/proverb.rs:60:5

---- test_one_piece stdout ----
thread 'test_one_piece' panicked at 'assertion failed: `(left == right)`
  left: `"And all for the want o a nail."`,
 right: `"And all for the want of a nail."`', tests/proverb.rs:33:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace

---- test_three_pieces stdout ----
thread 'test_three_pieces' panicked at 'assertion failed: `(left == right)`
  left: `"For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nAnd all for the want o a nail."`,
 right: `"For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nAnd all for the want of a nail."`', tests/proverb.rs:25:5

---- test_three_pieces_modernized stdout ----
thread 'test_three_pieces_modernized' panicked at 'assertion failed: `(left == right)`
  left: `"For want of a pin the gun was lost.\nFor want of a gun the soldier was lost.\nFor want of a soldier the battle was lost.\nAnd all for the want o a pin."`,
 right: `"For want of a pin the gun was lost.\nFor want of a gun the soldier was lost.\nFor want of a soldier the battle was lost.\nAnd all for the want of a pin."`', tests/proverb.rs:74:5


failures:
    test_full
    test_one_piece
    test_three_pieces
    test_three_pieces_modernized

test result: FAILED. 1 passed; 4 failed; 0 ignored; 0 measured; 1 filtered out
```

## Initial Opinion on Rust

Rust supports functional programming schemes within the standard libraries, which was welcoming and utterly refreshing instead of having to implement my own shims for map, filter etc. By the third exercise, I started thinking in a manner of how to achieve the requirements using functional paradigms without mutating the input or creating additional variables just to house an array for example. I cannot really express having a working knowledge of how Rust works, or rust idioms for that matter, but I'd certainly deduce that some can be learned from the [official rust book](https://doc.rust-lang.org/book/).

When it comes to digest the syntax, I found Rust proudly wears it's Ruby and Python influences, the anonymous lambda functions taking the `||` "golden bars" as I've come to call it (also not having to specify `return` and instead returning the last line), and Python's `snake_case` function and variable scheme. I love the opinionated idea that chaining of functions is encouraged, along with the obvious memory and type safety which define the language. I'm reminded of the difference between `string` and `String` similar to how Java's types are defined, which leads to many `to_string()`s being appended at the end of my functions.

I find the language overall really does pay homage to languages which the developers had (I imagine) used while building the compiler and semantics. Though it's far too early for me to comment, I can see a small glimpse of the mindset which made this the most loved language for fives years straight now. Whereas I could complain about the slower compile times compared to the likes of C, C++ or Golang, one can surely equate the slower pace with the compiler's attempt to be both your friend and worst nightmare. The top comment on [this HackerNews feed](https://news.ycombinator.com/item?id=23437202) says it best.

> "It's hard but I love it. Dealing with the compiler felt like being the novice in an old kung fu movie who spends day after day being tortured by his new master (rustc) for no apparent reason until one day it clicks and he realizes that he knows kung fu."

## Next Steps

I hope this isn't my last chance to play with Rust. I do intend on learning more through Exercism both on Rust, and with other languages both new and old as practice. Furthermore, I'm far more intrigued to write a terminal application with Rust and compare with my experience writing CLIs in Golang. The idea that all the major players (Microsoft, AWS namely) are declaring Rust to be a vital part of their work and upcoming toolchain truly does catch my attention. Lets see where the landscape goes in the next year or two!

## Resources

- [Cover Image: Photo by Startaê Team on Unsplash](https://unsplash.com/photos/8RX3W79_UTE)
- [Rust.vim](https://github.com/rust-lang/rust.vim)
- [What is Rust and why is it so popular?](https://stackoverflow.blog/2020/01/20/what-is-rust-and-why-is-it-so-popular/)
- [How Microsoft is adopting Rust](https://medium.com/the-innovation/how-microsoft-is-adopting-rust-e0f8816566ba)
- [Why AWS loves Rust, and how we'd like to help](https://aws.amazon.com/blogs/opensource/why-aws-loves-rust-and-how-wed-like-to-help/)
- [Ask the Expert: Rust at Microsoft](https://www.youtube.com/watch?v=1uAsA1hm52I)
- [Github: Rustlings](https://github.com/rust-lang/rustlings)
