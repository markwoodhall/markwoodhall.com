{:title  "Dapper - dotnet core package a day - 6"
 :layout :post
 :date   "25-03-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "dapper" "sql"]}


### Overview

This post is part of a series, dotnet core package a day, where for 15 days I will be posting an overview of an awesome OSS dotnet package that already has support for dotnet core. In this post we will cover [Dapper](https://github.com/StackExchange/Dapper).

> Dapper is a NuGet library that you can add in to your project that will extend your IDbConnection interface.

Dapper is a micro ORM for the dotnet framework, it's lightweight and easy to use. At the time of writing it has 2,708,300 downloads on NuGet. The publish of it's v1.50.0 release to NuGet on the 1st July 2016 added support for dotnet core (.net standard 1.3).

Dapper development is led by [Nick Craver](https://twitter.com/Nick_Craver) and [Marc Gravell](https://twitter.com/marcgravell) but it is very much a community project, it currently has 100+ contributors.

I am using Dapper quite heavily as part of a migration to dotnet core at [Open Energy Market](http://www.openenergymarket.com) and having used it on a number of other projects too I have always appreciated it's simplicity, I'm super happy it's already available on dotnet core. 

### What the community thinks

[![tweet](http://i.imgur.com/NIpwcCg.png)](https://twitter.com/CallumVass/status/844537339183542272)
[![tweet](http://i.imgur.com/t3XTLDE.png)](https://twitter.com/reverentgeek/status/839638440199110657)
[![tweet](http://i.imgur.com/XpvNgcd.png)](https://twitter.com/KerryRitter/status/788537959410610178)

Massive thanks to [Nick](https://twitter.com/Nick_Craver), [Marc](https://twitter.com/marcgravell), and the wider community.

### Links

* Dapper [Website](https://stackexchange.github.io/Dapper/)
* Dapper [GitHub](https://github.com/StackExchange/Dapper)

### Alternatives

Alternatives include [PetaPoco](https://github.com/CollaboratingPlatypus/PetaPoco) but it does not currently have dotnet core support. In fact, I don't think any of the other ORM libraries we would consider micro (Massive, Simple.Data etc) currently have dotnet core support either. 

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
