---
title: "Taking Responsibility for Architecture"
layout: post
date: 2018-12-31
headerImage: false
tag:
- clojure
- software-design
star: false
category: blog
author: alexchalk
description: Conscious architecture design (and Clojure)
---

I recently had a conversation with my boss that made me rethink my approach to
application development. The conversation went roughly like this:

> Me: On a couple of occasions recently, I've implemented something only to find I
> could have made use of existing logic in the codebase. Is there something missing
> from my approach to navigating a project?

> Boss: I've trained myself to find and understand the architectural context
> surrounding an area where I want to make a change before I start adding a new
> feature.

That was it, more or less. But it was enough to make me realize that I haven't been
thinking consciously about a certain category of architectural decisions required
when working as a software developer.

Here is roughly how I had handled things previously:
- If I haven't already, power through a bunch of tutorials that teach me how to set
  up/use the combination of plugins, databases, other infra needed for the project.
- Write my domain logic as cleanly as possible with tests, respecting basic design
  patterns, etc.
- Hope that nothing in my project setup breaks.

There is a problem with the above—I've introduced a flawed distinction between
'project setup' and 'domain logic'. 

Historically, there are a couple of reasons I think I did this:
- In the Ruby (and to a lesser extent JS) community, the 'setup' part of my code is
  more or less done for me, e.g. if I'm working on a rails app.
- When I was learning to code, my bootcamp needed to teach me to bring value to a
  team in a short period of time. Focussing on how to write clean domain logic was
  an area where I could make progress fairly quickly and fill a gap in the market.
- Domain logic is meant to be distinct from the rest of your code.

The basic problems with these:
- Domain logic should know nothing about the rest of my codebase, but its design
  should still be influenced by the correct usage of fundamental building blocks of
  applications in computer science (queues, databases, servers, etc.).
- Even though domain logic should know nothing about the rest of my codebase, the
  rest of the application still needs to know how/when to call the domain layer.
- When I'm working on a project, non-domain logic is just as much my responsibility
  as domain logic. If it breaks, I still need to fix it.
- If all I have is domain logic, my application can't do anything. To be even a
  half-decent dev I need to be good at everything else too.

---

All these shortcomings were manifesting themselves in a few ways:

#### Debugging

When anything outside of 'my code' broke, I would often just look for
similar stacktraces on stack overflow to find my answer, and because I work in
Javascript, this usually worked. But it meant that my application's infrastructure
remained a black box to me, and that I quickly resorted to trying random things
when stackoverflow didn't help me.

#### Design

I found I was much better at cleaning up other people's code than I was at writing my
own from scratch (because pretty much all non-trivial features require some
understanding of architecture, but refactoring often doesn't). I was also running
into the problem from the start of this post; because I didn't understand
architecture very well, I was failing to find the existing architectural intent in
code that was already there.

#### Side Projects

Where are my side-projects? I mainly spend my spare time learning new languages and
paradigms, which is interesting enough, but it seems strange that I'm not actually
building anything substantial with them....

---

## A Remedy

There is a fix to all this, and I think it could *almost* have worked for me even as
a novice coder (although it probably made better sense for my career to wait until
now to make this change). It requires a fundamental shift in your attitude to an
application through building the following skills:

- Identifying the building blocks of your application, and finding the correct tools
  to use as those building blocks.
- Getting good enough at debugging to fix things when those tools don't play nicely
  together.
- Treating all code in a project as if it is your code; debugging and submitting
  fixes or features for any open source projects when necessary.

(Basically, not using tutorials or big web frameworks to bootstrap your application.)

A community already exists with these kinds of values (although I don't think they
state them explicitly), and it is the clojure community.

---

Frameworks are noticeably absent from the clojure world, as clojurists are into
'decomplecting' things—which roughly means building small units of code united by a
single concept—and combining them together on a project-specific basis. 

This means the clojure community can help us with point two on my 'remedy' list:
debugging conflicts between different libraries. 

This youtube video by [Stuart Halloway][1] contains several helpful pointers that
made me realize how sub-par my own debugging has been. Here's a short summary of the
content in my own words: 

---

Write down all of the below:
- Failure (what didn't succeed, what didn't happen).
- Different hypotheses (explanations based on your limited evidence).
- An experiment to test/trial a hypothesis.
- The observed result of the experiment.
- If observed result falsifies hypothesis, remove it.
- If it supports but doesn't solve hypothesis, refine hypothesis.
- Rinse and repeat until you have a theory—a hypothesis offering valid predictions
  that can be observed.

Misc: 
- The exception likely has nothing to do with where the error message tells us
something broke.
- Read a condensed, complete manual (a bug is an unknown unknown, you need to read
everything).

When building hypotheses:
- State steps you took, what you expected, and what actually happened.
- State a hypothesis that divides the world ideally in half or maybe 10%.
- If your knowledge of the domain is small, you have to be cautious at this step,
  otherwise you could leave out the part of the domain that contains the problem when
  deciding what the 'universe' you're trying to divide is.
- Always better to err towards considering too big a universe than too small a
  universe.

--- 

Following this advice actually involves substantial changes to my current debugging
workflow—no more blindly searching for the error message online, no more trying
something before formulating a hypothesis just because it's easy, and no more
limiting the possible problem domain to the area of the code that I understand best!

I'll be following these steps rigorously to improve my debugging ability from now on.

---

Using clojure can also build some of the muscle for addressing point three on my list
(debugging and potentially fixing open source libraries). Handling 'point two'
situations will involve reading a lot of source code and learning about how the
libraries you're using are built.

The big gap for me is point one. I'm aware that application design isn't the
responsibility of a particular language community, but it would be helpful to have
pointers towards books dealing with architecture, in much the same way as the clojure
site recommends books on the [language itself][2].

And in an ideal world, resources on this topic would exist that couple architecture 
with advice on how to navigate a diverse ecosystem like clojure's and pick the
correct libraries to serve as your application's building blocks. 

In my experience, these are two closely related areas that require too much domain
specific knowledge for a beginner to teach themselves without some guidance. I
suspect the need for this skillset and the current lack of readily available guidance
is the main reason Clojure has a reputation for not being beginner friendly.

The best resource I've found for this so far is Dimitri Sotnikov's [luminus
micro-framework][3] and accompanying book—and it is very helpful—but it is still a
tutorial that doesn't teach you how to pick out libraries by yourself.

---

Given all this, my goal moving forwards is to build a small side-project in clojure,
taking luminus as my base. I think it will help me build at least 2/3rds of the
muscles that I've been neglecting up to this point, and with a bit of luck it will
give me some of the domain-specific knowledge I need to begin tackling the other 1/3
as well.

[1]: https://www.youtube.com/embed/FihU5JxmnBg
[2]: https://clojure.org/community/books
[3]: http://www.luminusweb.net/
