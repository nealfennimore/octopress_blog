---
layout: post
title: "Putting Octopress on a subdirectory"
date: 2014-08-09 04:20:59 -0400
comments: true
categories: AWS
---

### Create a subdirectory folder

Create a blog folder. We'll upload the whole Octopress blog to this folder.

{% flickr_image 14679011909 b %}

### Modify the _config.yml

You'll more than likely want to get rid of all references to blog in this section, and just put /blog for the root. 

{% flickr_image 14863212104 b %}

Some themes contain a blog folder and then an archives folder. You'll want to move the archives folder up one level and then you can go ahead and delete the blog folder itself.