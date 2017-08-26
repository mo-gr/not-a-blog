---
layout: post
title: "ssh housekeeping"
date: 2011-12-04 21:46
comments: true
tags: coding
---
*Disclaimer: This post is primarily aimed at myself. No information here that can't be found via google.*

I've been using the same ssh public/private key for about 5 years and probably a minimum of three OS reinstalls.

Since that time, my personal password policy has changed. Gone are the times of easy, memorable passwords. I use [1Password](https://agilebits.com/onepassword) to manage all my passwords.

Since I have no reason to believe that my private key has been compromised, I thought it might be time to change the password on the key.

To change the password on an ssh private key, use the ssh-keygen command, that you probably already used to create the key in the first place.

	$ ssh-keygen -p -f ~/.ssh/id_rsa

The lower-case p-param will ask ssh-keygen to change the passphrase of the file that is passed as an argument to -f.

On that account, I also changed the hostname in the public part of the key to reflect my current machine. Just edit ~/.ssh/id_rsa.pub in a text editor and change the hostname at the end of the key. It is just an identifier after all.
