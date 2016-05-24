{:title  "Using RavenDB in Clojure, part one."
 :layout :post
 :date   "21-06-2014"
 :tags   ["clojure" "ravendb" "clj-ravendb"]}

For one reason and another I was interested in using [RavenDB](http://ravendb.net/) in a clojure project I was working on. I've used RavenDB for a while and had a bit of experience with both the .NET client and the HTTP api.

While there is currently a Java RavenDB client I didnt want to use this for two reasons.

1. This is about improving my knowledge of clojure
2. I would like to compile the client as clojurescript eventually

So, I figured it would be fun to create a clojure client that didn't just wrap the Java client but instead consumed the HTTP api and I started building [clj-ravendb](http://clojars.org/clj-ravendb).

The source is [here](https://bitbucket.org/markwoodhall/clj-ravendb) if you want to have a look.

## Getting Started

I'm assuming a familiarity with clojure and leiningen but if not check out the [getting started guides](http://clojure.org/getting_started).

Ok, so, lets create a new clojure project.

```
lein new ravendbtest
```

Then we can cd into the project.

```
cd ravendbtest
```

I'm using vim but feel free to use whatever makes you happy.

Lets add clj-ravendb to our new project.

```
vim project.clj
```

At the time of this post the most recent version of clj-ravendb is 0.4.0. Modify project.clj to add the dependency.

<script src="https://gist.github.com/markwoodhall/c1e353a051a1ed4a7205.js"></script>

Note. The most recent version of clj-ravendb is currently:

[![Clojars Project](http://clojars.org/clj-ravendb/latest-version.svg)](http://clojars.org/clj-ravendb)

Then run ```lein compile :all``` to compile and download the project dependencies.

Now we've created a project and referenced clj-ravendb we can try it out.

First, while we are still cd'd into the ravendbtest directory lets start a clojure REPL. I am using [vim-fireplace](https://github.com/tpope/vim-fireplace) to send expressions to the REPL from vim but you can type directly into the REPL if you wish.

```
lein repl
```

## Putting Documents

The first thing we need to do is require the ravendb client.

<script src="https://gist.github.com/markwoodhall/aecb4f58c02f42724b03.js"></script>

Note. The rest of the post will assume there is an instance of RavenDB running at http://localhost:8080 and that the instance contains the sample northwind database.

The sample northwind database is available [here](https://github.com/ayende/ravendb/blob/2.5/Raven.Studio/Assets/EmbeddedData/Northwind.dump).

Next we create a client we can use to consume the northwind database.

<script src="https://gist.github.com/markwoodhall/4c134ad7dbe2e6ee5790.js"></script>

You can have a peek at the client by evaluating it in the REPL, type ```northwind``` and hit enter. You will see the client is represented by a map.

<script src="https://gist.github.com/markwoodhall/787f045a44fe2d423a2b.js"></script>

Now that we have a client we can start using it, type the following into the REPL to create a new document.

<script src="https://gist.github.com/markwoodhall/3560a76146a73fed92dd.js"></script>

When we put a new document we need to give it a key, which is represented with a string and the actual document, which we represent with a map.

This should return a map that contains a HTTP status, in this case we should get a ```{:status 200}``` indicating the resource was created.

## Loading Documents

Lets try getting the document we just created back out.

<script src="https://gist.github.com/markwoodhall/10c9488b7d10cea9a4ec.js"></script>

When we load documents we need to provide a sequence of document ids to load. In this case we just load one, "Orders/10000".

This should give us back the following.

<script src="https://gist.github.com/markwoodhall/f58daf49f63670d19eda.js"></script>

Note that we get a ```:status``` that represents the HTTP status code and we get some ```:results```. The ```:results``` are a sequence that contain all the documents we tried to load.

In the next post I'll cover creating and querying indexes and then we will talk about how the client makes use of the replication functionality provided by RavenDB.

Go to [part 2](http://markwoodhall.com/2014/06/21/using-ravendb-in-clojure-2/)
