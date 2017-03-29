{:title  "RabbitMQ.Client - dotnet core package a day - 10"
 :layout :post
 :date   "29-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "RabbitMQ"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [RabbitMQ.Client](https://github.com/rabbitmq/rabbitmq-dotnet-client).

For those not familiar with RabbitMQ....

> RabbitMQ is a message broker. The principal idea is pretty simple: it accepts and forwards messages. You can think about it as a post office: when you send mail to the post box you're pretty sure that Mr. Postman will eventually deliver the mail to your recipient. Using this metaphor RabbitMQ is a post box, a post office and a postman.
>
> The major difference between RabbitMQ and the post office is the fact that it doesn't deal with paper, instead it accepts, stores and forwards binary blobs of data ‒ messages.


RabbitMQ.Client is a dotnet client driver for RabbitMQ. At the time of writing it has 1,330,872 downloads on NuGet. The publish of it's v4.0.0 release to NuGet on the 19th August 2016 added support for dotnet core (.net standard 1.5).

I've not been using RabbitMQ.Client for that long but it does feel a bit disjointed to me, I've seen other people say similar things too. Many people prefer to use distributed application frameworks like NServiceBus and MassTransit on top of RabbitMQ, these make use of the RabbitMQ.Client library but provide a more cohesive experience, in my opinion. The difficulty is that neither are currently available on dotnet core. The team at [Particular Software](https://particular.net/) have [previously mentioned the MSMQ dependency as one of stumbling blocks of moving to dotnet core](https://particular.net/blog/nservicebus-on-net-core-why-not).

RabbitMQ.Client development is led by the team at [Pivotal](https://pivotal.io/), it is under active development and there have been contributions from ~30 individuals. The team at [Particular Software](https://particular.net/) are also contributors.

### What the community thinks

[![tweet](http://i.imgur.com/h34Lpda.png)](https://twitter.com/RabbitMQ/status/846697829729009664)
[![tweet](http://i.imgur.com/6Yr5PIV.png)](https://twitter.com/RabbitMQ/status/846697829729009664)

### Links

* RabbitMQ [Website](https://www.rabbitmq.com/)
* RabbitMQ.Client [GitHub](https://github.com/rabbitmq/rabbitmq-dotnet-client)
* [Getting Started Guide](http://www.rabbitmq.com/tutorials/tutorial-one-dotnet.html)

### Alternatives

* [RawRabbit](https://github.com/pardahlman/RawRabbit)

Massive thanks to the team at [Pivotal](https://pivotal.io/), and the community.

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
