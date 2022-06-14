---
title: "An Introduction to Git Worktrees"
tags: ["Open Source"]
date: 2022-06-14
description: "For the first time in years, I managed to break my Fedora installation to the point where I thought, “hey, why not install from scratch and start fresh?” So I did." 
Cover: images/karsten-wurth-7BjhtdogU3A-unsplash.jpg
---

*For when experience leads you having a PTSD-like relationship with the command `git stash`*

Let me give you a scenario, and I’ll let you tell me if it’s one which you’ve encountered before. Simple deal I think, so let’s get on with painting a picture:

> It’s late on a Monday night, you’re in the zone working on a pivotal feature for the sprint which touches ten files to handle parsing a new data format for your ingestion platform. It’s all making sense. This will resolve the weekly data upload error that your QA has been harping about; they mean well you know. You mistakenly check Slack after hearing a notification, dragging you out of your `1`s and `0`s. It appears there’s a critical bug which took out the latest production instance, which was built from `release-01.22-stable`, a branch that isn’t as stable as the team hoped it would be. They irony doesn’t escape you, but no time to laugh now.
> 

In this scenario, what would you do if you were the developer who had to investigate the bug in the code? More so, how would you approach your investigation? For many, including myself, it would look something like this: 

 

```bash
> git reset src/main.rs lib/parser.rs 
> git stash -m "feat-ingest: please remember where you left off, modifying file ingest.rs"
> git fetch
> git checkout origin/release-01.22-stable
```

> It’s a Monday, of course this would happen. After a few hours debugging and reproducing the issue, you implement a fix which passes all Pipeline tests and fixes the main problem -a band-aid this fix cannot be. The rest of the dev team is joining you online and reviewing the fix; `WTfs` can be heard over the huddle. pic related.
> 
> 
> ![Code Quailty Measurement: WTFs per Minute](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/1acda958-a71d-4d5c-8975-51ab74893698/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220614%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220614T135334Z&X-Amz-Expires=86400&X-Amz-Signature=2b7931394f540312878b313202c28f80a605f469afebdbb98fff5509daac57e6&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)
> 

Let’s depart from reality and assume that the fix was merged within the first commit, no revisions were needed. You unleashed your inner 10x developer for the first time, but be careful with using such power. You return to your other branch:

```bash
git checkout feat-ingest
git stash pop
cargo build
```

Only, it doesn’t build. 

After some battling with your memory and recent actions, you try to remember what changes are needed to the now-reset files to get you back into the build-test-build flow you started in. After 20 minutes or so, you’re back to where you previously before you put on the firefighter hat. 

Surely there must be a better process? 

## The Better Approach!

What if I mentioned there was a better approach? Enter the `git worktree`, which enables you to have work with as many branches and their unique setups as you’d want, all without any additional tools or dependencies! For the TLDR, git worktrees allow for folders to be created which associate to a specific branch, so you could have `master`, `feat-ingest` and `release-01.22-stable` all checked out locally for when they’re needed. If you’re curious, keep reading oh adventurer, and we’ll explore git worktrees together.

I first discovered the concept of Git Worktrees while watching [ThePrimeagen’s explanation](https://www.youtube.com/watch?v=2uEqYw-N8uE), explaining how all this time he and software developers in whole were approaching how we use git wrong. I, being curious and also easily distracted by new and shiny, decided to try using worktrees on a few personal projects before I’d take it to the team at work. Here’s a rundown of common commands, and how worktrees work. 

[Opensource.com](http://Opensource.com) describes Git Worktrees as,

> A Git worktree is a linked copy of your Git repository, allowing you to have multiple branches checked out at a time. A worktree has a separate path from your main working copy, but it can be in a different state and on a different branch. The advantage of a new worktree in Git is that you can make a change unrelated to your current task, commit the change, and then merge it at a later date, all without disturbing your current work environment.
> 

But, what does that look like?

```bash
# clone the `bare` repository
git clone --bare <URL> 
cd <project_name>

# create worktrees for any branches you want locally
git worktree add master
git worktree add feat-ingest

# move to your development branch
cd feat-ingest

# do your development magic!
emacs .
```

### Why the `--bare` argument

[git-scm describes](https://git-scm.com/docs/git-clone) the bare argument as, 

> Make a *bare* Git repository.  That is, instead of creating `<directory>` and placing the administrative files in `<directory>/.git`, make the `<directory>` itself the `$GIT_DIR`. This obviously implies the `--no-checkout` because there is nowhere to check out the working tree. Also the branch heads at the remote are copied directly to corresponding local branch heads, without mapping them to `refs/remotes/origin/`.  When this option is used, neither remote-tracking branches nor the related configuration variables are created.
> 

So, how could you utilize this in the scenario we started this post with? 

```bash
# from the root of the cloned repository
git worktree add release-1.22-stable

# open up the branch in your editor
code release-1.22-stable

# do your fixes, hacker voodo, commit the changes
...

# now go back to your flow!
code feat-ingest
```

Because branches exist as folders within your repository, it’s as easy as switching folders when you want to change your current working branch. Worktrees come with other useful helper commands as well, which [opensource.com](http://opensource.com) explains better in the section below.

### Listing of Active Worktrees

```bash
git worktree list
/home/ray/code/myproject  15fca84 [dev]
/home/ray/code/hotfix     09e585d [master]
```

### Removing Worktrees

```bash
$ git worktree remove hotfix
$ git worktree list
/home/ray/code/myproject  15fca84 [dev]
```

### Moving the location of a Worktree

```bash
$ mkdir ~/Temp
$ git worktree move hotfix ~/Temp
$ git worktree list
/home/seth/code/myproject  15fca84 [dev]
/home/seth/Temp/hotfix     09e585d [master]
```

## Common Usecases Improved by Worktrees

[Andrew Lock’s post](https://andrewlock.net/working-on-two-git-branches-at-once-with-git-worktree/) describes some common usecases, which realistically imply worktrees being a replacement for `git checkout` in most scenarios where you’re interacting with multiple branches: 

- Debugging a collegues branch
- Bug fixes
- Working on multiple tickets in parallel on separate branches

# Resources

- [https://www.youtube.com/watch?v=2uEqYw-N8uE](https://www.youtube.com/watch?v=2uEqYw-N8uE)
- [https://git-scm.com/docs/git-worktree](https://git-scm.com/docs/git-worktree)
- [https://opensource.com/article/21/4/git-worktree](https://opensource.com/article/21/4/git-worktree)
- [https://andrewlock.net/working-on-two-git-branches-at-once-with-git-worktree/](https://andrewlock.net/working-on-two-git-branches-at-once-with-git-worktree/)
- [https://williamdurand.fr/2021/05/05/an-introduction-to-git-worktree/](https://williamdurand.fr/2021/05/05/an-introduction-to-git-worktree/)