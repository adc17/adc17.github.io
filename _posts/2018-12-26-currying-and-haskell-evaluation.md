---
title: "Evaluation in Haskell"
layout: post
date: 2018-12-26
headerImage: false
tag:
- haskell
star: false
category: blog
author: alexchalk
description: A clever solution thanks to (I think) currying and lazy evaluation
---

In [Real World Haskell][1], there is a section on folds that contains this
implementation of `foldl` in terms of `foldr`:

```
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f z xs = foldr step id xs z
    where step x g a = g (f a x)
```

As the book warns, this is not trivial to understand, and it inspired a lengthy
[stack overflow post][2] explaining how the function operates.

But the most confusing part for me was a smaller part of the puzzle, and a similar
part was confusing to the user who asked the question:

> foldr's prototype is foldr :: (a -> b -> b) -> b -> [a] -> b, and the first
> parameter is a function which need two parameters, but the step function in the
> myFoldl's implementation uses 3 parameters, I'm complelely confused!

In my case, what confused me was that `foldr`, a function that takes three
parameters, seems to be passed four in the above implementation.

---

I'm not sure I've correctly understood why this works, but I think it's due to a
mixture of currying and lazy evaluation.

Let's inline `step`:

```
myFoldl :: (a -> b -> a) -> a -> [b] -> a    
myFoldl f v xs =
  foldr (\x g -> (\a -> g (f a x))) id xs v
```

I've also added nesting (`\x g -> (\a` instead of `\x g a`) to try
and make it clearer what's going on.

Now let's walk through the function with some test data:

```
myFoldl (+) 0 [1, 2] 
  = foldr step id [1, 2] 0
```

It looks to me like what happens next is Haskell says 

> ok, foldr only takes 3 params, so I'm ignoring that `0` until foldr has finished
> evaluating.

I presume it has also said (slight spoiler alert) 

> I know `foldr step id [1,2]` evaluates to a function that can take 0 as a param, so
> I can definitely go ahead and run this.

Let's ignore the `0` for now and look at the next steps (a reminder that `step`
evaluates to `\x g -> (\a -> g (f a x))`):

```
foldr step id [1, 2]
  = step 1 (foldr step id [2])

foldr step id [2]
  = step 2 (foldr step id [])

foldr step id []
  = id
```

Once the array is empty, the function returns an id, and our recursive stack starts
to unwrap, which is where things get interesting:

```
step 2 id = \a -> id ((+) acc 2)

step 1 (\a -> id ((+) acc 2)) 
  = \a -> (\b -> id ((+) b 2)) ((+) a 1)
```

So we have a function that takes a parameter:

```
\a -> (\b -> id ((+) b 2)) ((+) a 1) 0
  = \a -> id ((+) a 2) 1
```

Once it's applied to our current accumulator, it unwraps a function that takes
another parameter:

```
\a -> id ((+) a 2) 1 
  = 3
```

And we've arrived!

---

Something is happening here that I really like.

Each time a layer of the recursive function is 'unwrapped', the new accumulator value
is left on the outside which is in turn passed as a parameter to the function in
front of it that has also just been unwrapped.

I love that the way haskell evaluates allows for the integer on the right to 'wait'
and change while the function to its left is evaluated.

I suspect this is due to Haskell's lazy evaluation—it's interesting that this aspect
of its implementation allows us to write in such a mathsy manner. 

[1]: http://book.realworldhaskell.org/read/functional-programming.html
[2]: https://stackoverflow.com/questions/6172004/writing-foldl-using-foldr/6172270#6172270
