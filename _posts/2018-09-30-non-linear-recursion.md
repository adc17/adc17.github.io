---
title: "Non-Linear Recursion"
layout: post
date: 2016-09-30
headerImage: false
tag:
- recursion
- haskell
star: false
category: blog
author: alexchalk
description: Thinking differently about recursive functions
---

I've been implementing the Graham Scan algorithm as I work
through [Real World Haskell][rwh-chapter]. Wikipedia does a good job of 
explaining the algorithm if you're interested in [learning more][wiki-gsa].


The part of the exercise I found the most illuminating was also the part
that I couldn't figure out myself. I could tell that a recursive pattern
was what I was missing, but there was a quirk to the pattern 
that was defeating me, and that has often defeated me in the past: it
needed to be what I'll (probably inaccurately) call 'non-linear'.


To explain what I mean, I'll give an example of a recursive function I'd
consider 'linear':

```haskell
incMap :: [Int] -> [Int]
incMap xs
  | xs == [] = []
  | otherwise = (succ $ head xs) : (incMap $ tail xs)
```

This function `incMap` processes an array of numbers, incrementing them 
in turn. It is 'linear' because once it has processed a number, 
it can forget about it—all it needs to keep track of are the result
it is building (the 'result so far'), and the numbers that it still
has to process. 


The problem I was working on today is not like that—there are occasions
when the graham scan algorithm requires revisiting values that have
already been processed. I found a [successful solution][hs-wiki-gsa] 
to this requirement on the Haskell wiki that was illuminating for me.


The function `scan` checks the direction formed by three points
on a graph. The points are stored in an array, and all the points in the
array need to be processed, 3 at a time (i.e. indexes [0, 1, 2], 
[1, 2, 3], [2, 3, 4], etc.). 

```haskell
scan :: [Point] -> [Point] -> [Point]
scan (x:xs) (y:z:rest) = case getDirection x y z of
  TurnRight -> scan xs (x:z:rest)
  Straight -> scan (x:xs) (z:rest)
  TurnLeft -> scan (y:x:xs) (z:rest)

scan xs [z] = z : xs
```

Let's say we're checking indexes 2, 3, and 4 of the initial array. 
If the points form a left turn, `scan` simply moves onto the next three
points (save 2 and 3, check [3, 4, 5]). If they form a 
straight line, `scan` drops the centre point, and moves onto the next three 
points (save 2, discard 3, check [2, 4, 5]. If they form a 
right turn, then things get more complicated. 


`scan` drops the centre point, just like in the straight line scenario, 
but then the function has to 'backtrack', and check the direction formed by
points that were not all involved in the current check, i.e. points 1,
2, and 4. If they form a right turn, 2 is dropped, and 0, 1, and 4 need
to be checked, and so on. 


So we need a way to maintain access to indexes that have
already been processed and saved, even if we're not using them in our
current iteration of the function.


By passing two arrays to the function and utilising Haskell's
destructuring syntax, `scan` solves this issue elegantly. The first
array can loosely be thought of as the result array, only it's more of a
'work in progress' result. Using destructuring, `scan` is able to lift
values out of the result array, and place them back in the 'todo'
array for re-processing. `scan` also re-processes the head of the result
array on each iteration.


Applying the 'done/todo' distinction too rigidly to the data structures
I was passing to this function was a big part of why I couldn't find the
solution—I look forward to considering these structures more
flexibly when I next get stuck on a similar problem, and figuring out the
solution myself!


I did manage to implement all the other pieces of the algorithm myself,
and I will link to the project in full once I've figured out how stack,
testing, and parsing from/printing to the CLI work in Haskell.
Incidentally, that will probably be the topic of my next blog post.


[rwh-chapter]: http://book.realworldhaskell.org/read/defining-types-streamlining-functions.html
[wiki-gsa]: https://en.wikipedia.org/wiki/Graham_scan
[hs-wiki-gsa]: https://wiki.haskell.org/Graham_Scan_Implementation
