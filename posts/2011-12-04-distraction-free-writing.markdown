---
layout: post
title: "Distraction free writing"
date: 2011-12-04 22:01
comments: true
categories: 
---

I've never been a big fan of fat, bloaty WYSIWYMG text editors. Some people call them word processors. Most of my longer texts in university have been written in LaTeX/vim. This also includes my diploma thesis. Every longer experience with the so called word processors made me hate them even more. I like the appeal of writing - and basically thinking - in plain text files. Having a confusing UI and lots of inconsistend formatting in the document is very annoying to me. But for everyday work, LaTeX is just too much of an overhead and, more often than not, feels arcane.

<!--more-->

Recently, [John Gruber's](http://daringfireball.net/projects/markdown/) markdown has sparked up everywhere. I really like it and since it is used in [octopress](http://octopress.org/) I have to use it anyway. It basically solves the same problem, that LaTeX overengineers for me. It gives me a way to write plain text with some lightweight, natural markup for the occasional link or *emphasized* word. It is an awesome combo for most of the things I write.

And while I really like to use vim, especially the awesome [MacVim](http://code.google.com/p/macvim/), all the bells and whistles of it feel a bit too much when all I want to do is write a simple blog post. Apprently I am not the only one, thinking like that. There are a few new texteditors that offer not much more than plain text editing. Probably the biggest two are [WriteRoom](http://www.hogbaysoftware.com/products/writeroom) and [iA Writer](http://www.iawriter.com/). I havn't yet picked my personal favorite.

I like the inline-markdown preview/support of iA Writer and the iCloud support. But I am not so sure about the total lack of configurablility. iA Writer lets you configure nothing. WriteRoom lets you pick your own colors and fonts. I am using the Solarized Dark Theme from the Ethan Schoonovers [solarized](http://ethanschoonover.com/solarized) project, which I am currently using about everywhere. It looks something like this:

{% img https://img.skitch.com/20111204-jyx7tgkg65ps8qm4pp6dg417x2.jpg %}

A screenshot of iA makes no really sense as it always looks the same. Just head over to their [site](http://www.iawriter.com/) to see how it looks.

Since WriteRoom doesn't support markdown, I use it in combination with [Marked](http://markedapp.com/), a simple markdown previewer. Marked doesn't support all octopress extensions, but it is very lightweight and works well for basic previews. Another neat feature of Marked is the option to export the formatted text to a PDF or copy the underlying HTML.

Time will tell, which one of the two (if any) will end up beeing used by me in the long run. I have the slight feeling that it might be iA Writer for the auto markdown. Although I would miss the solarized look.

One final tip for all three apps: Add the following lines to your .bashrc or .profile:

	alias md="open -a Marked"
	alias wr="open -a WriteRoom"
	alias ia="open -a iA\ Writer"
	
This will allow you to open any file in the corresponding application directly from the commandline.