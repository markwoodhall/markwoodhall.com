{:title  "Using a Clojure REPL for everyday SQL tasks."
 :layout :post
 :date   "12-02-2015"
 :tags   ["clojure" "sql" "repl"]}

I've described [previously](http://markwoodhall.com/2014/11/13/thoughts-9-months-after-switching-to-vim/) how I've been trying to improve my tooling and move away from using GUI tools so much. As well as this I've also had a more general move away from Windows to OSX.

Since I'm spending most of the day doing Windows based development on the .NET Framework there are a couple of tools I keep using in a VM. I've managed to get rid of most of these but I've not really found a good replacement for SQL Server Management Studio. There is [Razor](http://razorsql.com/) but I'm not very into that.

I've been spending more and more time doing Clojure development lately and consequently I've always got a Clojure REPL open. I thought it would be reasonably useful to setup a project I could use in the REPL to run the ad-hoc SQL queries I typically run throughout the day. I also get the added benefit of having query results as Clojure sequences and maps, which makes me happy. :)

The first thing I did to get started was create a new Clojure project. I called it `sqlrpl` but thats not important.

```
lein new sqlrpl
```
After that I added the [java.jdbc](https://github.com/clojure/java.jdbc) dependency to `project.clj`.

```
[org.clojure/java.jdbc "0.3.6"]
```
[java.jdbc](https://github.com/clojure/java.jdbc) also has a dependency on the JDBC driver for the plaform you are using. I added the TDS driver for Microsoft SQL Server.
```
[net.sourceforge.jtds/jtds "1.2.4"]
```

Once you've done this you can run a basic query by starting a clojure REPL:
```
lein repl
```
and then executing (after changing server details):
<script src="https://gist.github.com/anonymous/99c3539bf6d43059889e.js"></script>

This will return a sequence of maps, each map represents a single row returned by the query and will have keys matching the column names.

Obviously, doing this in the REPL isn't very friendly but since we have a lot of control we can write functions around this and make it easy to run queries.

I started building up a small DSL to compose queries, its very simple and functions follow a similar pattern. Each function returns a string generating function and combines it with the results of the `next-fn`.
<script src="https://gist.github.com/anonymous/279871928daa14444415.js"></script>

This makes it easy to write queries like:
<script src="https://gist.github.com/anonymous/93792c730055d83f8d49.js"></script>

I also make use of two other functions:
<script src="https://gist.github.com/anonymous/408ce47ea20db3b23d88.js"></script>

This means we can run the following to look at the generated SQL:
<script src="https://gist.github.com/anonymous/c5fda5212abc822cbc50.js"></script>

And the following to execute the query:
<script src="https://gist.github.com/anonymous/87d0701a448e002d8346.js"></script>

I think this is pretty nice, and its relatively easy to implement. You also don't have to compose queries like this, you can just do something like:
<script src="https://gist.github.com/anonymous/f79ae640e864e44d3bfb.js"></script>

I also thought it would be nice to have completion for table/column names. So I came up with this (no doubt horrible) bit of Clojure. This defs symbols that match table/column names and return the table/column names.

<script src="https://gist.github.com/anonymous/004b426384f953bcf597.js"></script>

This means we don't have to use the string representation for our table/column names, we use the symbols defined for us, so we get completion in the REPL and our queries become:

<script src="https://gist.github.com/anonymous/ab0c161ed1a7f7145f38.js"></script>

What I've put together is pretty rubbish but its simple and I'm finding it really useful. If you want to look at a really good project that gives you "Tasty SQL for Clojure" check out [Korma](http://sqlkorma.com/).

I also have to give a hat tip to a plugin that has made working in the REPL even more awesome, [Ultra](https://github.com/venantius/ultra). The colorized REPL is awesome when you are doing stuff like this.

While I'm in no way trying to suggest this is a replacement for all the stuff I can do in SQL Server Management Studio, its a start. It covers about 90% of the stuff I do on a day to day basis.

If you want to have a play, the source is [here](https://bitbucket.org/markwoodhall/sqlrpl/overview).

A couple of extra bits:

- Generate a HTML table of our map sequence.

<script src="https://gist.github.com/anonymous/c56a2aac8e3203697d3f.js"></script>

<script src="https://gist.github.com/anonymous/79c62965aad1b2ecb7f8.js"></script>

- Generate an ASCII style string of our map sequence.

<script src="https://gist.github.com/anonymous/1c964720d341c7fdcc78.js"></script>

<script src="https://gist.github.com/anonymous/1ba221e894f39f4629f7.js"></script>

