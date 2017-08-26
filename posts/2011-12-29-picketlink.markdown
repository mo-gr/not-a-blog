---
layout: post
title: "Picketlink"
date: 2011-12-29 17:28
comments: true
tags: 
---
My friend [Michael](https://twitter.com/#!/michaelschuetz) and myself have been hacking some features into a specific version of [picketlink](http://www.jboss.org/picketlink). An update to a newer version was out of the question. We blogged about it over [here](http://blog.akquinet.de/2011/12/26/patching-picketlink-to-support-multiple-ldap-stores/).

<!--more-->

I really like to get my head around existing code bases. Finding my ways through them and fixing or modifing them. I should do that far more often!

Anyway, I don't want to rant too much about picketlink. It works most of the time. But man… there are some code smells in there. If I'm modifying a class somewhere down around line 3500-something, this is a smell. If a class needs more than 1000 LoC, it should probably not be a single class. DRY anyone? Enough of a rant… Our modifications aren't really that much better. [Broken window theory](http://en.wikipedia.org/wiki/Broken_window_theory) at work… 

