---
title: "DDD and Breaking the Dev Bubble"
layout: post
date: 2018-10-21
headerImage: false
tag:
- software-design
star: false
category: blog
author: alexchalk
description: You need to look beyond software developers when designing software
---

![cover-of-domain-driven-design-by-eric-evans][ddd-cover]{: .center-image }

I'm in the progress of reading [*Domain Driven Design*][ddd-link] by Eric Evans with some co-workers. I'm about
half-way through and wanted to put my main impression so far into words. So here is
my summary of the most important point it makes:

---

It's really important to talk to the non-nerds on your team. You may find it a drag,
but figuring out how to communicate across the nerd boundary is actually a really
interesting challenge, and it should be embraced.

The main reason this communication is so important is that the non-nerds likely know 
a lot more about your users' business domain than you do. If 
you don't incorporate them into your workflow, you're wasting a valuable source of 
expertise.

A thorough understanding of this business domain is important because if you can
capture the most important elements of it in your software's design, you will end up with a
more flexible and versatile application. 

Requirements for an application can change overnight. But however fast-moving the
business world may be, the domain in which your application users are 
working will not change overnight. 

By building your application around a model of that domain, you are building an
application with a core that will let it adapt flexibly to the changing needs of
your users. Because it maps closely to your users' business activities, it will also
map closely to the struggles that they face, and the solutions that resolve them.

But you cannot build a domain model that lets you do this without non-nerds, so talk 
to them all the time—they are really important to our work. If the non-nerds don't
understand you, your application is probably missing something important.

---

This is a summary in my own words, so please assume the 
mistakes are mine and not the author's if it sounds inaccurate.

[ddd-cover]: {{"/assets/images/ddd/blue-book-cover.jpg" | absolute_url}}
[ddd-link]: http://dddcommunity.org/book/evans_2003/
