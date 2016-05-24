{:title  "Creating clj-tdo, a command line todo list."
 :layout :post
 :date   "02-07-2014"
 :tags   ["clojure" "todo" "list"]}

Using a todo list really appeals to me, I often find I go back to using one if I'm going through a period of not getting much done.

##Current applications
There are already a number of a good command line todo lists.

1. [Taskwarrior](http://taskwarrior.org/)
2. [Todo.txt](http://todotxt.com/)
3. [t](http://stevelosh.com/projects/t/)

I especially like the look of [t](http://stevelosh.com/projects/t/), its simple and focuses on keeping out of the way. If I was just interested in finding a command line to do list I would probably just install [t](http://stevelosh.com/projects/t/). I have an agenda though, I also want to learn some more Clojure.

With this in mind I plan on creating:

1. A [compojure](https://github.com/weavejester/compojure) based API for managing tasks
2. A command line client with local storage and "push" to server

I wanted to use a compojure API to get some experience of deploying Clojure to windows azure. I also want to take this as an opportunity to use azure storage. At present it doesn't look like there is a stable and feature complete azure library in Clojure. The closest thing I can see is [clj-azure](https://github.com/RobBlackwell/clj-azure), maybe I can make some contributions to that project as I go along or create something to wrap the [Java Azure SDK](http://azure.microsoft.com/en-us/develop/java/).

Anyway, I can forget all that initially. It makes sense to at least create a basic command line client and worry about everything else after.

From previous experience I know that command line applications in Clojure can sometimes suffer as a result of the relatively slow JVM start up times, although thats unfair to the JVM as Clojure is also part of the problem. I'll also take this as an opportunity to try [drip](https://github.com/ninjudd/drip).

>Drip is a launcher for the Java Virtual Machine that provides much faster startup times than the java command. The drip script is intended to be a drop-in replacement for the java command, only faster.

>Drip is a single bash script and a little bit of C and Java code. It is intended to work with any JVM-based language and anywhere bash is available.

I'll be writing regular posts as I go along and making the source available for anyone who wants to learn or make suggestions.

##Getting started
If you've never done any command line based applications in Clojure check out [Command line applications in Clojure](http://www.markwoodhall.com/command-line-applications-in-clojure/) as we will be using the structure and dependencies defined there.

Assuming you read the linked post above you should have a Clojure project that looks like [this](https://bitbucket.org/markwoodhall/cli-test). Just get rid of the "cruft" in there that we don't need and change any references to `cli-test` to `clj-tdo`, including any folder names.

###Thinking about a client API
Now that we have a shell we can work with I think its worth spending a bit of time considering our client API.

I plan on creating a bash alias, probably `tdo` or `t` that will execute the jar file containing our app.

####Creating tasks
To keep things simple we only want to capture the things we really need when creating tasks. I'm thinking we can use a `new` command, something like:

```
tdo new -t "Write some new codez" -d 20/07/2014 -c "Programming|Work"
```
Here `-t` is the task, `-d` is the due date and `-c` is a pipe separated list of categories/tags.

Ideally we won't have to quote our strings as its a pain but we can figure that out later.

One thing thats quite specific but I know I would like is the ability to repeat a task. Something like:

```
tdo new -t "Attend daily meeting" -d 20/07/2014 -c "Meetings|Work" -r 4
```
Here we are using `-r` to indicate we want to repeat this task for 4 days.

I think thats all we need to capture. Internally we can record the date the task was created as well.

####Listing tasks
If we think about listing our tasks it would be nice if we could do something like `tdo list`. We could also create a short form of that using the familiar `ls`. e.g. `tdo ls`.

Keeping in mind the data we are capturing using the `new` command we should probably provide some switches to the `ls` command.

Overdue tasks:
```
tdo ls -o
```
Tasks due on a particular date:
```
tdo ls -d 01/09/2014
```
Tasks with a particular category:
```
tdo ls -c "Work"
```

I think thats probably it. I can find out what I should have done that I haven't and I can find out things I need to have done by a given date.

The only other thing I would like the `ls` command to handle is sorting, perhaps via a `-s` switch. I'd just like to pass in a simple `D` or `C` to order by due or created date.

```
tdo ls -s D
tdo ls -s C
```

####Completing tasks
A simple `done` command is all we need, for now I'm happy with identifying the task by its title but we may need to change that later.

We don't need to capture anything else via the command, internally we will probably capture the date the task was completed.

```
tdo done -t "Some task I completed"
```

### Writing some code

So, now we can actually start to write some code. I think it will be useful to define the help for our app first.

Open `src/clj-tdo/core.clj` and look for the `help` function. Lets update it and make it applicable to the API we defined above.

<script src="https://gist.github.com/markwoodhall/790ee748fb2fd527ed9c.js"></script>

Now, lets update our `cli-options`.

<script src="https://gist.github.com/markwoodhall/b85ab783de4f7a33fb4e.js"></script>

We are making use of [clj-time](https://github.com/clj-time/clj-time) to work with dates, so we will need to add a dependecy to `project.clj`.

<script src="https://gist.github.com/markwoodhall/3c7ae253ecdb63b6e13c.js"></script>

We will also need to require the library in `src/clj-tdo/core.clj`. Lets update our namespace declaration.

<script src="https://gist.github.com/markwoodhall/9c0bf3fa63349bf61ac4.js"></script>

Now we can do a `lein uberjar` to generate a jar file, I'm also going to create a bash alias now.

```
alias tdo='java -jar target/clj-tdo-0.1.0-SNAPSHOT-standalone.jar'
```

We don't need to create an alias but I'm going to as I will modify it later in order to  make use of [drip](https://github.com/ninjudd/drip).

If we run `tdo --help` we should see the help we just created.

Previously we defined the functions that handle our commands as `handlers` in `src/clj-tdo/core.clj`, lets create a new file for this, `src/clj-tdo/handlers.clj`.

<script src="https://gist.github.com/markwoodhall/a060c3f76c9899fba76a.js"></script>

We have a handler for each of the `new`,`list`,`ls` and `done` commands.

Each of the handlers accepts the options map and they currently have no functionality. Before we add functionality lets think about how we are going to store our tasks.

Initially we will just worry about local storage, lets start by defining a [protocol](http://clojure.org/protocols) for task storage. Create `stores.clj` in `src/clj-tdo/`.

<script src="https://gist.github.com/markwoodhall/6b116a821b07cd7a4e03.js"></script>

For now we will just worry about putting a single task and getting all tasks.

Next, we can create a `LocalDiskStore`.

<script src="https://gist.github.com/markwoodhall/2f710a8eaee55654dd58.js"></script>

In `put-task` we [`slurp`](http://clojuredocs.org/clojure_core/clojure.core/slurp) the contents of `path` and do a [`read-string`](http://clojuredocs.org/clojure_core/clojure.core/read-string) to turn the string into symbols. In this case we know we are going to store a string representing a map, and we know we can get the tasks out of that map using `(:tasks m)`. Since we are assuming the title of our task is unique we can then [`filter`](http://clojuredocs.org/clojure_core/clojure.core/filter) out any tasks that match on title, we then [`conj`](http://clojuredocs.org/clojure_core/clojure.core/conj) the new or updated task onto `tasks`. Once we have an updated tasks list we can [`assoc`](http://clojuredocs.org/clojure_core/clojure.core/assoc) it to our map. We can now [`pr-str`](http://clojuredocs.org/clojure_core/clojure.core/pr-str) our map to get a string and then [`spit`](http://clojuredocs.org/clojure_core/clojure.core/spit) it out to `path`.

In `get-tasks` we [`slurp`](http://clojuredocs.org/clojure_core/clojure.core/slurp) the contents of `path`, do a [`read-string`](http://clojuredocs.org/clojure_core/clojure.core/read-string) and get `:tasks` out of the map.

We also define a convenience function that gets us a `LocalDiskStore` at a given `path` and makes sure the `path` exists.

The entire file looks like this.

<script src="https://gist.github.com/markwoodhall/26510d18357cb1cf3f1f.js"></script>

Note. [`slurp`](http://clojuredocs.org/clojure_core/clojure.core/slurp) reads a whole file into memory, where this is a concern you can use a [`reader`](http://richhickey.github.io/clojure/clojure.java.io-api.html#clojure.java.io/reader).

Now that we have something to store and retrieve tasks, lets hook it up, open `src/clj-tdo/core.clj` and require the `local-disk-store` function. The namespace declaration should now look like this.

<script src="https://gist.github.com/markwoodhall/9f97f558217e9075f910.js"></script>

Lets modify the main function to pass a store into our invoked handler.

<script src="https://gist.github.com/markwoodhall/b1c64919aa945b997aa9.js"></script>

We now need to modify our handlers to accept the store. Open `src/clj-tdo/handlers.clj`.

Before we start on the handlers, lets pull in some things we will need. Update the namespace declaration to inlude [clj-times](https://github.com/clj-time/clj-time) core, formatting and coerce namespaces as well as the `put-task`, `get-tasks` and `Store` declarations.

<script src="https://gist.github.com/markwoodhall/dbe09c044787691c4d7c.js"></script>

We also want to define a record to represent our task. We can do this using [`defrecord`](http://clojuredocs.org/clojure_core/clojure.core/defrecord) like so.

<script src="https://gist.github.com/markwoodhall/57de8e434764466ce143.js"></script>

Now we can implement the `new-task` handler like so.

<script src="https://gist.github.com/markwoodhall/98e5c5684fd92d6e51a1.js"></script>

Here we destructure the options map and take only the things we care about and we also add the store argument.

We add a precondition to make sure our store argument implements the Store protocol.

Then we use [`range`](http://clojuredocs.org/clojure_core/clojure.core/range) to get a sequence based on the number of days we want to repeat the task.

We then use [`doseq`](http://clojuredocs.org/clojure_core/clojure.core/doseq) to repeatedly create and store a `Task` record using the `put-task` function. If its a repeated task we number it uniquely based on its position in the sequence. Finally we call `list-tasks` to print all our tasks.

Obviously, we now need to work on the `list-tasks` handler. We are going pull in another library and create a few supporting functions first.

I'd like to push some ANSI colour codes to the command line in order to appropriately colour tasks, so I'm pulling in [clansi](https://github.com/ams-clj/clansi) and updating our namespace declaration to require it.

<script src="https://gist.github.com/markwoodhall/a55c8f06b9fdc125cd15.js"></script>

The simplest use of [clansi](https://github.com/ams-clj/clansi) is as follows.

```
(style "Some console message" :red)
```

It has a range of colours and styles, you can see more [here](https://github.com/ams-clj/clansi/blob/master/src/clansi/core.clj#L3).

Now we can define a helper function that accepts multiple styles and uses [`apply`](http://clojuredocs.org/clojure_core/clojure.core/apply). The [`apply`](http://clojuredocs.org/clojure_core/clojure.core/apply) function is described as follows.

>Applies fn f to the argument list formed by prepending intervening arguments to args.

Next, we define a couple of functions to help with the due status of tasks.

<script src="https://gist.github.com/markwoodhall/ddeadc9eb24fabd1390f.js"></script>

We can now make use of these functions and create a `prn-task` function that prints a task to the command line.

<script src="https://gist.github.com/markwoodhall/2df11ee271d68f49b1e4.js"></script>

Now we can filter and sort our tasks based on the command line arguments we received and then `prn-task` for each of our tasks.

<script src="https://gist.github.com/markwoodhall/67ef86dc40762dfc54eb.js"></script>

All we need to do now is handle the `done` command so that we can complete a task.

First we see if we can find our task by the title passed in on the command line, if we can we set `:done?` to true and save the task.

<script src="https://gist.github.com/markwoodhall/2ebcae6a32991628e934.js"></script>

The `src/clj-tdo/handlers.clj` file as a whole should look like this.

<script src="https://gist.github.com/markwoodhall/df63689fd87e03d1d0a9.js"></script>

The code in its current state is available [here](https://bitbucket.org/markwoodhall/clj-tdo). In the next post we will make some improvements and see how we can create more concise, idiomatic clojure.

![tdo example](https://bytebucket.org/markwoodhall/clj-tdo/raw/604cdda72024a7aac64c348e28d2faa11a5168f0/tdo.gif)












