{:title  "Using RavenDB in Clojure, part two."
 :layout :post
 :date   "21-06-2014"
 :tags   ["clojure" "ravendb" "clj-ravendb"]}

This is the second part of "Using RavenDB in Clojure", you can find the first part [here](http://markwoodhall.com/2014/06/21/using-ravendb-in-clojure-1/).

In this part we will carry on from where we left off with our ravendbtest project. Lets cd into the ravendbtest directory and get going.

## Putting Indexes

If you are familiar with RavenDB you will know that as well as loading documents using their keys you can also query indexes. This is how we can do that using the clj-ravendb client.

Start a clojure REPL again using `lein repl`, require and create a client to consume the northwind database.

<script src="https://gist.github.com/markwoodhall/aecb4f58c02f42724b03.js"></script>

<script src="https://gist.github.com/markwoodhall/4c134ad7dbe2e6ee5790.js"></script>

Now, lets create a few documents that our index can cover.

<script src="https://gist.github.com/markwoodhall/18f2a58e12be5f6e9cd3.js"></script>

We will create an index to cover documents "placedBy" Mark.

<script src="https://gist.github.com/markwoodhall/c081eb24f49159d5dc53.js"></script>

The index we create is represented as a map. It has a `:name`, an `:alias` that we can use to identify a document, a `:where` clause and a `:select` that projects the data items we can query.

Putting the index returns us a map with a `:status`, in this case a HTTP 201.

## Querying Indexes

Since we have created a new index we can now query it.

<script src="https://gist.github.com/markwoodhall/1d96f6812fe3230e29ba.js"></script>

In this example we ask it to query the `:index` we just created, "MyOrders" and we request only orders that have a `:cost` of 102.

This returns us a map that contains a `:status` and the `:results` of the query.

<script src="https://gist.github.com/markwoodhall/87343042a7626226c9e5.js"></script>

Note. We also get a `:stale?` key and value in the returned map. As RavenDB indexes data asynchronously in a background thread there is the potential to query a stale index. This `:stale?` key value indicates if the query results are stale.

The following should be considered when querying indexes.

<script src="https://gist.github.com/markwoodhall/338bda0b5f08f27a5b0c.js"></script>

It is likely I'll make some more changes to index querying as the functionalty is quite narrow. Currently it only supports an "equals" operation against a projected data item.

In the next post, I'll cover two more topics. We will talk about the ability to "watch" documents/indexes for changes and replication.

Go to [part 3](http://www.markwoodhall.com/2014/06/22/using-ravendb-in-clojure-3/)
