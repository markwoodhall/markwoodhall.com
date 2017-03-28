{:title  "Npgsql - dotnet core package a day - 9"
 :layout :post
 :date   "28-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "Npgsql" "PostgreSQL"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Npgsql](https://github.com/jbogard/Npgsql).
 
> Npgsql is an open source ADO.NET Data Provider for PostgreSQL, it allows programs written in C#, Visual Basic, F# to access the PostgreSQL database server. It is implemented in 100% C# code, is free and is open source.
>
> In addition, providers have been written for Entity Framework Core and for Entity Framework 6.x.

Npgsql is by far the most popular dotnet data provider for PostgreSQL. At the time of writing it has 987,642 downloads on NuGet. The publish of it's v3.1.0 release to NuGet on the 16th May 2016 added support for dotnet core (.net standard 1.3), that is pretty impressive.

Npgsql development is led by [Shay Rojansky](https://twitter.com/shayrojansky), it is under active development and there have been contributions from ~60 individuals.

I've only recently started to use PostgreSQL so Npgsql is still quite new to me. I'm enjoying using it so far. For anyone who is already familiar with dotnet database drivers it is easy to use and will look very familiar.

> Npgsql aims to be fully ADO.NET-compatible, its API should feel almost identical to other .NET database drivers. Here's a basic code snippet to get you started.

### What the community thinks

[![tweet](http://i.imgur.com/BDWmdgd.png)](https://twitter.com/FransBouma/status/840857586178129920)
[![tweet](http://i.imgur.com/WBYlKSQ.png)](https://twitter.com/shayrojansky/status/844238439117737984)
[![tweet](http://i.imgur.com/RI0i0Lb.png)](https://twitter.com/oss_csharp/status/842697581130145792)

### Links

* Npgsql [Website](http://www.npgsql.org/)
* Npgsql [GitHub](https://github.com/npgsql/npgsql)
* [Getting Started Guide](http://www.npgsql.org/doc/index.html)

Massive thanks to [Shay](https://twitter.com/shayrojansky) and the community.

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
