---
layout: post
title: "Subdomain redirects for AWS buckets"
date: 2014-08-09 03:44:25 -0400
comments: true
categories: AWS
---

### AWS S3 with WWW Subdomain

If you don't have a www subdomain bucket on S3, then anyone who goes to your website with a www prefix will not be able to access the site.

Make a seperate bucket for your site with a www subdomain. Then right-click on the bucket and select it's properties. From there go to the _Static Website Hosting_ tab, and select the _Redirect all requests to another host name_ option. Make sure then that the correct S3 bucket you wish to point to is selected and save.

{% flickr_image 14865451235 b %}

### CNAME the WWW with your domain registrar

You'll have to go to your domain registrar and edit the DNS records. Create a new CNAME and point it to the bucket with the www subdomain.

{% flickr_image 14865122832 b %}

As soon as the DNS records are updated, any request for your website with the www subdomain will redirect to your proper domain.
