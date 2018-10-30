---
title: "Haskell Stack"
layout: post
date: 2018-10-29
headerImage: false
tag:
- testing
- haskell
star: false
category: blog
author: alexchalk
description: Setting up a Haskell Project
---

I am still new enough to coding for getting to grips with a new language's ecosystem
to be slow, confusing and difficult. Haskell is proving to be no exception. Here is a
guide that would have been useful to me yesterday:

---

[Stack][1] is like a sandbox for your haskell project. It lets you define a particular set
of dependency versions (and a particular version of the glasgow haskell compiler) to 
use, and it ensures that only those versions are used whenever your project is built. 

The magic that stack uses to achieve this is versioned resolvers. When you create a
new stack project, it will include a `stack.yaml` file containing a line something
like this: `resolver: lts-12.15`, that is associated with precise versions of pretty
much everything.

You add packages to a project by running `stack build package-i-want`. `build` and 
not `install`, because `install` adds the package's binaries to your global path (we're
using stack to avoid the trouble that brings). 

You also have to list dependencies (and version ranges) in your `package.yaml` file. 
I hope there's a way of doing this in one go without knowing the correct versions,
as it seems like resolvers have the necessary info, but for now, I'm adding them from 
the cli, and leveraging the version info I see in the output to fill in `package.yaml`.

---

Because stack is sandboxing your dependencies, your text editor may not know they
exist, and may complain that you are importing a bunch of missing things. This
is what happened to me, and I solved it in two steps.

First I removed  haskell-platform and installed stack on its own. This was to try and
make my life simpler by removing all global references to things like ghc (included 
with haskell platform). If you installed haskell-platform recently, it includes a 
handy command `uninstall-hs` that can help.

Then I installed `hdevtools` using `stack build --copy-compiler-tool hdevtools`. The
flag ties the package to the specific version of ghc the project is using (as opposed
to the lts) without installing it globally, which means I only have to run it when I 
start working with a new version of ghc. 

This is the recommended approach of the [most helpful blog post][2] I found on
getting started with haskell. The post also acknowledges that having to do this every
time you start working with a new ghc version is kind of sad, but I guess I can
automate by adding it to a simple `stackinit` command that I'll run whenever I'm 
creating a new project.

---

Once I had figured all this out, I turned to adding tests. The literature on this is
confusing, as in the haskell community, people have these clever things called
*property tests*. I mostly ignored them for now (although I did read [this][3]),
and I just added a basic unit test to my code.

I did not figure out how to write a CLI interface for my logic (yet). It would have
involved parsing json from a file and printing the result of the logic as json
output, which is more complicated than I realized in haskell. I decided to save that
challenge for when I understand how to better work with both the IO monad and aeson,
Haskell's main json parser.

The project code is available [on my github][4].

---

Although this felt like the usual painful setup process, I did notice signs of
progress. Most importantly, I recognized that staying clear-headed and methodical is
just as effective a research process as obsessively searching on google using 
different phrasings of a question. 

The point isn't that I found a better approach than constantly rephrasing things on 
google—there was still a lot of that—but rather that I realized I didn't have to 
lose my mind whilst doing it. Finding answers when you don't know the vocabulary of 
a domain is hard, end of story, and a calm approach to the search is at least as 
good as any other. It also lets you take a step back and think of different
approaches to try, or different resources to search (does `stack` have a man page? 
no, oh well...).

Getting started with an ecosystem can be slow and painful, but you can at least learn 
how to deal with that.


[1]: https://docs.haskellstack.org/en/stable/README/
[2]: https://lexi-lambda.github.io/blog/2018/02/10/an-opinionated-guide-to-haskell-in-2018/
[3]: https://www.schoolofhaskell.com/user/pbv/an-introduction-to-quickcheck-testing
[4]: https://github.com/adc17/graham-scan/blob/master/src/Lib.hs
