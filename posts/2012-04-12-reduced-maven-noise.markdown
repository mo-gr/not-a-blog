---
layout: post
title: "Reduced maven noise"
date: 2012-04-12 11:52
comments: true
external-url: http://pveentjer.wordpress.com/2012/04/07/maven-reducing-test-output/
tags: java,coding
---
I stumbled upon this quick post by [Peter Veentjer](pv) about how to reduce maven test output. Highly recommended. Gives you the ability back to actually parse the output of maven by reducing the noise generated by tests to a minimum. Basically just add

    <redirectTestOutputToFile>true</redirectTestOutputToFile>

to your surefire config. 

[pv]: http://pveentjer.wordpress.com/2012/04/07/maven-reducing-test-output/
