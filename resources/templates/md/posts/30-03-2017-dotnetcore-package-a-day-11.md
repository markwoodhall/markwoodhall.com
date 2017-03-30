{:title  "MailKit - dotnet core package a day - 11"
 :layout :post
 :date   "30-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "MailKit" "smtp"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [MailKit](https://github.com/jstedfast/MailKit).

> MailKit is a cross-platform mail client library built on top of [MimeKit](https://github.com/jstedfast/MimeKit).
>
> The main goal of this project is to provide the .NET world with robust, fully featured and RFC-compliant SMTP, POP3, and IMAP client implementations.
>
> All of the other .NET IMAP client implementations that I could find suffer from major architectural problems such as ignoring unexpected untagged responses, assuming that literal string tokens will never be used for anything other than message bodies (when in fact they could be used for pretty much any string token in a response), assuming that the way to find the end of a message body in a FETCH response is by scanning for ") UID", and not properly handling mailbox names with international characters to simply name a few.

Since there is currently no support for System.Net.Mail.SmtpClient MailKit is by far the most recommended email client for dotnet core. At the time of writing it has 1,216,249 downloads on NuGet. The publish of it's v1.4.0 release to NuGet on the 1st July 2016 added support for dotnet core (.net standard 1.3).

MailKit development is led by [Jeffrey Stedfast](twitter.com/jstedfast), it is under active development with contributions from a small community.

### What the community thinks

[![tweet](http://i.imgur.com/VAIUSuv.png)](https://twitter.com/CsharpCorner/status/844311433240166401)
[![tweet](http://i.imgur.com/AB36LL2.png)](http://i.imgur.com/AB36LL2.png](https://twitter.com/kshyju/status/806309223399325697)
[![tweet](http://i.imgur.com/BxzcKMB.png)](https://twitter.com/woisttuza/status/758313541464195072)

### Links

* MailKit [GitHub](https://github.com/jstedfast/MailKit)
* [MimeKit](http://www.mimekit.net)

### Alternatives

I'm not sure that there are currently any alternatives available on dotnet core but using the rest apis provided by services like MailGun and SendGrid is probably viable.

Massive thanks to [Jeffrey Stedfast](twitter.com/jstedfast), and the community.

If you don't want to keep checking back for more posts in this series but do want an email in your inbox then you can subscribe to the mailing list below.

<link href="//cdn-images.mailchimp.com/embedcode/slim-10_7.css" rel="stylesheet" type="text/css">
<div id="mc_embed_signup">
<form action="//xyz.us15.list-manage.com/subscribe/post?u=b6063259bae6e4712948e9cb9&amp;id=802d24879d" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
<div id="mc_embed_signup_scroll">
<label for="mce-EMAIL">Subscribe to dotnet core package a day emails </label>
<br />
<input style="padding:2px;" type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder=" email address" required>
<!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
<div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_b6063259bae6e4712948e9cb9_802d24879d" tabindex="-1" value=""></div>
<input style="padding:2px;" type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button"></div>
</div>
</form>
</div>
