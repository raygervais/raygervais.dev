---
title: "Leveraging Functional Programming for Data Parsing"
tags:
  [
    "Lessons",
    "Functional Programming",
    "Software Development",
    "Open Source",
    "Python",
  ]
draft: false
date: 2020-02-05
images: ["./images/pawel-czerwinski-lt891TUy6iw-unsplash.jpg"]
description: "For much of January, a key deliverable of the team was to parse and send data between critical systems; a simple enough task really when worded like that. The complexity arose from the included business requirements and edge cases which drove the sprint estimate points from a capable `3` to a concerning `8`, knowing that only a single developer would be focused on this for 100% of their sprint until a POC to be demonstrated came from their efforts. Only then, could the team help carry the torch and make decisions based on the challenges encountered."
---

_An Excerpt from the Life of a Software Delivery Team, and Whatever Ray's Doing..._

> In all seriousness, this is still a learning subject for yours truly. Facts and opinions may be wrong. You've been warned.

## **\_\_init\_\_**(self, premise):

For much of January, a key deliverable of the team was to parse and send data between critical systems; a simple enough task really when worded like that. The complexity arose from the included business requirements and edge cases which drove the sprint estimate points from a capable `3` to a concerning `8`, knowing that only a single developer would be focused on this for 100% of their sprint until a POC to be demonstrated came from their efforts. Only then, could the team help carry the torch and make decisions based on the challenges encountered.

