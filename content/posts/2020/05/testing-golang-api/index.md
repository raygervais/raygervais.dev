---
title: Writing Golang Tests for an Alcoholic REST API
published: true
date: 2020-05-25
tags: [ "Open Source","Golang","Software Development", "Lessons", "Athenaeum", "Testing" ]
cover_image: ./images/tomasz-frankowski-kBUfvkbFIoE-unsplash.jpg
description: "Continuing on with last week's Athenaeum post, I mentioned that I wanted to explore easily overlooked processes or topics that junior developers don't always have the chance to dive into. The original intent being to allow the project to grow in such a way that it would demonstrate through it's iterative history a step-by-step example of taking a small project all the way to the big world of Public Clouds, Containers, and other infrastructure goodies. Along with that, I also wanted to explore software development patterns and testing practices. In this article, I want to explain what's been done so far: writing back-end unit tests and exploring the world of `code coverage`!"
---

_func TestHelloWorld(t \*testing.T) {} is so well engrained into my muscle memory_

Continuing on with last week's Athenaeum post, I mentioned that I wanted to explore easily overlooked processes or topics that junior developers don't always have the chance to dive into. The original intent being to allow the project to grow in such a way that it would demonstrate through it's iterative history a step-by-step example of taking a small project all the way to the big world of Public Clouds, Containers, and other infrastructure goodies. Along with that, I also wanted to explore software development patterns and testing practices. In this article, I want to explain what's been done so far: writing back-end unit tests and exploring the world of `code coverage`!

## How To Test Golang

If you follow my Twitter, you'll see that I've been a huge fan of the [Learning Golang with Tests]() online book. The course I'd recommend to anyone who's interested in software development because aside from teaching Go's idioms, it also teaches fantastic Test Driven Development (TDD) semantics and the art of writing DRY (Don't Repeat Yourself) code. I'd argue, that even if you forget about Golang or adapt it the lessons to a different language, the wisdom found in the lessons are invaluable.

One thing that's explained in the first chapter, the `Hello, World!` of tests if you will, is Go comes with its own testing capabilities in the standard library. Any file with the naming scheme of `*_test.go` is viewed as a test file, not a run-time file (which allows for us to distinctly run a folder structure with `go run .` vs `go test`)! Likewise,

## Your First Test

Let's use this main.go file example for this section, which will enable us to test the `Greet` function. Having testable functions and components (compared to testing the entire program) is essential for good software design in my opinion.

```go
// main.go
package main

import "fmt"

// Greet concatenates the given argument with a predetermined 'Hello, '
func Greet(name string) string {
  return "Hello, " + name
}

func main() {
  fmt.Println(Greet("Unit Testing 101"))
}
```

We could write the following test!

```go
// main_test.go
package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestGreet(t *testing.T) {
	expected := "Hello, World!"
	received := Greet("World!")

  assert.Equals(t, expected, received)
}
```

So, what exactly does this do? Let's break down the process.

1. I'm leveraging the testify (specifically, the assert sub-package) package by Stretchr. This is a common library used in Golang Testing for assert.\* patterns.
2. All test functions start with `Test`, which most IDEs will allow you to interact with and test on demand.
3. From all the tutorials that I've seen around Golang testing, we're encouraged to create the `expected` struct/variable that will be referenced and compared later.
4. Received is the variable that will store the result of our function call.
5. Let's compare the result compared to what we're expecting to have.

With the above steps, you've written your first Golang Unit Test! The `Greet` function that we wrote is stupidly basic (and also a pure function, which is a nice little hat tip to my functional programming interests!), but allows for a great example of composing testable functions. The next question is, where do we go from here? What else could you test with the same concept? Here's a brief list of scenario's that I'll go into in greater detail later which could be tested in similar patterns:

- Scenario: Your function parses a JSON response, and returns an error object if there were any issues.
  - Test: When provided a valid JSON response, our function should return `nil`
- Scenario: Your function returns a corresponding `struct` that has the same `ID` as what's passed in, along with an error object.
  - Test: When provided a invalid (negative) ID, our function should return an empty `struct`, and `error` object.

