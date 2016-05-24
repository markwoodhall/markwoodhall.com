{:title  "Finally v1.0.0 of clj-ravendb, a RavenDB client for Clojure."
 :layout :post
 :date   "09-05-2016"
 :tags   ["clojure" "ravendb" "clj-ravendb"]}

TL;DR

I've finally found the time to add a few missing features and a sprinkling of love to [clj-ravendb](https://github.com/markwoodhall/clj-ravendb) and given it a `1.0.0` release. You can find the API docs [here](http://markwoodhall.github.io/clj-ravendb)

#Overview

Almost all of the information present in [these](http://markwoodhall.com/2014/06/21/using-ravendb-in-clojure-1/) [three](http://markwoodhall.com/2014/06/21/using-ravendb-in-clojure-2/) [articles](http://markwoodhall.com/2014/06/22/using-ravendb-in-clojure-3/) is still correct, this post will highlight any differences and discuss new features.

#What's new

## Querying indexes

### Raw lucene query

For instances where `clj-ravendb` offers no built in support for generating a query of a certain type it is now possible to use a raw lucene query.

<script src="https://gist.github.com/markwoodhall/401e14b4dccf8acb1d91089088fd3433.js"></script>

### Range queries

There is now support for [inclusive range queries](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html#Range Searches) using the following syntax.

<script src="https://gist.github.com/markwoodhall/9d4e330a57dd983ecab829856f0ad451.js"></script>

## Creating indexes

Support for creating indexes has been around since early versions but it has changed since the articles mentioned above were published. Instead of supplying the where clause of an index using a string we can now do the following.

<script src="https://gist.github.com/markwoodhall/1a54cc3f762e5e60530d602a939f312d.js"></script>

### Analyzed fields

As well as the new syntax for creating indexes I've also added the ability to specify [anlyzed fields](https://ravendb.net/docs/article-page/3.0/csharp/indexes/using-analyzers).

Using the `:fields` key you can now specify various indexing options:

* `:Indexing` - Configure the [field indexing option](https://github.com/ravendb/ravendb/blob/master/Raven.Abstractions/Indexing/FieldIndexing.cs)
* `:Analyzer` - Configure the [analyzer](https://ravendb.net/docs/article-page/3.0/csharp/indexes/using-analyzers), often just Lucences `StandardAnalyzer`
* `:Storage` - Configure [storing data in an index](https://ravendb.net/docs/article-page/3.0/csharp/indexes/storing-data-in-index)

<script src="https://gist.github.com/markwoodhall/e7734e3bb25530e5a8521381afd5a12e.js"></script>

## Deleting indexes

This is only a small enhancement but is now possible like so:

<script src="https://gist.github.com/markwoodhall/60eb186d62c9f920a28fe206c059c28d.js"></script>

## OAuth support

There is now also support for OAuth authentication. You can create a client that support OAuth like so:

<script src="https://gist.github.com/markwoodhall/86b26bc265422eb83d93e919e8bc27d2.js"></script>

If you plan on creating a client for the lifetime of your application it is worth __keeping in mind that the OAuth token will expire__. Internally `clj-ravendb` will request a new token based on the `:oauth-expiry-seconds` configuration of the client. For example, a client configured to request a new token after 20 minutes can be created like so:

<script src="https://gist.github.com/markwoodhall/bc0c78fefa6e07fde7772a7b96f27b48.js"></script>

If an `:oauth-expiry-seconds` is not supplied then a default of `600` seconds is used.

## Caching

RavenDB has a number of caching methods in it's official .NET client, `clj-ravendb` only supports no caching and a minimal version of [aggressive caching](https://ravendb.net/docs/article-page/3.0/csharp/client-api/how-to/setup-aggressive-caching) at the moment.

To use aggressive caching specify the option when creating a client:

<script src="https://gist.github.com/markwoodhall/52a8143654706a7380aa938445636644.js"></script>

When using aggressive caching *any* request made using `load-documents` will be cached for the lifetime of the client. Any changes made to documents using `put-document!` or `bulk-operations!` will be reflected in the clients local cache. When using replication keep in mind that data can become stale.

## Some notes on replication

When configured `clj-ravendb` will inspect the `Raven/Replication/Destinations` endpoint and failover to replicas when the primary node is unavailable. It is worth keeping in mind that this initial list of replicas is populated when the client is first created. __If you create a client that exists for the lifetime of your application then the list of replicas can become stale.__

##What's left to do

* *ClojureScript* - When I started working on this I had the goal of adding support for ClojureScript. I've got a spike that is almost working, the main pain point left is generating HTTP requests in a consistent fashion.

* *Agressive Caching* - Enable aggressive caching for a subset of documents. Usually aggressive caching is suitable for some document types but not others. Add a configuration option to specify how long the aggresive cache is valid for.

* Replication - The .NET RavenDB client has support for round robin using all replicas. Currently `clj-ravendb` only has support for reading/writing to a replica node when other nodes have failed.
