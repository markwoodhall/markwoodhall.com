{:title  "NEST - dotnet core package a day - 3"
 :layout :post
 :date   "22-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core nest elastic elasticsearch"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [NEST](https://github.com/elastic/elasticsearch-net).

NEST is the official dotnet client for Elasticsearch. It was a relatively early adopter of dotnet core, in fact it even released versions supporting the now superseded dnx tooling. NEST is available in a number of different versions, if you are running Elasticsearch
2.x then you want a 2.x version of the NEST client, for Elasticsearch 5.x then you want a 5.x version of the NEST client. The publish of it's v2.4.1 release to NuGet on the 7th July 2016, and it's v5.0.0 release to NuGet on the 13th December 2016 added support for dotnet core.

> When we released NEST 2.x, we supported cross platform .NET with a dotnet 5.1 release of the client, built using DNX toolchain. Now that DNX has been superseded by the dotnet toolchain, we continue to support cross platform .NET in the form of a netstandard 1.3 versions of the 5.x and 2.x client, making NEST usable across Windows, OSX, Linux and any other platform that supports netstandard 1.3.

NEST development is led by the Elastic team [Martijn Laarman](https://twitter.com/Mpdreamz), [Greg Marzouka](https://github.com/gmarz), and [Russ Cam](https://twitter.com/forloop) with help from the wider dotnet community. 

I have used NEST quite heavily on a side project, which I have been working on since the dawn of time. There is little competition in the dotnet ecosystem for Elasticsearch clients
but NEST does generally cover everything I need, and it does so now, on more platforms that ever. It has very good coverage of Elasticsearch features and new goodness arrives frequently. 

> While we continue to support NEST 5.x, 2.x, and 1.x, we have already begun work on NEST 6.0, with a heap of plans cooking to further improve the client. One major goal for NEST 6.0 is removing Json.NET as a dependency and provide our own serializers with stream based parsers that are able to work with async streams. We already have a few components under way to aid in this venture. We'd also like to improve our support for F# with NEST 6.0 and release a more F# compatible version of the client. Stay tuned!

### What the community thinks

Compared to other libraries that I have covered there is much less interaction relating to NEST on social platforms like twitter. Don't let that put you off though, NEST is on it's way to the celebratory milestone of 1,000,000 downloads on NuGet. It currently stands at 954,002. The team are very responsive to issues raised on GitHub and other channels, such as [the discourse forum](https://discuss.elastic.co/c/elasticsearch).

### Links

* NEST [GitHub](https://github.com/elastic/elasticsearch-net)
* [Documentation](https://www.elastic.co/guide/en/elasticsearch/client/net-api/current/index.html)
* [Tutorial Repository](https://github.com/elastic/elasticsearch-net-example)

Massive thanks to the Elastic team [Martijn Laarman](https://twitter.com/Mpdreamz), [Greg Marzouka](https://github.com/gmarz), and [Russ Cam](https://twitter.com/forloop) as well as community members that have  submitted pull requests and raised issue. 

### Alternatives

As far as I can tell there is no viable alternative with dotnet core support at the moment, however, if you are not a fan of NEST you can make use of the underlying Elasticsearch.Net package and create an abstraction on top of that. 

* [Elasticsearch.Net](https://github.com/elastic/elasticsearch-net)

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
