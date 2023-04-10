---
title: Some Tips I learned from 100 Mistakes in Go
tags: ["Open Source", "Go", "Software Development"]
date: 2023-04-09
Cover: https://images.unsplash.com/photo-1600787449405-cfed74773992?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx
description: "Recently I finished reading Teiva Harsanyi's _[100 Mistakes and How To Avoid
Them](https://www.manning.com/books/100-go-mistakes-and-how-to-avoid-them)_, and instead of writing a review (TLDR,
everyone working with Go should read this), I thought I'd share four `mistakes` which I found interesting and didn't
know before."

---

Recently I finished reading Teiva Harsanyi's _[100 Mistakes and How To Avoid
Them](https://www.manning.com/books/100-go-mistakes-and-how-to-avoid-them)_, and instead of writing a review (TLDR,
everyone working with Go should read this), I thought I'd share four `mistakes` which I found interesting and didn't
know before.

## #13. Creating Utility Packages

So, I have an incredibly-stubborn approach of writing utilitly packages in most of my projects the moment a piece of
code is used _more than once_. In doing so, I've commonly called the package `utils` if they did somewhat generic (in
context to the API) operations such as formatting, validation, etc. What I've come to realize both from the book, and
advice from other devs is, `util` is meaningless. It could be called `common`, `shared`, or `base`, but it still remains
a meaningless name that doesn't describe any insights relating to what it's API provides. For example,

```go
package util

func NewStringSet(...string) map[string]struct{} { ... }
func SortStringSet(map[string]struct{}) []string { ... }

// client.go
set := util.NewStringSet("A", "B", "C")
fmt.Println(util.SortStringSet(set))
```

