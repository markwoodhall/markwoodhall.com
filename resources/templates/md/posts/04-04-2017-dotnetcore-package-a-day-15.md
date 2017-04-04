{:title  "Humanizer - dotnet core package a day - 15"
 :layout :post
 :date   "04-04-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "Humanizer"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Humanizer](https://github.com/Humanizr/Humanizer).

> Humanizer meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities

At the time of writing the Humanizer package has 405,462 downloads on NuGet. The publish of it's v2.1.0 release to NuGet on the 4th July 2016 added support for dotnet core (.net standard 1.0). 

As far as I can tell Humanizer development is led by [Oren Novotny](https://twitter.com/onovotny) after it was handed over by [Mehdi Khalili](https://twitter.com/MehdiKhalili), it is under active development with contributions from over 100 people.

Humanizer is a relatively simple library that does what it does well. It's easy to think that writing a quick "utility function" negates some of the common uses of Humanizer, for instance to produce a quantity string with a singular or plural count, like 1 beer or 2 beers, but Humanizer considers all of the edge cases, it's well tested, and has an api that is easy to use.

### What the community thinks

[![tweet](http://i.imgur.com/hsPJrI3.png)](https://twitter.com/onovotny/status/749782267346685953)
[![tweet](http://i.imgur.com/rKRL4FQ.png)](https://twitter.com/RossDargan/status/694559637849423875)
[![tweet](http://i.imgur.com/7RbDUdu.png)](https://twitter.com/dodegaard/status/692127876129406977)

### Links

* Humanizer [GitHub](https://github.com/Humanizr/Humanizer)


Massive thanks to [Oren Novotny](https://twitter.com/onovotny), [Mehdi Khalili](https://twitter.com/MehdiKhalili), and the wider community.

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
