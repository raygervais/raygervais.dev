---
title: "Exploring Github Copilot During a Hackathon"
tags: ["Open Source", "Golang", "Rust", "Php", "Python", "C", "C++", "Dot.NET", "Haskell", "Swift", "Clojure", "Java"]
date: 2022-05-01
description: ""
---

_Or, how to distract yourself with technology while trying to build new technology at breakneck speeds_

## Building a Golang-powered Backend


## Feeding the Copilot Ideas

At one point close to the end of our weekend-hackathon experiment, I wanted to depart from the current project and just mess with something else; the idea being the break would help realign and inspire when we returned to finish the project. James had not really seen or worked with Github Copilot before, so I thought it would be awesome to show him why it was so hyped during it's beta release. Yet, we didn't arrive to messing with it organically. Instead, we were doing leet-code styled questions purely to compare approaches to the solution. Upon proiding my solution in JavaScript below (and not accounting for runtime / space complexity), I wondered if I could use it as a prompt for Copilot. 

```js
function rounds_won(scores) {
  let playerOneScore = scores.filter((score) => score === 1).length;
  let playerTwoScore = scores.filter((score) => score === 2).length;

  return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```

So, given the algorithm above which determines from an array input (ex, `[1,2,1,1]`) which player won the more games, could Copilot recreate the function's logic in various languages with no assistance aside from the language prompt? I stumbled upon this experiment purely by accident when I noticed below my function, copilot would suggest `Language: {language}` if I provided `// {language}` in the previous line: 

```js
// C#
```

So, I figured let's see what it would do with the language prompts.

### C#
```csharp
// C#
// Language: C#
public int RoundsWon(int[] scores)
{
    int playerOneScore = scores.Count(score => score == 1);
    int playerTwoScore = scores.Count(score => score == 2);

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```

I found it really intruging that unlike my JavaScript implementation, the C# version used dot.NET naming conventions such as `RoundsWon`. In similar fashion, below the function I was provided a prompt for another language. Here's a sample of what copilot prompted and provided:

### C++

```cpp
// C++
// Language: C++
int rounds_won(vector<int> scores) {
  int playerOneScore = 0;
  int playerTwoScore = 0;

  for (int i = 0; i < scores.size(); i++) {
    if (scores[i] == 1) {
      playerOneScore++;
    } else if (scores[i] == 2) {
      playerTwoScore++;
    }
  }

  return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```

Quite interesting that instead of using a vector iterator by default, copilot suggested using for loops for languages where it's more commonly found. 

### Python

```python
# Python
# Language: Python
def rounds_won(scores):
    playerOneScore = scores.count(1)
    playerTwoScore = scores.count(2)

    return playerOneScore > playerTwoScore and playerOneScore or playerTwoScore
```

For Python, `.count(x)` was leveraged instead of a `for` or filter loop. Quite efficent!

### Ruby

```ruby
# Ruby
# Language: Ruby
def rounds_won(scores)
  playerOneScore = scores.count(1)
  playerTwoScore = scores.count(2)

  return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore
```

Almost indistingusable from the `Python` version, but notice that it's not a direct copy-paste? Here, Copilot has omitted the `:` and instead is using a ternarny `?:` statement.


### Haskell

```haskell
-- Haskell
-- Language: Haskell
rounds_won :: [Int] -> Int
rounds_won scores =
  let playerOneScore = length $ filter (== 1) scores
      playerTwoScore = length $ filter (== 2) scores
  in if playerOneScore > playerTwoScore then playerOneScore else playerTwoScore
```

It was around here that I started to clue in that Copilot is also aware of different language conventions such as the character(s) which define the starting of a comment.

### Clojure

```clojure
;; Clojure
;; Language: Clojure
(defn rounds-won [scores]
  (let [playerOneScore (count scores 1)
        playerTwoScore (count scores 2)]
    (if (> playerOneScore playerTwoScore)
      playerOneScore
      playerTwoScore)))
```

### Swift

```swift
// Swift
// Language: Swift
func roundsWon(scores: [Int]) -> Int {
    let playerOneScore = scores.filter({ $0 == 1 }).count
    let playerTwoScore = scores.filter({ $0 == 2 }).count

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore
}
```

Nice! It even got the quirks of Swift's `$0`closure. Truthfully, this one wasn't provided as a prompt till I provided `// Swift` at the start, then Copilot was in sync with my ideas. 

### Go

```go
// Go
// Language: Go
func roundsWon(scores []int) int {
    var playerOneScore = 0
    var playerTwoScore = 0

    for i := 0; i < len(scores); i++ {
        if scores[i] == 1 {
            playerOneScore++
        } else if scores[i] == 2 {
            playerTwoScore++
        }
    }

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore
}

```

### Objective-C

I figured, let's throw it a curve ball.

```objc
// Language: Objective C
- (int)roundsWon:(NSArray *)scores {
    NSInteger playerOneScore = [scores filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == 1"]].count;
    NSInteger playerTwoScore = [scores filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == 2"]].count;

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```

Mmmm yes. Clearly valid Objective-C with the amount of brackets found in a three line function.

### Java

```java
// Java
// Language: Java
public int roundsWon(int[] scores) {
    int playerOneScore = 0;
    int playerTwoScore = 0;

    for (int i = 0; i < scores.length; i++) {
        if (scores[i] == 1) {
            playerOneScore++;
        }

        if (scores[i] == 2) {
            playerTwoScore++;
        }

    }

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```

Another language where I'm surprised copilot went with the tried-and-true for loop vs iterators or other functional methods.

### V

```v
// V
// Language: V
func roundsWon(scores: [Int]) -> Int {
    var playerOneScore = 0
    var playerTwoScore = 0

    for score in scores {
        if score == 1 {
            playerOneScore++
        } else if score == 2 {
            playerTwoScore++
        }
    }

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore
}
```

### PHP

```php
// PHP
// Language: PHP
function roundsWon($scores) {
    $playerOneScore = count($scores, function($score) {
        return $score == 1;
    }

    $playerTwoScore = count($scores, function($score) {
        return $score == 2;
    }

    return $playerOneScore > $playerTwoScore ? $playerOneScore : $playerTwoScore;
}
```

If I had this 6+ years ago, I might have enjoyed my internship writting PHP everyday.

### Rust

```rust
// Language: Rust
fn rounds_won(scores: &[i32]) -> i32 {
    let playerOneScore = scores.iter().filter(|&score| score == 1).count();
    let playerTwoScore = scores.iter().filter(|&score| score == 2).count();

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```
