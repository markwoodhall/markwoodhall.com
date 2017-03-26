{:title  "Serilog - dotnet core package a day - 1"
 :layout :post
 :date   "20-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "serilog" "logging"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Serilog](https://serilog.net).

Serilog is an awesome dotnet library for logging. Don't take my word for it though, at the time of writing it has 1,868,319 downloads on NuGet. Here is the official take on it:

>  Like many other libraries for .NET, Serilog provides diagnostic logging to files, the console, and elsewhere. It is easy to set up, has a clean API, and is portable between recent dotnet platforms.
>
>  Unlike other logging libraries, Serilog is built from the ground up to record structured event data.

Serilog is backed heavily by the dotnet community and is very actively developed, it offers "best-in-class" dotnet core support and as far as I can tell has done for quite some time. The publish of its v2.0.0 release to NuGet on the 27th June 2016 was the first version to support dotnet core (.net standard 1.0 and .net standard 1.3). It also has support for the new Microsoft.Extensions.Logging abstraction. 

Serilog exposes the concept of sinks, there are sinks available to write log events to a variety of storage platforms and formats. Ranging from the console to cloud analytics platforms such as Azure Analytics, New Relic, and Stackify, there is almost certainly a sink available that will fit your logging needs. Many of the sinks are maintained by the core Serilog team but there is also an ecosystem of community developed sinks. Even better is that many of the available sinks also have dotnet core support. 

I am using Serilog quite heavily as part of a migration to dotnet core at the awesome [Open Energy Market](https://www.openenergymarket.com) and am happy to be doing so with well written, community developed, cross platform, and easy to use libraries like Serilog. 

### What the community thinks

[![tweet](http://i.imgur.com/9ZBkFjF.png)](https://twitter.com/mvalipour/status/828942749235830784)

[![tweet](http://i.imgur.com/LLhz2l9.png)](https://twitter.com/dmitryzaets/status/825383217024860160)

[![tweet](http://i.imgur.com/dofJMaC.png)](https://twitter.com/ChrisBriggsy/status/836392875122282496)

### Links

* Serilog [Website](https://serilog.net/)
* Serilog [GitHub](https://github.com/serilog/serilog)
* [Getting Stared Guide](https://github.com/serilog/serilog/wiki/Getting-Started)
* I love the [literate sink](https://github.com/serilog/serilog-sinks-literate)

Massive thanks to [Nicholas](https://twitter.com/nblumhardt) and the community. 

### Alternatives

Some other alternatives with dotnet core support.

* [NLog](https://github.com/NLog/NLog)

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
