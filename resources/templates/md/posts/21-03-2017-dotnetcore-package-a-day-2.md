{:title  "StructureMap - dotnet core package a day - 2"
 :layout :post
 :date   "21-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core structuremap dependency injection"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [StructureMap](http://structuremap.github.io/).

In my opinion StructureMap is one of the most well thought out container libraries on the .net framework . At the time of writing it has 1,741,273 downloads on NuGet. Here is the official take on it:

> StructureMap is the oldest, continuously used IoC/DI container for .Net dating back to its first public release and production usage all the way back in June 2004 on .Net 1.1. The current 4.* release represents 12+ years of lessons learned in the StructureMap and greater .Net community -- while also wiping away a great deal of legacy design decisions that no longer make sense today.

StructureMap development is led by [Jeremy Miller](https://twitter.com/jeremydmiller) and is actively developed, it offers dotnet core support and has done for over 6 months. The publish of its v4.3.0 release to NuGet on the 1st August 2016 was the first version to support dotnet core (.net standard 1.3 and .net standard 1.5). There is also support to play nicely with the new Microsoft.Extensions.DependencyInjection default container, this is available as a [seperate package](https://github.com/structuremap/StructureMap.Microsoft.DependencyInjection). 

I am using StructureMap quite heavily as part of a migration to dotnet core at [Open Energy Market](https://www.openenergymarket.com) and have found it intuitave and easy to use. The favoured container library in the past was [Ninject](https://github.com/ninject/Ninject) but at the time of writing there are only beta packages available with dotnet core support. Moving to StructureMap has been friction free and as pleasurable to use as any container library. 

### What the community thinks

[![tweet](http://i.imgur.com/P9kcTId.png)](https://twitter.com/asbjornu/status/817951837827502080)

[![tweet](http://i.imgur.com/HRL2D5X.png)](https://twitter.com/Mufasa245/status/826103631829143554)

[![tweet](http://i.imgur.com/9LV3IM6.png)](https://twitter.com/matthoneycutt/status/823603288780263424)

[![tweet](http://i.imgur.com/hfSddS4.png)](https://twitter.com/minhajuddin/status/835137902808039425)

### Links

* StructureMap [Website](http://structuremap.github.io/)
* StructureMap [GitHub](https://github.com/structuremap/structuremap)
* [Getting Stared Guide](http://structuremap.github.io/quickstart/)

Massive thanks to [Jeremy](https://twitter.com/jeremydmiller) and the community. 

### Alternatives

Some other alternatives with dotnet core support.

* [Microsoft's own](https://github.com/aspnet/DependencyInjection) *Wash your mouth out, j/k
* [Autofac](https://github.com/autofac/Autofac)

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
