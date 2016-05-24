{:title  "Use drip to make your Clojure (or Java) application start faster."
 :layout :post
 :date   "16-11-2014"
 :tags   ["clojure" "todo" "list"]}

I like writing command line applications in Clojure. I think its quite a good experience when using something like [tools.cli](https://github.com/clojure/tools.cli).

One thing thats always bothered me though, is the start up time of the JVM. When you expect a command line application to be instant and responsive its frustrating to experience a long start up time. [Drip](https://github.com/ninjudd/drip.git) can help reduce those startup times.

Thanks to [Justin Balthrop](http://ninjudd.com/) for building Drip. Justin describes Drip like so:

> "Unlike other tools intended to solve the JVM startup problem (e.g. Nailgun, Cake), Drip does not use a persistent JVM. There are many pitfalls to using a persistent JVM, which we discovered while working on the Cake build tool for Clojure. The main problem is that the state of the persistent JVM gets dirty over time, producing strange errors and requiring liberal use of cake kill whenever any error is encountered, just in case dirty state is the cause.

>Instead of going down this road, Drip uses a different strategy. It keeps a fresh JVM spun up in reserve with the correct classpath and other JVM options so you can quickly connect and use it when needed, then throw it away. Drip hashes the JVM options and stores information about how to connect to the JVM in a directory with the hash value as its name." [See more..](https://github.com/ninjudd/drip.git)

First you need to install Drip. I installed on OS X using brew.

```
brew install drip
```

The example below is a trivial one, it is using the [command line todo list we started building](http://www.markwoodhall.com/creating-clj-tdo-a-command-line-todo-list/). In the example, `tdo` is aliased like so:

```
alias tdo='drip -jar clj-tdo-0.1.0-SNAPSHOT-standalone.jar'
`

`tdoj` has a similar alias but doesn't make use of Drip:

```
alias tdoj='java -jar clj-tdo-0.1.0-SNAPSHOT-standalone.jar'
`

Notice that nothing needs to change, other than the `java` or `drip` command, its even possible to alias `java` to `drip`.

Here is a capture of running those two commands.

{<1>}![drip](http://i.imgur.com/axD8Rjz.gif)

You can tell from the capture that it makes quite a difference. Its even more noticable on slower machines.

If only there was a way of speeding up the "tear down" phase. You can see in the example above, even after the command has finished and the output rendered we still have a wait before we can execute the next command.

