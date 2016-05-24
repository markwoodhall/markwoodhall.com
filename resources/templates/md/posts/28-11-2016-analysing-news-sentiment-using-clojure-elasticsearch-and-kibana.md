{:title  "Analysing news sentiment using Clojure, Elasticsearch and Kibana."
 :layout :post
 :date   "28-11-2014"
 :tags   ["clojure" "elasticsearch"]}

I've been working on a project recently to do with analysing the underlying sentiment found in online news stories. I wanted to have a play with [Kibana](http://www.elasticsearch.org/overview/kibana/) to do some "real time" visualisations and I wanted to do it without using log files.

So, I came up with a small (less than 100 lines) Clojure program that would:

1. Query various popular news sites and analyse words using an open source lexicon dataset.
2. Filter any words that have little impact, like "the".
3. Sanitize anything that may have contained HTML markup.
4. Store in [Elasticsearch](http://www.elasticsearch.org/).

I've left it running for ~24 hours and the results are interesting, if not very scientifically accurate.

It has aggregated data from the following source.

- BBC News
- Sky News
- Fox News
- Huffington Post
- Daily Mail
- CNN
- Telegraph
- Reuters
- Yahoo News
- Google News

All of the results below assume 0 is a neutral sentiment, <0 is a negative sentiment and >0 is a positive one.

###Daily Mail (MailOnline)
Everyone knows the [Daily Mail](http://www.dailymail.co.uk/home/index.html) is typical tabloid news, I expected that it would probably generate quite a negative sentiment. It was consistently the most negative.

[![DailyMail Sentiment](http://i.imgur.com/6ssw2Cc.png)](http://i.imgur.com/6ssw2Cc.png)

###Huffington Post
I didn't realise it before now but the [Huffington Post](http://www.huffingtonpost.co.uk/) has quite a lot of positive news as well as some reasonably humorous articles. It was consistently the most postive. It also appears to publish a LOT and very frequently, which makes the graph a bit jumpy.

[![Huffington](http://i.imgur.com/6QarNI0.png)](http://i.imgur.com/6QarNI0.png)

###BBC News
I expected that the [BBC](http://www.bbc.co.uk) might be quite consistent and might represent a good view of overall news sentiment. It was more negative than I expected, I guess that is just the world we live in.

[![BBC](http://i.imgur.com/JbKKBWg.png)](http://i.imgur.com/JbKKBWg.png)

All of the other news sources (Sky, Fox, CNN, Telegraph, Reuters, Yahoo, Google) trended much closer to a neutral sentiment.

###Overall
I think the overall sentiment may be a little off because of including the Huffington Post data, I think in the long run, the more sources I add the better the data will be.

[![Overall](http://i.imgur.com/s4BhqJu.png)](http://i.imgur.com/s4BhqJu.png)

I'm planning to leave this running over a longer period and see how it gets on, it would be interesting for it to pick up a major news event, we will see.

For anyone interested, here is a screenshot of the Kibana dashboard.

[![Kibana](http://i.imgur.com/enIcLcC.png)](http://i.imgur.com/enIcLcC.png)

I'll do a more technical post soon and make available the code once I'm finished.
