{:title  "Steeltoe - dotnet core package a day - 14"
 :layout :post
 :date   "03-04-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "Steeltoe" "validation"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Steeltoe](https://github.com/SteelToeOSS).

> Painless microservice patterns for .NET
> For all their benefits, microservice architectures expose many distributed computing problems that traditional monoliths avoided. Steeltoe brings the power of resilient, scalable microservices to .NET developers, without all the headache.
 
I guess I'm cheating a little bit here as Steeltoe isn't a single package, for instance, the [Steeltoe.Discovery.Eureka.Client](https://www.nuget.org/packages/Steeltoe.Discovery.Eureka.Client/) package provides a dotnet client for [Netflix Eureka](https://github.com/Netflix/eureka) and the [Steeltoe.CloudFoundry.Connector.Redis](https://www.nuget.org/packages/Steeltoe.CloudFoundry.Connector.Redis/) package provides a connector for [Cloud Foundary](https://www.cloudfoundry.org/) redis. There are [other connector packages](https://www.nuget.org/packages?q=steeltoe) available that support MySQL, PostgreSQL, Rabbit, and OAuth. All of the packages are very new, the v1.0.0 release was only published on the 31st March 2017. This is reflected in the download stats, with downloads in the low thousands for most packages. The v1.0.0 release supports dotnet core from the get go.

### What the community thinks

[![tweet](http://i.imgur.com/v8MNBkF.png)](https://twitter.com/SteeltoeOSS/status/848368106720317442)
[![tweet](http://i.imgur.com/cUad5PG.png)](https://twitter.com/SteeltoeOSS/status/819320385292234754)
[![tweet](http://i.imgur.com/wCUOx2s.png)](https://twitter.com/parkerfleming/status/796749754357129216)
[![tweet](http://i.imgur.com/zDnzWMP.png)](https://twitter.com/SteeltoeOSS/status/80119740495541862)

### Links

* Steeltoe [Website](http://steeltoe.io/)
* Steeltoe [GitHub](https://github.com/SteelToeOSS)
* [Documentaton](http://steeltoe.io/docs/)

Thanks to the team at [Pivotal](https://pivotal.io/).

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
