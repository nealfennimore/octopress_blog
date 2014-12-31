---
layout: post
title: "Hosting Octopress automatically with AWS S3"
date: 2014-08-09 02:13:15 -0400
comments: true
categories: AWS
---

###Initial Setup

You’ll need to install [GPG tools](https://gpgtools.org/gpgsuite.html) suite for this. Get that and then come back.

Make sure you also have [homebrew](http://brew.sh/) cause you’ll need it soon.

###Now for AWS

Log into your AWS account, or make one if you don’t already. Log in and go to the IAM section and then create an access key for a user. **_Make sure you download the secret key file_**. You’ll need it to install s3cmd, as it will need your AWS Secret Key.

You’ll also want to create a bucket in S3. Make sure it is the same name as your domain name you’re going to use (i.e. my bucket was named neal.codes as this domain is neal.codes).

``` bash Install s3cmd and configure prompt
brew install s3cmd
s3cmd --configure

Enter new values or accept defaults in brackets with Enter.
Refer to user manual for detailed description of all options.

Access key and Secret key are your identifiers for Amazon S3
Access Key: accesskey
Secret Key: secretkey

Encryption password is used to protect your files from reading
by unauthorized persons while in transfer to S3
Encryption password: makeyourownpassword
Path to GPG program [/usr/local/bin/gpg]:

When using secure HTTPS protocol all communication with Amazon S3
servers is protected from 3rd party eavesdropping. This method is
slower than plain HTTP and can't be used if you're behind a proxy
Use HTTPS protocol [No]: yes

New settings:
  Access Key: accesskey
  Secret Key: secretkey
  Encryption password: makeyourownpassword
  Path to GPG program: /usr/local/bin/gpg
  Use HTTPS protocol: True
  HTTP Proxy server name:
  HTTP Proxy server port: 0

Test access with supplied credentials? [Y/n] y
Please wait, attempting to list all buckets...
Success. Your access key and secret key worked fine :-)

Now verifying that encryption works...
Success. Encryption and decryption worked fine :-)

Save settings? [y/N] y
Configuration saved to '/Users/neal/.s3cfg'
```

Now add all of the below to your Rakefile in your Octopress root. You’ll be able to auto-sync your local Octopress blog with the S3 bucket using the `rake s3` command thereafter.

``` ruby Rakefile
# change deploy_default - add s3_bucket
deploy_default = "s3"
s3_bucket      = "neal.codes/blog" # My bucket name and domain name // notice folder name for subdirectory
```

``` ruby Rakefile
# Add this somewhere, probably in the deploy section
desc "Deploy website to s3"
task :s3 do
  exclude = ""
  if File.exists?('./s3-exclude')
    exclude = "--exclude-from '#{File.expand_path('./s3-exclude')}'"
  end
  puts "## Deploying website via s3cmd"
  ok_failed system("s3cmd sync --guess-mime-type --acl-public #{exclude} #{"--delete-removed" } #{public_dir}/ s3://#{s3_bucket}/")
end
```

###Getting your domain to point to AWS

You’ll have to mess with whereever you bought the domain from. Edit the DNS records for your domain, and then add an CNAME record with a value of **yourbucket.name.s3-website-us-east-1.amazonaws.com** or something similar. Mine is **neal.codes.s3-website-us-east-1.amazonaws.com**.

That’s all folks.