Fast-forward to the last week of January, every task and module that's been committed to has been developed and tested, all that can go well is (and of course, the opposite too). Business requirements are updated to reflect a few new use-cases raised by the tests and developers, and we only have few days to make the modifications within the time-window. Luckily, this dev (me!) wrote the program in a functional matter (more to come on this in later posts, I promise!) after becoming obsessed with learning more on the development method. Gene Kim's _The Unicorn project_ was a great introduction to the concept, with the main character advocating for the testable, clean mechanics which make up Functional Programming in a manor which had [me](https://twitter.com/_RayGervais/status/1222248609439199235) downloading [Pluralsight](https://www.pluralsight.com/) Courses for a weekend of further learning. But what does writing the program in such a way mean with the requirements update?

## Base Code

For this post, let's use the following example as our code base (sans documentation / tests for brevity), and below are the business requirements and API examples.

**Code**

```python
class User:
    id: int
    name: str
    username: str
    email: str
    address: Address
    phone: str
    website: str
    company: Company

    def __init__(self, id: int, name: str,
                  username: str, email: str,
                  address: Address, phone: str,
                  website: str, company: Company) -> None:
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company


# fx [a] -> [b]
def create_user_feed(users):
    users_feed = []
    for user in users:
        users_feed.push(format_user(user))

    return users_feed

# fx a -> b
def format_user(user):
    # Format Id to Business Standard Requirement
    user_id = format_user_id(user)

    # Required has_site field
    has_site = user_has_site(user)

    # Required has_phone field
    has_phone = user_has_phone(user)

    return {
      username: user.username,
      name: user.name,
      id: user_id,
      email: user.email
      website: has_site,
      phone: has_phone
      company: company
    }

# fx a -> b
def format_user_id(user) -> String:
    return user.username + "_" + user.id

# fx a -> b
def user_has_site(user) -> String:
    return user.website if user.website != None else "N/A"

# fx a -> b
def user_has_site(user) -> String:
    return user.phone if user.phone != None else "N/A"
```

**API**

```json
[
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "",
    "website": "",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },
  {
    "id": 2,
    "name": "Ervin Howell",
    "username": "Antonette",
    "email": "Shanna@melissa.tv",
    "address": {
      "street": "Victor Plains",
      "suite": "Suite 879",
      "city": "Wisokyburgh",
      "zipcode": "90566-7771",
      "geo": {
        "lat": "-43.9509",
        "lng": "-34.4618"
      }
    },
    "phone": "010-692-6593 x09125",
    "website": "anastasia.net",
    "company": {
      "name": "Deckow-Crist",
      "catchPhrase": "Proactive didactic contingency",
      "bs": "synergize scalable supply-chains"
    }
  },
  {
    "id": 3,
    "name": "Clementine Bauch",
    "username": "Samantha",
    "email": "Nathan@yesenia.net",
    "address": {
      "street": "Douglas Extension",
      "suite": "Suite 847",
      "city": "McKenziehaven",
      "zipcode": "59590-4157",
      "geo": {
        "lat": "-68.6102",
        "lng": "-47.0653"
      }
    },
    "phone": "",
    "website": "ramiro.info",
    "company": {
      "name": "Romaguera-Jacobson",
      "catchPhrase": "Face to face bifurcated interface",
      "bs": "e-enable strategic applications"
    }
  },
  {
    "id": 4,
    "name": "Patricia Lebsack",
    "username": "Karianne",
    "email": "Julianne.OConner@kory.org",
    "address": {
      "street": "Hoeger Mall",
      "suite": "Apt. 692",
      "city": "South Elvis",
      "zipcode": "53919-4257",
      "geo": {
        "lat": "29.4572",
        "lng": "-164.2990"
      }
    },
    "phone": "493-170-9623 x156",
    "website": "kale.biz",
    "company": {
      "name": "Robel-Corkery",
      "catchPhrase": "Multi-tiered zero tolerance productivity",
      "bs": "transition cutting-edge web services"
    }
  },
  {
    "id": 5,
    "name": "Chelsey Dietrich",
    "username": "Kamren",
    "email": "Lucio_Hettinger@annie.ca",
    "address": {
      "street": "Skiles Walks",
      "suite": "Suite 351",
      "city": "Roscoeview",
      "zipcode": "33263",
      "geo": {
        "lat": "-31.8129",
        "lng": "62.5342"
      }
    },
    "phone": "(254)954-1289",
    "website": "",
    "company": {
      "name": "Keebler LLC",
      "catchPhrase": "User-centric fault-tolerant solution",
      "bs": "revolutionize end-to-end systems"
    }
  },
...
```

**Business Requirements**

```md
- Must indicate with a "N/A" if field does not have a phone number
- Must indicate with a "N/A" if field does not have a website
- All UserIds must follow this format: `username_id`
```

### Adding More Rules

Pretty simple requirements right? Let's say we now add the following requirements:

- If a user row's website and phone fields are empty, do not include in data set
- If a user's is employed by `Deckow-Crist`, do not include in data set

## Why I Wrote The Code in Such a Way

Well, these are pretty simple too with the way the application was written! You see, one of the key concepts of writing in a functional style that I tried (and hopefully didn't fail miserably) to demonstrate are immutability and single responsibility functions. See, none of the functions alter the state of objects passed in, which allows us to trace the data transformations in a before/after pattern simply by comparing two variables for example. Furthermore, functions are broken down to their utmost highest level of granularity, ensuring that they cover a singular logic requirement and can be tested for said without expecting other behaviors.

An easier, although harder way to predict behaviors implementation of the above would look as the following (_bad example, I'm aware as I write this just how simple the function is in contrast to enterprise-level applications, but you have to just go along with it ok?_):

```python
# fx [a] -> [b]
def create_user_feed(self, users):
    users_feed = []
    for user in users:
        user.id = user.username + "_" + user.id

        if user.website == None:
          user.website = "N/A"

        if user.phone == None:
          user.phone = "N/A"

        users_feed.push(format_user(user))

    return users_feed
```

By writing the application in such a way as previous, adding the new business requirements can be done like so:

```python
# fx [a] -> [a]
def filter_invalid_users(users) -> [User]:
  return filter(filter_invalid_user, users)

# fx a -> b
def filter_invalid_user(user) -> Bool:
  return user.website != None and user.phone != None

# fx [a] -> [a]
def filter_companys_for_users(users) -> [User]:
  return filter(filter_company_for_user, users)

# fx b -> c
def filter_company_for_user(user) -> Bool:
  return "Decklow-Crist" not in user.company.name
```

You may be wondering, what's with the `# fx [a] -> [a]` style comments, to which I say: great question! Though unsure if it's valid, I had saw it in one of the videos included in the references below which explains that, by writing these input / return types, we are able to see the object transformations between input and output. This becomes more important of a programming idea with dynamic languages such as Ruby and Python whose variables can change on a dime if you're not careful.

Finally, we can rewrite the `create_users_feed` function to reflect below.

```python
# fx [a] -> [a]
def create_user_feed(users):
  valid_phone_website_users = filter_invalid_users(users)
  valid_company_users = filer_companys_for_users(valid_phone_website_users)

  return map(format_user, valid_company_users)
```

The final code appears as:

```python
class User:
    id: int
    name: str
    username: str
    email: str
    address: Address
    phone: str
    website: str
    company: Company

    def __init__(self, id: int, name: str,
                  username: str, email: str,
                  address: Address, phone: str,
                  website: str, company: Company) -> None:
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company

# fx [a] -> [b]
def create_user_feed(users):
    valid_phone_website_users = filter_invalid_users(users)
    valid_company_users = filer_companies_for_users(valid_phone_website_users)

    return map(format_user, valid_company_users)

# fx a -> b
def format_user(user):
    return {
      username: user.username,
      name: user.name,
      id: format_user_id(user),
      email: user.email
      website: user_has_site(user),
      phone: user_has_phone(user)
      company: company
    }

# fx a -> b
def format_user_id(user) -> String:
    return user.username + "_" + user.id

# fx a -> b
def user_has_site(user) -> String:
    return user.website if user.website != None else "N/A"

# fx a -> b
def user_has_site(user) -> String:
    return user.phone if user.phone != None else "N/A"

# fx [a] -> [a]
def filter_invalid_users(users) -> [User]:
  return filter(filter_invalid_user, users)

# fx a -> b
def filter_invalid_user(user) -> Bool:
  return user.website != None and user.phone != None

# fx [a] -> [a]
def filter_companies_for_users(users) -> [User]:
  return filter(filter_company_for_user, users)

# fx b -> c
def filter_company_for_user(user) -> Bool:
  return "Decklow-Crist" not in user.company.name
```

Doesn't this seem cleaner? In my opinion, the verbosity and reduction of fractions to singular responsibilities enables for a much greater depth of testing and decoupling! It's through this architecture that my recent work was able to have 100% test coverage and still be updated a few days prior to production deployment with confidence. As requirements change, I knew that my tests would make clear if the contracts and scope changed beyond the expected, and thus they'd be updated and corrected based on the new expectations. It's a nice development style that I hope to learn more of and talk about.

## References

- [Cover Image: Photo by Paweł Czerwiński on Unsplash](https://unsplash.com/photos/lt891TUy6iw)
- [Video: Why Isn't Functional Programming The Norm](https://www.youtube.com/watch?v=QyJZzq0v7Z4)
- [Video: Functional Programming in 40 Minutes](https://www.youtube.com/watch?v=0if71HOyVjY)
- [Declarative vs Imperative Functions](https://tylermcginnis.com/imperative-vs-declarative-programming/)
- [Single Responsibility Principals for Functional Programming](https://lispcast.com/single-responsibility-principle-for-functional-programming/)
