---
layout: post
title: "Custom Mailchimp AJAX Newsletter Subscribe"
date: 2014-12-29 23:35:16 -0500
comments: true
categories: [Mailchimp, Wordpress]
---

I worked on a recent newsletter subscribe, but I could not find anything I wanted in terms of it being ajaxified with all the errors that the Mailchimp API provides, so I made this. This was for a Wordpress installation.

First, I installed the [Mailchimp PHP API](https://bitbucket.org/mailchimp/mailchimp-api-php) as a **git submodule** into the lib directory.

`git submodule add https://bitbucket.org/mailchimp/mailchimp-api-php.git lib`

{% flickr_image 15956752610 b %}

You'll need your Mailchimp API key and the list ID to which you'll have people subscribe to. Get those and stick them in the wp-config.

``` php wp-config.php
define('MAILCHIMP_APIKEY', 'YOUR_API_KEY');
define('MAILCHIMP_LIST', 'YOUR_LIST_ID');
```

We'll make a *mailchimp-subscribe.php* in our current wordpress theme folder with the following code. We'll require the *wp-config* file to access our mailchimp constants. 

We're catching any exceptions that Mailchimp throws and storing the message in a variable which we'll use later with the ajax call. This will show the user if they are already subscribed to the newsletter and other such errors. Otherwise, we're echoing a 'success' message for our own custom messaging.

``` php mailchimp-subscribe.php
require('../../../wp-config.php');
require('../../../lib/mailchimp/src/Mailchimp.php');
$Mailchimp = new Mailchimp( MAILCHIMP_APIKEY );
$Mailchimp_Lists = new Mailchimp_Lists( $Mailchimp );

try {
  $subscriber = $Mailchimp_Lists->subscribe( MAILCHIMP_LIST, array( 'email' => htmlentities($_POST['email']) ) );
} catch (Exception $e) {
  $error = $e->getMessage();
}

if ( !empty( $subscriber['leid'] ) ) {
  echo "success";
} else if (isset($error)) {
  echo $error;
}
```

The javascript to validate the email and then send the ajax if valid, as well as the messaging along the way. *This uses jQuery.*

``` javascript mailchimp-newsletter.js
(function() {
  'use strict';

  var newsletterAlert = function(message) {
    $('#newsletter-alert').text(message);
  };

  var isValidEmail = function(email) {
    var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
    return pattern.test(email);
  };

  $('#newsletter').on('submit', function(e) {
    var data,
        $form = $(this),
        $email = $form.find('input[type="email"]');

    e.preventDefault();

    if ( !isValidEmail( $email.val() )) {
      newsletterAlert('Invalid Email Address');
    } else {
      newsletterAlert('Subscribing you now...');
      data = $form.serialize();

      $.ajax({
        url: 'PATH_TO_MAILCHIMP-SUBSCRIBE.php',
        type: 'post',
        data: data,
        success: function(msg) {
          if ( msg === 'success') {
            newsletterAlert('Success! Please check your email to confirm.');
            $email.val('');
          } else {
            newsletterAlert( msg );
          }
        },
        error: function(msg) {
          newsletterAlert('Error! ' + msg.statusText);
        }
      });
    }
  });
})();
```

The form itself - foundation was used for this and a lot of the markup is customized, so your results may vary :)

``` html form markup
<form id="newsletter" class="newsletter-signup" action="">
  <div id="newsletter-alert" data-alert class="alert-box info radius">
  </div>

  <div class="row collapse newsletter-signup_container">
    <div class="small-12 columns">
      <label class="tiny-text">Join our Newsletter</label>
    </div>
    <div class="small-8 columns email-input">
      <input name="email" type="email" placeholder="your@email.com" required/>
    </div>
    <div class="small-4 columns submit-input">
      <input type="submit" class="button primary" value="Join"/>
    </div>
  </div>
</form>
```