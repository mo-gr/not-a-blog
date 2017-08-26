---
layout: post
title: "Code clouds"
date: 2012-02-12 19:04
comments: true
tags: coding
---

Last year, I've been to [Javazone] and among the many great speakers was
[Kevlin Henney]. His talk was titled [Cool Code](http://vimeo.com/28772428) and if you havn't seen it, I can highly recommend it! (same goes for all talks by Kevlin).

One of the things he mentioned in his talk were word clouds generated
from code to get a good overview of what a programm is about. They
provide no hard facts but a very intersting insight nonetheless. The
following is a word cloud generated from [hibernate-core] with the 100
most common words in the codebase. The bigger the word, the more common
it is.

![Cloud of hibernate-core](http://blog.notadomain.com/images/hibernate-cloud.png)

<!--more-->

On the first glance, one can see, that hibernate deals with lots of
Strings and takes a great deal of work to somehow handle null. Names and
sessions are important to hiberante as well and obviously, hiberante
also deals with transactions.

I really like this kind of visualization of code. It provides no hard facts but it can help detect code smells and project priorities. If *String* is very common, this might be a sign of an insufficient domain model. Maybe a few more classes should be introduced. Same goes for *Object*. In general, a code cloud should talk about the domain of the programm. About customers, orders and the like. It should not talk about implementation details like Strings or booleans. (Since [hibernate-core] is a general library, it might be ok, that transactions and sessions are not the primary words but Strings and Objects - although I somehow doubt it). Use code clouds as an additional datapoint, don't rely to heavily on them and they might turn out to be a useful little tool in your analysis box.

After [Javazone], I
tried to create code clouds for the projects, I was working on. However I
couldn't find a good tool. [Wordle] generates nice clouds, but it works
only online. I am not so comfortable with uploading my complete
codebase of customer projects to some website. So [Wordle] was out of
the game.
Apparently there were a few Windows tools, but I didn't check them out.
But the idea of code clouds stuck with me.

Then a few days ago, I read a post on [hacker news] about [d3-cloud] by
[Jason Davies]. [d3-cloud] is a layout plugin for the amazing JavaScript
data visualization engine [d3]. This was all I needed.

So I started playing around with it a bit and created [cloudserver]. The
above cloud of hibernate-core was created with it.

Since I wanted to get into [d3] anyway, this was a good start. And
if I am working in JavaScript anyway, why not try it in [node.js]? And
if I am working in [node.js], why not just do it in [CoffeeScript]?

So [cloudserver] got a bit of a playground of technologies. It is mostly
written in [CoffeeScript]. It reads in source files, cleans them up a
bit and counts each word. After it is done processing all files, it
brings them in a [d3-cloud]-friendly format and starts a local [node.js]
webserver. This server serves a small html file that contains the [d3]
bootstrap code and generates the cloud.

I tried to keep it mostly language agnostic with a pluggable system to
configure it to specific languages. Currenlty it only supports Java, but
it should be fairly easy to make langauge configurations for other
languages.

I have lots of ideas on how to improve [cloudserver], like stripping
comments. And it is surely not bugfree. Since this is my
first contact with [node.js] and I am still not very mature in
[CoffeeScript], I assume there are lots of rookie-mistakes lurking
around.

I plan to write up my impressions of [node.js] and [CoffeeScript] in
seperate posts.

If you used [cloudserver], have questions or ideas, I would love to hear
from you! I would also love to show you some more clouds, but I
currently only have customer-projects with interesting code bases
around - and I am not comfortable with presenting them here.

[Kevlin Henney]: http://twitter.com/#!/kevlinhenney
[hibernate-core]: http://www.hibernate.org/
[Javazone]: http://jz11.java.no/news.html
[Wordle]: http://www.wordle.net/
[hacker news]: http://news.ycombinator.com/
[d3-cloud]: https://github.com/jasondavies/d3-cloud
[Jason Daview]: http://www.jasondavies.com
[d3]: http://mbostock.github.com/d3/
[cloudserver]: https://github.com/mo-gr/Cloudserver
[node.js]: http://nodejs.org
[CoffeeScript]: http://coffeescript.org/
