{:title  "Marten - dotnet core package a day - 12"
 :layout :post
 :date   "31-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "Marten" "PostgreSQL" "Document Database" "Event Store"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Marten](https://github.com/jstedfast/Marten).

> Postgresql as a Document Database and Event Store for .Net Applications

Marten development is led by [Jeremy Miller](https://twitter.com/jeremydmiller) and is a relatively young OSS project. Even in it's infancy it has captured the attention of the dotnet community, in under 18 months it has seen 1500+ commits from just under 50 contributors. At the time of writing it has 25,253 downloads on NuGet. The publish of it's v1.0.0 release to NuGet on the 14th September 2016 added support for dotnet core (.net standard 1.3).

I think it's fair to say Marten took some of it's inspiration from [RavenDB](https://ravendb.net/), one of the main goals is to have the many advantages of a schemaless document database (like RavenDB) but based on a technology like PostgreSQL, which is much more widely used in production.

> In the end, what we’d really like to have is all the development advantages of RavenDb and document databases, but have full ACID support, all the DevOps tooling that already exists around Postgresql, and sit on top of a proven database engine.

Marten makes use of another library we covered earlier in the series, [Npgsql](http://markw.xyz/28-03-2017-dotnetcore-package-a-day-9/).

### What the community thinks

[![tweet](http://i.imgur.com/1ZqHmuo.png)](https://twitter.com/ianbattersby/status/781873125545873408)
[![tweet](http://i.imgur.com/ZqJt8K2.png)](https://twitter.com/PhatBoyG/status/807665701771063296)
[![tweet](http://i.imgur.com/aZbj98f.png)](https://twitter.com/jeremydmiller/status/778657007997972480)
[![tweet](http://i.imgur.com/VpXzCvk.png)](https://twitter.com/daveaglick/status/766342241111670784)

### Links

* Marten [GitHub](https://github.com/jasperfx/Marten)

Massive thanks to [Jeremy](https://twitter.com/jeremydmiller), and the community.

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
