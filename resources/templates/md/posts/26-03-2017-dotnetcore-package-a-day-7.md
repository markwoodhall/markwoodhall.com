{:title  "Jil - dotnet core package a day - 7"
 :layout :post
 :date   "26-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "jil" "json" "serializaton"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Jil](https://github.com/kevin-montrose/Jil).

> A fast JSON (de)serializer, built on Sigil with a number of somewhat crazy optimization tricks.

Jil is a fast JSON serialization library. There are some very interesting numbers to quantify "fast" available [here](https://docs.google.com/spreadsheets/d/1Jx7DAGopJo3BC0St_L5qHJJrWpZe9x9BCHgdeY9-b-w/edit#gid=0). At the time of writing it has 163,674 downloads on NuGet. It's latest stable version, v2.15.0, was published on the 9th January 2017. This publish updated it's [Sigil](https://github.com/kevin-montrose/Sigil) dependency and also added dotnet core support (.net standard 1.6). 

Jil development is led by [Kevin Montrose](https://twitter.com/kevinmontrose). There have been ~20 community contributors and the project is actively developed.  

I have started to look at using Jil where there is a genuine need for a faster serializer. It is a really great option to have available on dotnet core and is used heavily in production at Stack Overflow.

### What the community thinks

[![tweet](http://i.imgur.com/x2IuwnM.png)](https://twitter.com/kevinmontrose/status/818489828740317184)
[![tweet](http://i.imgur.com/ZogU8Fw.png)](https://twitter.com/zahmed/status/639419712250728448)
[![tweet](http://i.imgur.com/1biY92z.png)](https://twitter.com/Scooletz/status/664428811606474753)

Thanks again to [Kevin](https://twitter.com/kevinmontrose), and the wider community.

### Links

* Jil [GitHub](https://github.com/kevin-montrose/Jil)
* Sigil [GitHub](https://github.com/kevin-montrose/Sigil)

### Alternatives

Alternatives include the widely used NewtonSoft.Json. Even the Jil documentation suggests that it's focus on speed [can hinder usability](https://github.com/kevin-montrose/Jil/wiki/Common-Pitfalls), so do consider how appropriate it is. 

> Jil can be more difficult to use than other JSON libraries due to it's focus on speed, rather than flexibility or ease of use, above all else.

[Newtonsoft.Json](http://www.newtonsoft.com/json) added dotnet core support in it's v9.0.1 release, and has had over 50,000,000 downloads on NuGet.

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
