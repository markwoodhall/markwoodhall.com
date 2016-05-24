{:title  "Creating clj-tdo, a command line todo list, part 3."
 :layout :post
 :date   "19-11-2014"
 :tags   ["clojure" "todo" "list"]}

In the [previous post](http://www.markwoodhall.com/2014/11/11/creating-clj-tdo-a-command-line-todo-list-part-two/) we made some improvements to the command line todo list we created.

In this post we will be making a few more improvements. You can get the code in its current state from [here](https://bitbucket.org/markwoodhall/clj-tdo), update to the part-2 tag.

###Excluding finished tasks

I'm going to start off by fixing a few little issues. I want to change the default `ls` action to exclude finished tasks and instead use the `-f` option to show them.

First, lets change `src/clj-tdo/task.clj` so that it makes available a `finished?` function.

<script src="https://gist.github.com/markwoodhall/4bd7fc5afffba95d956f.js"></script>

`src/clj-tdo/core.clj`
 will need to change as well, in order to capture the new `-f` switch.

 <script src="https://gist.github.com/markwoodhall/dc5073fb3e9ada95d391.js"></script>

 Then we can update `src/clj-tdo/handlers.clj` so that `list-tasks` captures the `finished` switch and does the appropriate filtering.

 <script src="https://gist.github.com/markwoodhall/03beacbee412aea72b46.js"></script>

###Improving task printing

Create a new file `src/clj-tdo/printers.clj`. Here we are going to define a `TaskPrinter` [protocol](http://clojure.org/protocols).

<script src="https://gist.github.com/markwoodhall/0508e8aee1423d018bfd.js"></script>

The first implementation of this protocol will be very similar to the `prn-task` function in `src/clj-tdo/task.clj`, lets call it `DefaultTaskPrinter`.

<script src="https://gist.github.com/markwoodhall/4588cf8051d90d3a95ad.js"></script>

We can also create a convenience function to create a `DefaultTaskPrinter`.

<script src="https://gist.github.com/markwoodhall/66ac5de36bd48ce931b6.js"></script>

Now we can make use of this in `src/clj-tdo/handlers.clj`, first lets refer to the items we require.
```
[clj-tdo.printers :refer [TaskPrinter default-task-printer print-tasks]]
```

`list-tasks` can now make use of the printer.

<script src="https://gist.github.com/markwoodhall/e84789b738b9bf40f9df.js"></script>

#
####Adding a second printer and the `-p` switch

Now, we can create a second `TaskPrinter`. For this one we will just spit out the raw string as stored in the data file.

<script src="https://gist.github.com/markwoodhall/889fbb9174984b66d6d4.js"></script>

We can also remove the `default-task-printer` and replace it with `create-task-printer`. This will give us the `RawTaskPrinter` if we ask for it, otherwise, it will give us the `DefaultTaskPrinter`.

<script src="https://gist.github.com/markwoodhall/ecd2ebb96d8cbe334ee9.js"></script>

Now we need to hook up the `-p` switch and capture the "printer" we wish to use. Add the definition below to our `cli-options` in `src/clj-tdo/core.clj`.

<script src="https://gist.github.com/markwoodhall/c3f490fa1080c2062aa9.js"></script>

We also need to update the desctructuring of function arguments in `list-tasks` so that it captures the specified `printer` and update our `print-tasks` call so that is uses `create-task-printer`.

<script src="https://gist.github.com/markwoodhall/f46f98c66e83c9387259.js"></script>

#
###Identify a task with a short identifier

Currently tasks are identified and considered unique based on their `:title`. This has generally been ok for me so far but it is irritating when trying to run a `done` command like so.

```
tdo done -t "Some task with a long title and maybe some kind of punctionation?!"
```

It would be useful to be able to add a short title or identifier to a task. This is particularly useful for me as I can use an id from a bug tracker like [FogBugz](http://www.fogcreek.com/fogbugz/).

Lets start by updating the definition of the `Task` record in `src/clj-tdo/task.clj` to include an `id`.

<script src="https://gist.github.com/markwoodhall/271a1de7dd40298567d4.js"></script>

We will also need to update the `create` function so that it desctructures `id` and uses it in the `->Task` call.

<script src="https://gist.github.com/markwoodhall/ce7ef428648f9d361389.js"></script>

The logic that stores tasks in `src/clj-tdo/stores.clj` will also need to change. It currently filters out an existing task by title and then replaces it with its new equivalent. We will change this so that it uses the new `id`.

<script src="https://gist.github.com/markwoodhall/90bfc352b1079b5c28eb.js"></script>

Now we can update the `DefaultTaskPrinter` in `src/clj-tdo/printers.clj` so that it ouputs the new `id`.

<script src="https://gist.github.com/markwoodhall/1b375e316b43902fc4d0.js"></script>

The `do-task` function in `src/clj-tdo/handlers.clj` also has logic that identifies which task to mark as done, we need to change that to use the new `id` as well.

<script src="https://gist.github.com/markwoodhall/bb7b157c4ac2f061e7c1.js"></script>

All thats left to do now is update our `cli-options` in `src/clj-tdo/core.clj` to capture `-i` or `--id`.

<script src="https://gist.github.com/markwoodhall/728787de60bc0c27539b.js"></script>

#
###Improving documentation

The last thing we will change in this post is the definition of `help` in `src/clj-tdo/core.clj`. I think its useful to include a few examples of commands and switches.

<script src="https://gist.github.com/markwoodhall/391c42d6659ee649e1d8.js"></script>

I think we made some good changes in this post, specifically around printing. Next time it will be interesting to allow better status support and then make use of those statuses to print a "swim lane" style task board.

You can get the code in its current state from [here](https://bitbucket.org/markwoodhall/clj-tdo), update to the part-3 tag.