Once we have tests for such scenarios written and passing, the next question should be: What else can we test?

## A Brief Introduction to Test Driven Development

I had wrote about TDD and NodeJS in [2017](https://raygervais.dev/article/unit-testing-a-node-js-driven-project/), where it was all the rage between my Open Source classes and Internship in Mississauga, but figured it would be best to explain here from the perspective of writing and testing a REST API. [Martin Fowler explains Test Driven Development](https://martinfowler.com/bliki/TestDrivenDevelopment.html) as,

> Test-Driven Development (TDD) is a technique for building software that guides software development by writing tests. It was developed by Kent Beck in the late 1990's as part of Extreme Programming. In essence you follow three simple steps repeatedly:

> - Write a test for the next bit of functionality you want to add.
> - Write the functional code until the test passes.
> - Refactor both new and old code to make it well structured.

> You continue cycling through these three steps, one test at a time, building up the functionality of the system. Writing the test first, what XPE2 calls Test-First Programming, provides two main benefits. Most obviously it's a way to get SelfTestingCode, since you can only write some functional code in response to making a test pass. The second benefit is that thinking about the test first forces you to think about the interface to the code first. This focus on interface and how you use a class helps you separate interface from implementation.

> The most common way that I hear to screw up TDD is neglecting the third step. Refactoring the code to keep it clean is a key part of the process, otherwise you just end up with a messy aggregation of code fragments. (At least these will have tests, so it's a less painful result than most failures of design.)

So, where does this come into play for our previous example if I wanted to follow a TDD approach? Let's iterate on possible test cases for our first hypothetical scenario.

_As a reminder: Your function parses a JSON response, and returns an error object if there were any issues._

We could test the following (for example):

- Test: When provided a valid JSON response, our function should return `nil`
- Test: When provided an invalid JSON response, our function should return the parse error.
- Test: When provided a malformed JSON string, our function should return the parse error.
- Test: When provided a JSON response which doesn't map to our `struct`, our function should return the mapping error.

We're testing various scenarios, some plausible and well-worth being tested, and others more far-fetched which help to provide sanity to the "what if" scenarios. Now, you mentioned something about testing a Alcoholic REST API?

## Writing REST API Tests with TDD

Going forward, I'll be referencing Athenaeum's [main.go](https://github.com/raygervais/Athenaeum/blob/master/src/backend/main.go), and with it's rapid updates will omit including an already out-of-date version here. Currently, our main.go serves as the REST API router with the following CRUD (create, read, update, delete) routes:

- GET /
- GET /books/
- GET /books/:id
- POST /books/
- PATCH /books/:id
- DELETE /books/:id

With TDD, I went about writing the following test scenario's prior to writing the code itself:

- SCENARIO: Valid GET / request should return "Hello, World!"
- SCENARIO: Valid GET /books/ request against an empty database should return 0 results.
- SCENARIO: Valid GET /books/ request against a populated database should return all books.
- SCENARIO: Valid GET /books/:id/ request with ID against populated database should return specific book.
- SCENARIO: Valid GET /books/:id/ request with Invalid ID against a populated database should return a "Record not found!" error

So we've covered the common use-cases for the first three routes, and that last one looks rather interesting. Let's break it down before moving forward.

```go

// imports ()

// Helper Function
func performRequest(r http.Handler, method, path string) *httptest.ResponseRecorder {
	req, _ := http.NewRequest(method, path, nil)
	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)
	return w
}

// Test Cases

func TestBooksCRUD(t *testing.T) {
	t.Run("Retrieve Non-Existing ID", func(t *testing.T) {
		  w := performRequest(router, "PATCH", "/books/-2")

		  assert.Equal(t, http.StatusBadRequest, w.Code)
		  assert.Equal(t, "{\"error\":\"Record not found!\"}", w.Body.String())
	})
}
```

1. I skipped the imports, but you can reference the [public version]https://github.com/raygervais/Athenaeum/blob/master/src/backend/main_test.go) for the complete source.
2. I picked up the `performRequest` function from [Craig Childs' Golang Testing - JSON Responses with Gin](https://medium.com/@craigchilds94/testing-gin-json-responses-1f258ce3b0b1) tutorial. Makes for far cleaning code reuse.
3. `TestBooksCRUD` has the familiar test function signature, so this should be familiar.
4. `t.Run` allows us to define sub-tests which relate to the parent's context. I'm leveraging this concept to group tests which relate to each other together instead of creating dedicated functions for each.
5. `w` is the response from our request, which is defined and executed using the helper function `performRequest`.
6. The last two lines are your typical `assert.Equal` patterns, ensuring that we are receiving the correct response code (400), and error: "Record not found!".

All of the tests that I listed for our REST API utilize similar code to compare and check against each condition. Test Driven Development shouldn't stop at the "common" tests, but instead reach out to patterns and scenario's which no one expects. Essentially, I view TDD as a way to write witty tests which cover the greater use-cases that keep some SRE (system reliability engineers) up at night. Dave had taught us in OSD500 to throw as many tests as we wanted at our functions, essentially trying to bend and break the inputs in a test of how resilient our code was. Likewise, Learning Go With Tests goes over how adding use-cases, types, and off-chance scenario's allows us to investigate truly how robust our functions and handlers are. So with that, let's list all the scenario's that I came up with for our `main_test.go` file against the REST API:

- SCENARIO: Valid GET / request should return "Hello, World!"
- SCENARIO: INVALID POST/ should return a 404 code and "404 page not found".
- SCENARIO: INVALID DELETE / should return a 404 code and "404 page not found".
- SCENARIO: INVALID PATCH / should return a 404 code and "404 page not found".
- SCENARIO: Valid GET /books/ request against an empty database should return 0 results.
- SCENARIO: Valid GET /books/ request against a populated database should return all books.
- SCENARIO: Valid GET /books/:id/ request with ID against populated database should return specific book.
- SCENARIO: Invalid GET /books/:id/ request with negative ID against a populated database should return a "Record not found!" error.
- SCENARIO: Invalid POST /books/ without `models.CreateBook` JSON mapping should return a 400 code and error message.
- SCENARIO: Valid POST /books/ with the latest Harry Potter novel should return a 200 code and book.
- SCENARIO: Invalid POST /books/ with an array of `[]models.Book` should return a 400 code and error message.
- SCENARIO: VALID PATCH /books/:id/ request with valid ID, and an updated `models.UpdateBook` struct that has a modified title should return 200 and the updated book.
- SCENARIO: INVALID PATCH /books/:id/ request with valid ID, but no body should return 400 and error message.
- SCENARIO: INVALID PATCH /books/:id/ without an id should return 400 and error message.
- SCENARIO: INVALID PATCH /books/ should return a 404 code and "404 page not found".
- SCENARIO: INVALID PATCH /books/:id/ request with Valid ID, and incorrect JSON body should return 400 and JSON mapping error message.
- SCENARIO: Valid DELETE /books/:id/ with a valid ID should return 200.
- SCENARIO: Invalid DELETE /books/:id/ with a invalid ID should return 400 and "Record not found!" error.
- SCENARIO: INVALID DELETE /books/ should return a 404 code and "404 page not found".

What do most of these tests look like? At the time of writing main_test.go contained the following:

```go
func TestBooksCRUD(t *testing.T) {
	dbTarget := "test.db"

	router, db := SetupRouter(dbTarget)

	db.DropTableIfExists(&models.Book{}, "books")
	db = models.SetupModels(dbTarget)
	defer db.Close()

	t.Run("Create Empty DB", func(t *testing.T) {
		w := performRequest(router, "GET", "/books/")

		assert.Equal(t, http.StatusOK, w.Code)
	})

	t.Run("Retrieve Nonexistent ID on Empty DB", func(t *testing.T) {

		w := performRequest(router, "GET", "/book/2")

		assert.Equal(t, http.StatusNotFound, w.Code)
	})

	t.Run("Populate DB with Harry Potter Set", func(t *testing.T) {
		books := []string{
			"Harry Potter and The Philosopher's Stone",
			"Harry Potter and The Chamber of Secrets",
			"Harry Potter and The Prisoner of Azkaban",
			"Harry Potter and The Goblet of Fire",
			"Harry Potter and The Order of The Phoenix",
			"Harry Potter and The Half-Blood Prince",
			"Harry Potter and The Deathly Hallows",
		}

		for _, book := range books {

			payload, _ := json.Marshal(models.CreateBookInput{
				Author: "J. K. Rowling",
				Title:  book,
			})

			req, err := http.NewRequest("POST", "/books/", bytes.NewReader(payload))
			req.Header.Set("Content-Type", "application/json")

			w := httptest.NewRecorder()
			router.ServeHTTP(w, req)

			assert.Equal(t, nil, err)
			assert.Equal(t, http.StatusOK, w.Code)
		}
	})

	t.Run("Retrieve Existing ID on Populated DB", func(t *testing.T) {
		w := performRequest(router, "GET", "/books/2")

		expected := models.Book{
			Author: "J. K. Rowling",
			ID:     2,
			Title:  "Harry Potter and The Chamber of Secrets",
		}

		var response models.Book
		err := json.Unmarshal([]byte(w.Body.String()), &response)

		assert.Nil(t, err)
		assert.Equal(t, http.StatusOK, w.Code)
		assert.Equal(t, expected, response)
	})

	t.Run("Attempt Updating Non-Existing ID", func(t *testing.T) {
		w := performRequest(router, "PATCH", "/books/-2")

		assert.Equal(t, http.StatusBadRequest, w.Code)
		assert.Equal(t, "{\"error\":\"Record not found!\"}", w.Body.String())
	})

	t.Run("Updated Existing ID with Invalid Values", func(t *testing.T) {
		payload, _ := json.Marshal(map[int]string{
			2: "Harry Potter",
			3: "JK Rowling",
			4: "22",
		})

		req, err := http.NewRequest("PATCH", "/books/-2", bytes.NewReader(payload))
		req.Header.Set("Content-Type", "application/json")

		w := httptest.NewRecorder()

		router.ServeHTTP(w, req)

		assert.Equal(t, nil, err)
		assert.Equal(t, http.StatusBadRequest, w.Code)
	})

	t.Run("Update Existing ID on Populated DB", func(t *testing.T) {
		payload, _ := json.Marshal(models.UpdateBookInput{
			Title: "Harry Potter and The Weird Sisters",
		})

		req, err := http.NewRequest("PATCH", "/books/6", bytes.NewReader(payload))
		req.Header.Set("Content-Type", "application/json")

		w := httptest.NewRecorder()
		router.ServeHTTP(w, req)

		assert.Equal(t, nil, err)
		assert.Equal(t, http.StatusOK, w.Code)
	})

	t.Run("Get Updated Book from Populated DB", func(t *testing.T) {
		expected := models.Book{
			Author: "J. K. Rowling",
			Title:  "Harry Potter and The Weird Sisters",
			ID:     6,
		}

		w := performRequest(router, "GET", "/books/6")

		var response models.Book
		err := json.Unmarshal([]byte(w.Body.String()), &response)

		assert.Nil(t, err)
		assert.Equal(t, http.StatusOK, w.Code)
		assert.Equal(t, expected, response)
	})

	t.Run("Delete Invalid Book from Populated DB", func(t *testing.T) {
		w := performRequest(router, "DELETE", "/books/-1")
		assert.Equal(t, http.StatusBadRequest, w.Code)
	})

	t.Run("Delete Without ID Book from Populated DB", func(t *testing.T) {
		w := performRequest(router, "DELETE", "/books/")
		assert.Equal(t, http.StatusNotFound, w.Code)
		assert.Equal(t, "404 page not found", w.Body.String())
	})

	t.Run("Delete valid Book from Populated DB", func(t *testing.T) {
		w := performRequest(router, "DELETE", "/books/6")

		assert.Equal(t, "{\"data\":true}", w.Body.String())
		assert.Equal(t, http.StatusOK, w.Code)
	})
}
```

## Next Steps

So once you have your API routes covered, what's next? I opted to (stubbornly) go deeper. I thought, if each bit of logic should have a test, then why don't we also replicate many of the tests at the controller level using a mock-router. Why, you may be asking? Well in my mind, this is to not so-much as duplicate the main level API tests, but instead test against the controller logic and their input / outputs. It's another layer of sanity checks which I'd like to think help ensure the functions are being updated without breaking known functionality. The book controller can be referenced [here](https://github.com/raygervais/Athenaeum/blob/master/src/backend/controllers/book.go), but an example of the `UpdateBook` (and it's helper function `RetrieveBookByID` looks like this, which I learned about thanks to [LogRocket's tutorial](https://blog.logrocket.com/how-to-build-a-rest-api-with-golang-using-gin-and-gorm/)) appears as:

```go

package controllers
// imports ()

// RetrieveBookByID is a helper function which returns a boolean based on success to find book
func RetrieveBookByID(db *gorm.DB, c *gin.Context, book *models.Book) bool {
	if err := db.Where("id = ?", c.Param("id")).First(&book).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": errRecordNotFound})
		return false
	}

	return true
}


// UpdateBook called by PATCH /books/:id
// Update a book
func UpdateBook(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)

	// Get model if exist
	var book models.Book
	if !RetrieveBookByID(db, c, &book) {
		return
	}

	// Validate input
	var input models.UpdateBookInput
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	db.Model(&book).Updates(input)

	c.JSON(http.StatusOK, book)
}
```

When writing the tests, I came into a major issue when having to deal with more advanced requests: how does one mock a request body? Without learning how to do this, I wouldn't be able to test the `CreateBook`, `UpdateBook` functions which I would argue is a big deal. So, two hours later of Googling and trial-and-error led me to this nugget of magical goodness (which also is where my tweets became sporadic as I embarked on the quest for 100% code coverage with my new found powers):

```go
func SetupContext(db *gorm.DB) (*httptest.ResponseRecorder, *gin.Context) {
	w := httptest.NewRecorder()
	c, _ := gin.CreateTestContext(w)
	c.Set("db", db)

	return w, c
}

func SetupRequestBody(c *gin.Context, payload interface{}) {
	reqBodyBytes := new(bytes.Buffer)
	json.NewEncoder(reqBodyBytes).Encode(payload)

	c.Request = &http.Request{
		Body: ioutil.NopCloser(bytes.NewBuffer(reqBodyBytes.Bytes())),
	}
}

t.Run("Update Valid Book", func(t *testing.T) {
		w, c := SetupContext(db)

		payload := models.CreateBookInput{
			Title: "Hermione Granger and The Wibbly Wobbly Timey Wimey Escape",
		}

		SetupRequestBody(c, payload)
		c.Params = []gin.Param{gin.Param{Key: "id", Value: "3"}}

		UpdateBook(c)

		var response models.Book
		err := json.Unmarshal([]byte(w.Body.String()), &response)

		assert.Equal(t, 200, w.Code)
		assert.Equal(t, nil, err)
		assert.Equal(t, payload.Title, response.Title)
})
```

For clarity (and DRY principals), the most important piece of code is the `SetupRequestBody` function which allows us to essentially create the Request with it's body. Doing so allows our function `UpdateBook(c)` that we are testing to pickup the correct `context`, which is the request with the mocked body, headers, etc. For those who've been Googling this just as frantically as I was, I hope this helps!

# Resources

- [Cover Image: Photo by Tomasz Frankowski on Unsplash](https://unsplash.com/photos/kBUfvkbFIoE)
- [Athenaeum](https://github.com/raygervais/Athenaeum)
- [Testing with Golang](https://quii.gitbook.io/learn-go-with-tests/)
- [LogRocket's Tutorial: How To Build a REST API with Golang using Gin and Gorm](https://blog.logrocket.com/how-to-build-a-rest-api-with-golang-using-gin-and-gorm/)
