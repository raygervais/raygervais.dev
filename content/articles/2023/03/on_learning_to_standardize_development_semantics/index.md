---
title: On Learning To Standardize Development Semantics
date: 2023-03-31
tags: ["Open Source", "Go", "Kubernetes", "Cloud", "Cloud Native", "Thoughts", "Experiments"]
Cover: https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8
description: "I've been working in the Cloud Native space for over 1.5 years, and in that time I've had weekly chances to succeed and
conquer what defeated me previously; I leveled up. Yet, in order to succeed, you also have to fail and learn from those
failings."
---

I've been working in the Cloud Native space for over 1.5 years, and in that time I've had weekly chances to succeed and
conquer what defeated me previously; I leveled up. Yet, in order to succeed, you also have to fail and learn from those
failings. Luckily, I've never felt that failing was a consequence of not being `good enough` on my team, nor was there
ever any concerns that I may fail again; but that's not the point so I'll save that for another post. In retrospect,
half of the failings that I wish I could explain are really just inexperienced decisions which I now understand far
better, and look forward to correcting when the opportunity presents itself. So, I'll stop saying succeed and fail, and
replace both worths with lessons. I've had many lessons in this space, many of which due to going beyond the
documentation (if there were any at all) on a specific topic due to the complexities or requirements of the task. See,
it turns out that when you go through those motions and tangle with the technical weeds enough, you become a subject
matter expert in the eyes of others that *you* look up to.

Some of my lessons have been buried within my notes, exploring ideas which turn idiomatic code blocks into monsterous
almagamations of bootstrapped `I wish the language had this` language features, such as my experiments with using a
`Result` type in Go the moment Generics were released in 1.18. Luckily, my team never had to see this within our
codebase, but you bet I considered introducing it. I even had an entire `Lunch and Learn` drafted around breaking
languages such as Go with non-idiomatic features which looked as horrible as it sounds. An example, which I'm pulling
from memory:

```go
type Result[T any] struct{
    var T
    err error
}

func (r Result[T any]) GetOrDefault(def T) T {
    if r.err != nil {
       return def
    }

    return r.val
}

func (r Result[T any]) Error() error {
    return r.err
}

func (r Result[T any]) Pipe(fn ...func(T) Result[T] ) Result[T] {
        val carrier = r
        for _, f := fn {
            if carrier.err != nil {
                return carrier
            }

            carrier := f(carrier.val)
        }

        return carrier
}

func ReadFileContents[string](path string) Result[string] {
    dat, err := os.Readfile("/tmp/test.log")
    if err != nil {
        return Result{err: err}
    }
    return Result{val: string(dat)}
}

func FeatureFlagEnabled(path string) error {
    return ReadFileContents(path).Pipe(
            func(str) Result { return Result{val: fmt.ToUpperCase(str)} },
            func(str) Result { return Result{strings.Split(str, "\n")[0]} },
            func(str) Result { 
                if str != "enabled" {
                    return Result[err: fmt.Errorf("expected path %s to be enabled", path)]
                }
                return Result{val: str}
            },
        ).
    Error()
}
```

Now that I've given you a laugh, let me jump into the actual topic of this little writeup, which I promise relates to
the above. Above was an example of me being silly and spiteful towards Go, a language which works so well at both
impressing, and frustrating every developer I've ever worked with. Yet, these silly little lessons also add up to
legitamate patterns and architectures which you can only really concieve through trial and error (unless you're an
absolute programming beast, to which I'm far from)! More so, over time I've had the chance to explore more legitamate
development approaches including testing out various loggers, output formattings, project architectures, testing
strategies, controller ideologies -to name a few. All of which have lead to an interesting spectrum of earlier bodies of
work becoming an embarassing example of what *not to do*, and newer pieces becoming the foundation of even more advanced
concepts that the team is cooking up. It's in this train of thought that some see the work as equating to subject matter
experts within the local area, or veterans of the war on bad semantics. So, in the spirit of open source, why not share
all of the lessons, advice, trials, failures -everything, with the neighboring teams who you already collaborate with
daily? More so, why not collaborate together, joining the experience of *all* teams who wish to take part into a single
source of truth; a standard for working in that paticular area. A standard written in markdown (preferrably), and peer
reviewed by all those who are equally building with and ontop of it.

There's also another motive as to why this initative is growing far beyond a whisper, the team noticed well into our
infancy when doing our best to learn Kubernetes Operators through courses, reviewing open source operators, and even
consulting the sacred texts (Manning, O'Riley, etc) the following common problem: even within the same org, all
operators are written in silos to the point where no common semantics exist. Talk about sending mixed messages when
trying to learn something not easily explained. Internally, I know our teams have all expressed similar, so I look
forward to seeing where we take this and how it improves the overall experience for new and old devs alike. Furthermore,
I believe that in doing so, there's no downsides, so why wouldn't you try if the motivation, ambition, or energy was there?

## Resources

- [Cover Image: Photo by NASA on Unsplash](https://unsplash.com/photos/Q1p7bh3SHj8)
- [Preslav Rachev: Generic Go Pipes](https://preslav.me/2021/09/04/generic-golang-pipelines/)
- [Labix: Unix-like Pipelines for Go](https://labix.org/pipe)