Instead, the utility package should be broken up (if there's multiple competing responsibiltiies), and renamed to
something more expressive and clear, such as `stringset` in this case. Taking this further, perhaps purely out of spite,
I like to structure my packages similar to a parent (interface | context) -> child (implementation) structure, so
`stringset` would be found in the following path: `your_project/pkg/utils/stringset`. Perhaps in a follow up `100 More
mistakes in Go`, this will be proven to also be a bad design; till then!

```go
package stringset

func New(...string) map[string]struct{} { ... }
func Sort(map[string]struct{}) []string { ... }
```

## #26. Slice's Leaking Capacity

Despite working with Go in a professional context for over two years, I still haven't bothered to learn the distinctions
between slices and arrays. I'd be rather confident to point out that in a given function or codeblock, I wouldn't know
which were in use or the best to use. So, upon reaching this section of the book which detailed the different Data Types
and the common mistakes associated to them, I had to do a little background research on `slices` vs arrays. Andrew
Gerrand's explanation in [Go Slices: usage and internals](https://go.dev/blog/slices-intro) describes `slices` and
arrays as:

> The slice type is an abstraction built on top of Go’s array type, and so to understand slices we must first understand
> arrays. An array type definition specifies a length and an element type. For example, the type [4]int represents an
> array of four integers. An array’s size is fixed; its length is part of its type ([4]int and [5]int are distinct,
> incompatible types). Arrays can be indexed in the usual way, so the expression s[n] accesses the nth element, starting
> from zero. Arrays have their place, but they’re a bit inflexible, so you don’t see them too often in Go code. Slices,
> though, are everywhere. They build on arrays to provide great power and convenience. The type specification for a
> slice is []T, where T is the type of the elements of the slice. Unlike an array type, a slice type has no specified
> length.

So, with that little bit of understanding now onhand, what are does the it mean to `leak capacity`?

Referencing the source from [Github:
teivah/100-go-mistakes](https://github.com/teivah/100-go-mistakes/blob/master/03-data-types/26-slice-memory-leak/capacity-leak/main.go)
example repo, Teiva explains,

> The slicing operation on msg using msg[:5] creates a five-length slice. However, its capacity remains the same as the
> initial slice. The remaining elements are still allocated in memory, even if eventually msg is not referenced

```go
func consumeMessages() {
 for {
  msg := receiveMessage()
  // Do something with msg
  storeMessageType(getMessageType(msg))
 }
}

func getMessageType(msg []byte) []byte {
    return msg[:5]
}

func receiveMessage() []byte {
    return make([]byte, 1_000_000)
}

func storeMessageType([]byte) {}

func printAlloc() {
    var m runtime.MemStats
    runtime.ReadMemStats(&m)
    fmt.Printf("%d KB\n", m.Alloc/1024)
}
```

Then, to further explain the issue at a grander scale, Teiva provides the following scenario:

> Let's use an example with a large message length of 1 million bytes. The backing array of the slice still contains 1
> million bytes after the slicing operation. Hence, if we keep 1,000 messages in memory, instead of storing about 5 KB,
> we hold about 1 GB.

The recommended approach for this type of issue? Use a slice copy!

```go
func getMessageTypeWithCopy(msg []byte) []byte {
    msgType := make([]byte, 5)
    copy(msgType, msg)
    return msgType
}
```

## #46. Using a Filename as a Function Input

Even within a kubernetes, cloud-native centric environment, I find myself writing functions very similar to Teiva's
example. A simple function which would read the file contents of any filename provided as an argument. In fact, I was
going to explain some of my frustrations with the design (not thinking that there could be better of course), but the
author explains one of the biggest pitfalls so well in this excerpt,

> When creating a new function that needs to read a file, passing a filename isn’t considered a best practice and can
> have negative effects, such as making unit tests harder to write.

```go
func countEmptyLinesInFile(filename string) (int, error) {
    file, err := os.Open(filename)
    if err != nil {
        return 0, err
    }
    // Handle file closure

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
    // ...
    }

    return 0, nil
}
```

While writing unit tests, I've never been fond of committing test-resources into a repo whereas they could be stored
within the tests themselves pragmatically. Stubborness perhaps, but I blame the beauty of keeping _all_ assets needed to
a `test case` within the `testCase`.

So, what's the better design for such APIs? Making the function take in a `io.Reader` argument instead! Upon reading
this explanation, I'm actually relieved at how much _better_ of a design this!

```go
func countEmptyLines(reader io.Reader) (int, error) {     
    scanner := bufio.NewScanner(reader)
    for scanner.Scan() {
          // ...
    }
}
```

## #54. Not Handling Defer Errors

`defer` is a commonly used keyword within Go, yet I never had heard of a deferred error. In fact, had you asked me
before reading that chapter, I wouldn't have believed that you could use an error type with defer. It's a common
mistake, for I've seen patterns which don't handle the defer errors in dozens and dozens of code bases. So, how can we
improve? Using the example provided,

```go
func getBalance(db *sql.DB, clientID string) (
    float32, error) {
    rows, err := db.Query(query, clientID)
    if err != nil {
        return 0, err
    }
    defer rows.Close()
 
    // Use rows
}
```

The `Closer` interface implemented by the example's `*sql.Rows` type includes the `closer.Closer` function, a function
which returns an error. Yet, as we can see in the sample above, no handling of the returned `error` value occurs. Yet,
if `defer` is called to imply a set of logic to occur before returning from the function, how do we handle the error
without losing our context or prexisting error?

```go
func getBalance3(db *sql.DB, clientID string) (balance float32, err error) {
    rows, err := db.Query(query, clientID)
    if err != nil {
        return 0, err
    }
    
    defer func() {
        closeErr := rows.Close()
        if err != nil {
            if closeErr != nil {
                log.Printf("failed to close rows: %v", err)
            }
            return
        }
        err = closeErr
    }()

    // Use rows
    return 0, nil
}   
```

> The rows.Close error is assigned to another variable: closeErr. Before assigning it to err, we check whether err is
> different from nil. If that’s the case, an error was already returned by getBalance, so we decide to log err and
> return the existing error.

I found the explanation of the design interesting, because it includes a not-as-common language feature of go, `named
returns`. This feature I've heard all over the internet of being an anti-pattern to `simple` design, or a code smell to
avoid, but I have no real opinion myself, though I've never had a need to use it either, so that's where I can admit my
inexperience. Instead, I'll reference [GeeksforGeeks: Named Return Parameters in
Golang](https://www.geeksforgeeks.org/named-return-parameters-in-golang/),

> In Golang, Named Return Parameters are generally termed as the named parameters. Golang allows giving the names to the
> return or result parameters of the functions in the function signature or definition. Or you can say it is the
> explicit naming of the return variables in the function definition.

So, instead of returning `nil` at the very end of the function, it would instead return the value of `err` after the
`defer func()` has been run. With `err` being updated with the status of that operation if no other `err` value exists.

## Resources

- [Cover image: Photo by Santa Barbara on Unsplash](https://unsplash.com/photos/NCSARCecw4U)
- [Manning: 100 Mistakes and How To Avoid Them](https://www.manning.com/books/100-go-mistakes-and-how-to-avoid-them)
- [Github: teivha/100-go-mistakes](https://github.com/teivah/100-go-mistakes)
