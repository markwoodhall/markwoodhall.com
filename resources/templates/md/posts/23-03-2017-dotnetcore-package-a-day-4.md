{:title  "AutoMapper - dotnet core package a day - 4"
 :layout :post
 :date   "23-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "automapper"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [AutoMapper](https://github.com/AutoMapper/AutoMapper).

> AutoMapper is a simple little library built to solve a deceptively complex problem - getting rid of code that mapped one object to another. This type of code is rather dreary and boring to write, so why not invent a tool to do it for us?
> AutoMapper uses a fluent configuration API to define an object-object mapping strategy and a convention-based matching algorithm to match up source to destination values. Currently, AutoMapper is designed for model projection scenarios to flatten complex object models to DTOs and other simple objects, whose design is better suited for serialization, communication, messaging, or simply an anti-corruption layer between the domain and application layer.

AutoMapper is the most widely used object mapping library for the dotnet platform. It has a rather impressive 7,716,215 downloads on NuGet, 1,030,380 of those downloads are for a single version (v3.3.1). It averages 3,403 downloads a day. The publish of it's v5.0.2 release to NuGet on the 7th July 2016 added support for dotnet core (.net standard 1.1 & .net standard 1.3).

AutoMapper development is led by [Jimmy Bogard](https://twitter.com/jbogard), there have been a number of contributions from the wider community as well, at the time of writing 80+ individuals have commited to AutoMapper.

I've used AutoMapper on a lot of projects now and as long as I've favoured convention over configuraton it has been an awesome library to use. I've also used Mapster and had good experiences with that too.

### What the community thinks

[![tweet](http://i.imgur.com/CuegG6I.png)](https://twitter.com/SakisK/status/836978146259963905)
[![tweet](http://i.imgur.com/kdAN4jT.png)](https://twitter.com/kamranayub/status/822169571771772929)
[![tweet](http://i.imgur.com/UYteizv.png)](https://twitter.com/jbogard/status/816740750872498189)
[![tweet](http://i.imgur.com/PDI9AGo.png)](https://twitter.com/CharlesPeet/status/814200801824538625)

### Links

* AutoMapper [Website](http://automapper.org/)
* AutoMapper [GitHub](https://github.com/AutoMapper/AutoMapper)
* [Documentation](https://github.com/AutoMapper/AutoMapper/wiki)
* [Getting Started Guide](https://github.com/AutoMapper/AutoMapper/wiki/Getting-started)

Massive thanks to [Jimmy](https://twitter.com/jbogard) and the community.

### Alternatives

* [Mapster](https://github.com/eswann/Mapster)

Mapster is a good alternative that also has dotnet core (.net standard 1.3) support. 

> A fast, fun and stimulating object to object mapper. Kind of like AutoMapper, just simpler and way, way faster*.

If you don't want to keep checking back for more posts in this series but do want an email in your inbox then you can subscribe to the mailing list below.

*AutoMapper has made significant performance improvements since it's v4.2.1 release. [Benchmarks](https://lostechies.com/jimmybogard/2016/06/24/automapper-5-0-speed-increases/), [More Benchmarks](http://geekswithblogs.net/mrsteve/archive/2016/12/28/object-mapper-performance-comparison-allowpartiallytrustedcallers.aspx)

[![tweet](http://i.imgur.com/n9UjcjP.png)](https://twitter.com/jbogard/status/845042238396796929)

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
