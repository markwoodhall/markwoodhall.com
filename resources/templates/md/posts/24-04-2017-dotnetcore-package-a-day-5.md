{:title  "DataStax C# Driver - dotnet core package a day - 5"
 :layout :post
 :date   "24-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core cassandra datastax"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [DataStax C# Driver](https://github.com/datastax/csharp-driver).

> A modern, feature-rich and highly tunable C# client library for Apache Cassandra (1.2+) and DataStax Enterprise (3.1+) using exclusively Cassandra's binary protocol and Cassandra Query Language v3.
>
> Features:
>
> Sync and Async API<br />
> Simple, Prepared, and Batch statements<br />
> Asynchronous IO, parallel execution, request pipelining<br />
> Connection pooling<br />
> Auto node discovery<br />
> Automatic reconnection<br />
> Configurable load balancing and retry policies<br />
> Works with any cluster size<br />
> Linq2Cql and Ado.Net support<br />

DataStax C# Driver is the most actively developed dotnet client for Apache Cassandra. At the time of writing it has 145,882 downloads on NuGet. The publish of it's v3.1.0 release to NuGet on the 17th October 2016 added support for dotnet core (.net standard 1.5).

DataStax C# Driver development is led by the Client Drivers team at DataStax. There have been small contributions from the community but the guys at DataStax are doing an awesome job and were quick to get a dotnet core version out. It's pretty awesome to think that we have a fast and reliable cross platform C# cassandra driver.

### What the community thinks

This is another one where there is little interaction on social media sites like twitter, so the examples below are a little old. 

[![tweet](http://i.imgur.com/KNITFnr.png)](https://twitter.com/KyleSonaty/status/539953176473251843)
[![tweet](http://i.imgur.com/Fa5OlXk.png)](https://twitter.com/DataStaxEng/status/811620775941799936)
[![tweet](http://i.imgur.com/CkGtCi2.png)](https://twitter.com/kellabyte/status/301046046052724736)

### Links

* DataStax C# Driver [Website](http://docs.datastax.com/en/developer/csharp-driver/3.2/)
* DataStax C# Driver [GitHub](https://github.com/datastax/csharp-driver)
* [Documentation](http://docs.datastax.com/en/developer/csharp-driver/3.2/)
* [Getting Started Guide](https://academy.datastax.com/resources/getting-started-apache-cassandra-and-c-net)

### Alternatives

There are currently no alternative Cassandra libraries for dotnet core, there is [cassandra-sharp](https://github.com/pchalamet/cassandra-sharp) but it does not have dotnet core support.

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
