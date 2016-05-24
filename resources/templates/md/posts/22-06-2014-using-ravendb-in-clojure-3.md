{:title  "Using RavenDB in Clojure, part three."
 :layout :post
 :date   "22-06-2014"
 :tags   ["clojure" "ravendb" "clj-ravendb"]}

This is part three of "Using RavenDB in Clojure". You can find the second part [here](http://www.markwoodhall.com/21-06-2014-using-ravendb-in-clojure-2/).

In this part we will carry on with the ravendbtest project we created in [part 1](http://www.markwoodhall.com/21-06-2014-using-ravendb-in-clojure-1/) and [part 2](http://www.markwoodhall.com/21-06-2014-using-ravendb-in-clojure-2/). Lets cd into the ravendbtest diretory and start a `lein repl` to get started.

## Watching Documents
Using the clj-ravendb client we can "watch" one or more documents for changes.

Open project.clj in your editor of choice.

```
vim project.clj
```

Watching documents makes use of Clojures core.async library. Lets add it as a dependecy to our project.

<script src="https://gist.github.com/markwoodhall/c7d01f2174d63459e8ff.js"></script>

We will also need to require it in the REPL so that we can do some testing.

<script src="https://gist.github.com/markwoodhall/cb6b3f4d0db095afa4e4.js"></script>

In [part 2](http://www.markwoodhall.com/2014/06/21/using-ravendb-in-clojure-2/) we created some new documents.

<script src="https://gist.github.com/markwoodhall/18f2a58e12be5f6e9cd3.js"></script>

We can "watch" these documents for changes using the following code.

<script src="https://gist.github.com/markwoodhall/698d497c14b5eb10ce8f.js"></script>

First we create a channel, then we create a "watcher" and tell it the document keys we want to "watch" and the channel we want it to use to publish changes. We then perform a blocking read from the channel to retrieve the changed documents.

This read will block until something is put on the channel. If you were to open another Clojure REPL, require the clj-ravendb client and run the following.

<script src="https://gist.github.com/markwoodhall/5a19afc6248040b14b3f.js"></script>

clj-ravendb will notice that the document has changed and put it on the channel, the blocking read operation we created earlier will finish and we can evaluate it by typing `changes` and hitting enter in the original REPL.

Changes will look something like this.

<script src="https://gist.github.com/markwoodhall/fa7306444dec62c0f442.js"></script>

Note. If you don't want to block when reading from the channel then you can read using a [go](https://clojure.github.io/core.async/#clojure.core.async/go) block.

<script src="https://gist.github.com/markwoodhall/b9cae81b6b838ca3be6c.js"></script>


## Watching Indexes

We can also watch index queries for changes. This works in exactly the same way as watching documents.

<script src="https://gist.github.com/markwoodhall/f8f04d9098c999dfeed5.js"></script>

## Replication

RavenDB supports replication [out of the box](http://ravendb.net/docs/2.0/server/scaling-out/replication). I enabled replication for my northwind database and replicated it to http://localhost:8081.

All we need to make use of it when using clj-ravendb is to indicate the database we are using is replicated.

<script src="https://gist.github.com/markwoodhall/e27012dd86bafeb819d6.js"></script>

Internally clj-ravendb will call the `Raven/Replication/Destinations` endpoint on http://localhost:8080 and capture the replications. `northwind` is now represented as a map like this.

<script src="https://gist.github.com/markwoodhall/82b652e0710aee808931.js"></script>

The map contains a `:replications` key that has a sequence of RavenDB URLs as its value.

When using this client to do any read based operations such as loading documents or querying indexes the client will use one of the `:replications` if it cannot contact the master, in our case http://localhost:8080.

Thats all for now.
