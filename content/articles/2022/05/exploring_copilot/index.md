---
title: "Exploring Github Copilot During a Hackathon"
tags: ["Open Source", "Go", "Rust", "Php", "Python", "C", "C++", "Dot.NET", "Haskell", "Swift", "Clojure", "Java"]
date: 2022-05-01
description: "I can remember it like it was just yesterday, I had a long weekend to myself planned to the brim with music and binging Lego Star Wars: The Skywalker Saga. It was the mental and youthful release that I was looking forward to after doing what felt like two weeks of continous overtime to meet a deadline. Then, out of nowhere while chatting with the now CSS-PRO @JamesInkster, the following exchange occurred which would change the course of said weekend" 
Cover: images/jan-huber-0xNbk7D_s6U-unsplash.jpg
---

_Or, how to distract yourself with technology while trying to build new technology at breakneck speeds_

## Building a Golang-powered Back-end

I can remember it like it was just yesterday, I had a long weekend to myself planned to the brim with music and binging Lego Star Wars: The Skywalker Saga. It was the mental and youthful release that I was looking forward to after doing what felt like two weeks of continous overtime to meet a deadline. Then, out of nowhere while chatting with the now CSS-PRO [@JamesInkster](https://grommers.wordpress.com), the following (_reenactment_) exchange occurred: 

> James: I want to work on a project again
> Me: Bet. What if we did a hackathon this long weekend?
> James: Sounds like a plan.

And thus, my dreams of Lego and Music would wait a few more days as we dove into the unknown. Instead, we put together a semantic which would define the project and the requirement that similar to a well done Hackathon project, it would be fully working & presentable by the end of the weekend. 

After much brainstorming, James came up with the idea of `Down 4 Whatever`, which was an application based around the concept of throwaway prompts that could be responded to within an hour of creation. It had potential, and followed the similar REST + Front-end paradigms that we knew where to go when starting. James wanted to focus on the CSS & front-end, which I was happy to avoid, so we decided I'd do the back-end which would serve the front-end similarly to the coming-back-into-style paradigm of server-side rendering. I chose Go for my back-end, and though it's not a new technology for me, it allowed me to experiment with design patterns and concepts that I had not yet had a chance to do so.

It was after I had written the database models that I realized it wasn't just me looking at the code. Upon me going to write the first bit of CRUD functions for the models, I noticed a familiar prompt for the following: `func (db *Database) AddRoom(room *entities.Room) error {`. GitHub Copilot was active! In a moment of both curiosity and laziness, I thought, let's see what Copilot can do with my models if I were to ask it to write the CRUD functions. In a way, I could tell James would be annoyed because from a certain point of view, I was bypassing many of the coding requirements that I was responsible for. Still, that depends on your _point of view_, and mine was more interested in seeing what Copilot would suggest. To summarize, Copilot provided the following CRUD solutions (abridged to just the function headers) with very minimal human interaction: 

```go
// entities.Room CRUD
func (db *Database) AddRoom(room *entities.Room) error
func (db *Database) UpdateRoom(room *entities.Room)
func (db *Database) GetRoom(id string) *entities.Room
func (db *Database) RemoveRoom(id string)

// This one took me giving a long-winded comment prompt, but Copilot figured it out
func (db *Database) ListExpiredRooms() entities.RoomList

// entities.Prompt CRUD
func (db *Database) AddPrompt(id string, prompt *entities.Prompt) error
func (db *Database) GetPrompts(id string) entities.PromptList
func (db *Database) RemovePrompt(id string, promptId string)

// entities.Comment CRUD
func (db *Database) AddComment(id string, comment *entities.Comment) error
func (db *Database) GetComments(id string) entities.CommentList
```

For the full source code, you can find the repository at [github.com/raygervais/dfw](https://github.com/raygervais/dfw). What I found interesting is while implementing the CRUD for the sub-resources (`Prompt`, `Comment`), Copilot took into account always retrieving the room associated with the `Id` provided in the arguments. Each function which interacts with a single room _object_ has the following at the start: 

```go
room := db.GetRoom(id)
if room == nil {
    return errors.New("Room not found")
}
```

I find it really interesting that the suggestions also took into account my design, which was to have no true database and instead store the items in memory for their lifetime. 


## Feeding the Copilot Ideas

At one point close to the end of our weekend-hackathon experiment, I wanted to depart from the current project and just mess with something else; the idea being the break would help realign and inspire when we returned to finish the project. James had not really seen or worked with GitHub Copilot before, so I thought it would be awesome to show him why it was so hyped during it's beta release. Yet, we didn't arrive to messing with it organically. Instead, we were doing leet-code styled questions purely to compare approaches to the solution. Upon providing my solution in JavaScript below (and not accounting for run-time / space complexity), I wondered if I could use it as a prompt for Copilot. 

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

For Python, `.count(x)` was leveraged instead of a `for` or filter loop. Quite efficient!

### Ruby

```ruby
# Ruby
# Language: Ruby
def rounds_won(scores)
  playerOneScore = scores.count(1)
  playerTwoScore = scores.count(2)

  return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore
```

Almost indistinguishable from the `Python` version, but notice that it's not a direct copy-paste? Here, Copilot has omitted the `:` and instead is using a ternary `?:` statement.


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

If I had this 6+ years ago, I might have enjoyed my internship writing PHP everyday.

### Rust

```rust
// Language: Rust using functional paradigms
fn rounds_won(scores: &[i32]) -> i32 {
    let playerOneScore = scores.iter().filter(|&score| score == 1).count();
    let playerTwoScore = scores.iter().filter(|&score| score == 2).count();

    return playerOneScore > playerTwoScore ? playerOneScore : playerTwoScore;
}
```


### Closing Thoughts

Let me preface first that aside from my original solution, I did not test any of the prompts and solutions provided by Copilot. Instead, I used the overall solutions as a thought experiment to compare what the AI was suggesting for each language vs how I'd do it in each language. 

- The original implementation of the `Rust` solution leveraged for loops, but I found it really interesting that providing the prompt `// rust solution using functional paradigms`provided a vastly different solution which used the `filter()` function.
- I'm absolutely dumbfounded to think of the amount of training data which went into Github Copilot to the point where it's learned the idioms of specific languages (such as C#'s naming semantics vs the original solution, the use of `:=` in the go solution, etc), but can also see where more training is needed given that each variable per-language still uses the same variable naming-scheme of my original solution.
- Code reviews between junior and senior developers are going to become quite the gray area, because I can already tell how easily some will use the exact prompts provided by Copilot as their final solution. I understand the appeal, but I fear that it'll incentivize a generation of developers who don't `understand` the codebase they are `writing`. 

## Resources

- [Cover Image: Photo by Jan Huber on Unsplash](https://unsplash.com/photos/0xNbk7D_s6U)
