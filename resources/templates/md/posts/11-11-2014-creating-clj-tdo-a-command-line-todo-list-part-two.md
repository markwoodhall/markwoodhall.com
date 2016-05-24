{:title  "Creating clj-tdo, a command line todo list, part 2."
 :layout :post
 :date   "11-11-2014"
 :tags   ["clojure" "todo" "list"]}

In the [previous post](http://www.markwoodhall.com/2014/07/02/creating-clj-tdo-a-command-line-todo-list/) we created a very simple command line todo list in clojure.

In this post we will be making a few improvements. You can get the code in its current state from [here](https://bitbucket.org/markwoodhall/clj-tdo), update to the `part-1` tag.

###Pulling out task.clj

Lets start by pulling out some of the task related functionality into its own namespace. Create a new file `src/clj-tdo/task.clj`.

If we pull out the `Task` record, the `overdue?`,`due-on?` and `finish` functions we should end up with something like this.

<script src="https://gist.github.com/markwoodhall/561c501b801bcfd5feb2.js"></script>

I've also added a `create` function to get rid of the date mangling and task creation from `handlers.clj`.

We now need to make some changes to `handlers.clj` in order to make use of the functions we created in `task.clj`. First, we require `[clj-tdo.task :as task]. `

Then we need to update the usages of `overdue?`, `due-on?` and `finish` so that they reference the namespace. This should leave us with a `handlers.clj` like so.

<script src="https://gist.github.com/markwoodhall/6783d299310bd223af9d.js"></script>

I think its time to show the horrible `prn-task` function some love. In its current state, it looks like this.

<script src="https://gist.github.com/markwoodhall/937fae4503e60d600665.js"></script>

Initially we can start by moving it into `src/clj-tdo/task.clj`. We will also need to move the `style-str` function and the referenced `clansi.core` namespace. This doesn't really feel like the right place to put `style-str`, we will find somewhere better for it eventually. `src/clj-tdo/task.clj` now looks like this.

<script src="https://gist.github.com/markwoodhall/c30dd50f04ca5a9d39ea.js"></script>

I think we should improve `prn-task` by pulling out some of the repeated logic into a new namespace, lets create `src/clj-tdo/rendering.clj`. I think this is also a reasonable place to move the `style-str` function to. Lets start with this.

<script src="https://gist.github.com/markwoodhall/0d58ac0964912c86e2a6.js"></script>

Obviously we need to update `src/clj-tdo/task.clj` so that it uses `style-str` from `src/clj-tdo/rendering.clj`, I'll leave that out here though.

The next thing I'd like to do is remove the duplication of checking a condition and outputing a "checkbox". For that I'll create a `checkbox` function in `src/clj-tdo/rendering.clj`.

<script src="https://gist.github.com/markwoodhall/9d917a1c3f543617ffec.js"></script>

I'd also like to make padding strings a little neater. So I'll create `pad-right`.

<script src="https://gist.github.com/markwoodhall/782fe54ef32fa423a7cb.js"></script>

I also add a `field` function and then realise I can make use of it in `checkbox`.

<script src="https://gist.github.com/markwoodhall/53b2a648e145bfa915c3.js"></script>

Now, I update the `prn-task` function to make use of the functions we just created.

<script src="https://gist.github.com/markwoodhall/485ff5244da88bd921a1.js"></script>

Notice that I also made the "printer" a function argument, in our case we will be passing through `println` in `src/clj-tdo/handlers.clj`. I'm still not too happy with the style and colour mapping but we can look at that next time.

The code in its current state is available [here](https://bitbucket.org/markwoodhall/clj-tdo), update to the `part-2` tag.
