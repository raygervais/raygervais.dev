---
title: "Writing an Awesome List using the GitHub API"
tags: ["Open Source", "Python", "Go", "Rust"]
date: 2022-06-14
description: "One morning, I decided that I wanted to highlight the importance of a project claiming to be `blazingly fast`" 
Cover: images/charlie-egan-_GuZXst-e1c-unsplash.jpg
---

*One morning, I decided that I wanted to highlight the importance of a project claiming to be `blazingly fast`*

A recent trend you may have noticed on GitHub and other Git-based platforms is the concept of the `[awesome-list](https://github.com/topics/awesome-list)`, and being the cynical one that I can be at times, I wanted to create a list to announce a very important aspect of open source software development: is your program *blazingly fast*. So, I decided to do exactly that:  https://github.com/raygervais/awesome-blazingly-fast

The rest of this article goes over the process and thoughts I had as I implemented a few small script-like programs which would help me with this quest, so let’s dive into it. 

## Retrieving The Datasets using the GitHub API

GitHub provides a free API which allows for pulling of various queries etc with ease; as long as you don’t mind being rate-limited. The limit is 10 queries for non-authenticated API calls, and 30 for those who are using an Application Token. While I was writing out the initial code, being limited to only a few calls didn’t impact the process aside from forcing me to add some error handling logic for when the API responses started to return non-200 statuses: 

```python
if not os.path.exists(path):
	print(
		f"Getting page for language {language} from {year} with query: 'created:>={year}-01-01..{int(year)+1}-01-01 language:{language} {search_query}'"
	)
	repos = get_repositories(
		f"created:{year}-01-01..{year}-12-31 language:{language} {search_query}"
	)

	if repos == None:
		print("GitHub Ratelimit exceeded")
		exit(0)
```

To be kind to both the API and my own logic, I opted to cache the retrieved datasets. The first implementation (which I believe is commented out in the Python API datagen logic) pulled the first 1000 repos per language. GitHub’s restriction to only return 1000 results regardless of being authenticated or not made the dataset and the associated list look anemic compared to other awesome-lists, and I was certain there would be more repos vs what the original dataset implied. So, I rewrote the query and caching logic to query for all repos with the search word `blazingly fast` by every year, and every quarter if the dataset was big enough to be broken down. This allowed me to retrieve over 1000 repos of JavaScript for example which were created between 2020-01-01 and 2020-03-01, and so on. Because of the caching, this also meant that to refresh a newer dataset, it would be best to delete the old first. With that change, our datasets became much more impressive and expansive, so now we have to parse and export our data to our `[README.md](http://README.md)` to complete the project!

## Parsing an Awesome List

Originally, I wrote this entire little project in Python since that was the quickest means-to-an-end, and also to experiment with the data structures at the start. Though the code worked, it really bugged me how *bad* I wrote it. While wearing the smartest thinking-cap that I could find, I opted to do what would be the most logical approach: rewrite it in Rust.

There’s a few reasons I opted for Rust: 

1. I write a lot of Go for work, so I wanted to contrast the experience and design principals between the two purely as an experiment. Recently, I’ve also been running into some post-honeymoon limitations of Go which I’m sure isn’t helped by my lack of enterprise-level experience with the language.
2. How can you develop a non-blazingly-fast parser for an awesome-list about `blazingly fast` repositories?
3. I hadn’t suffered enough headaches that week.

The implementation started off smoothly, the `cargo` ecosystem and rust compiler make getting setup a breeze on Fedora, but the seconds after tell a different headache. See, in retrospect I can admit it was my lack of patience and wanting to get the program finished which made the overall process lackluster:

- The moment I started writing code to iterate over the dataset directory, the borrow checker decided to bully me over a single string (the file name).
- An hour or few later, and I was now being interrogated for following the `serade_json` examples for unmarshalling the json datasets. Not a problem, just a small integration lesson that was easier to resolve than the first.
- By the next weekend when I resumed development, no matter how much Googling I did, I couldn’t figure out how to properly append to a mutable vector the various items.

Most of the problems I encountered derived from my lack of experience using Rust, and more so I imagine my design didn’t jive with how Rust applications are supposed to be written. It was this experience which actually has me considering printing out the [Rust Book](https://doc.rust-lang.org/book/)  and going over it lesson by lesson. Still, my drive to finish the project led me down a different path: rewrite in Go.  Originally, I wanted to experiment with Rust, but I can accept when I’ve lost interest in pushing forward with a specific goal when similar ones can be implemented instead; for those curious I’ve included a snippet of the (terrible) Rust code that was writing.

```rust
fn main() {
    let mut languages: HashMap<String, Vec<Item>> = HashMap::new();

    for file in fs::read_dir("./data").unwrap() {
        let path: path::PathBuf = file.unwrap().path();
        let language = extract_language_from_path(path.clone());

        let dataset = transform_data_to_objects(path);

        if !languages.contains_key(&language) {
            languages
                .insert(
                    language.clone(),
                    dataset.expect("failed to load dataset").items,
                )
                .expect("failed to enter new language into hashmap");
        } else {
            languages
                .get_key_value(&language)
                .expect("failed to retrieve key")
                .1
                .append(&mut dataset.expect("failed to load dataset").items)
        }

        for language in languages {
            println!("{} {}", language.0, language.1.capacity())
        }
    }
}

// returns the language using string parsing, given that all files are formated
// as `languages-repositories-<LANG>-<YEAR>.json`
fn extract_language_from_path(path: path::PathBuf) -> String {
    path.to_str()
        .expect("failed to convert path to string")
        .trim()
        .split("-")
        .nth(2)
        .unwrap()
        .to_string()
}

fn transform_data_to_objects(
    path: path::PathBuf,
) -> Result<LanguageResponse, serde_path_to_error::Error<Error>> {
    let deserializer = &mut serde_json::Deserializer::from_reader(
        fs::File::open(path).expect("failed to open file"),
    );

    serde_path_to_error::deserialize(deserializer)
}

```

I won’t go over the Go implementation since I’m saving that for another blog post, but I will conclude this post with the following: I stopped writing the program in Rust purely because of my own faults, not the language itself. I still look forward to learning and using it in the future, but the timeframe and expectations of this project didn’t align with my original idea to use Rust; simply put Rust demands you write good code, a task of which I’m still learning to do. 

So with that being said, did your repo make the list?


# Resources

- [Cover Image: Photo by Charlie Egan on Unsplash](https://unsplash.com/photos/_GuZXst-e1c)
- [GitHub Repository: Awesome-Blazingly-Fast](https://github.com/raygervais/awesome-blazingly-fast)
