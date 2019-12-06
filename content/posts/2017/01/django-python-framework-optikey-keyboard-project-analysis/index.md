---
title: "Django Python Framework & OptiKey Keyboard Project Analysis"
date: "2017-01-13"
---

SPO600 Week 1 Deliverables

# [Django Open Source Python Framework](https://www.djangoproject.com/)

> "Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design. Thanks for checking it out."

**License Type:** BSD-3-Clause **Contribution Method:** Mailing list, IRC, Ticket tracker / Pull Requests

## Patch Review

This [pull request](https://github.com/django/django/commit/32265361279b3316f5bce8efa71f2049409461e3) was created by contributor timgrahm, who made 19 additions and 10 deletions to the tests/auth\_tests/test\_templates.py file.

Django uses Trac for managing the code base. This is a ticketing system which allows for open tickets to be reviewed, accepted and then checked into the code base assuming it passes inspection. If the ticket fails for a variety of common reasons such as duplicate, wontfix, invalid, needsinfo, worksforme or other, then the open ticket is closed and rejected. This is a good system for code review, but entirely relies on the developer community (which largely are volunteers) to keep up to date with many of the changes from multiple patches at once to ensure that updates do not break recently approved updates.

# [OptiKey Assertive On Screen Keyboard](https://github.com/OptiKey/OptiKey)

> "OptiKey is an assistive on-screen keyboard which runs on Windows. It is designed to be used with an eye-tracking device to assist with keyboard and mouse control for those living with motor and speech limitations, such as Amyotrophic Lateral Sclerosis (ALS) / Motor Neuron Disease (MND)."

**License Type:** GPL-3.0 **Contribution Method:** Pull Requests, Email

## Patch Review

This [pull request](https://github.com/OptiKey/OptiKey/pull/293) was created by contributor Razzeee, who changed seven files with 27 additions adn 176 deletions.

OptiKey relies on Email and Pull Requests from contributors through GitHub for code commits. JuliusSweetland originally started this as his way of giving back to the community, while providing those with ALS or MND an updated way to communicate. Though a hobby, Julius has found many collaborators who've helped him translate, optimize and increase the functionauilty while still being accessible to many. Because it's managed solely by Julius, one downside to this system is that progression of the application is based on his pace. Being the sole reviewer of each patch, the project stalls if he cannot get to the patch reviews in a timely manner.
