{:title  "Command line applications in Clojure."
 :layout :post
 :date   "26-06-2014"
 :tags   ["clojure"]}

This post assumes clojure and leiningen are already installed.

The code for this post is available [here](https://bitbucket.org/markwoodhall/cli-test).

##Creating the project

First, we create a new project using the default leiningen template.

```
lein new default cli-test
```

Now, `cd` into  `cli-test` and lets edit `project.clj`. I'm using vim but any editor is fine.

```
vim project.clj
```

We want to add a dependency to the clojure [tools.cli](https://github.com/clojure/tools.cli) library. There isn't much of a description to quote for the [tools.cli](https://github.com/clojure/tools.cli) library but here it is anyway.

>Tools for working with command line arguments.

At the time of this post the current version of [tools.cli](https://github.com/clojure/tools.cli) is `0.3.1`. Add `[org.clojure/tools.cli "0.3.1"]` to the project `:dependencies`.

While we have `project.clj` open lets also tell it where the entry point for our command line app is going to be. Add a `:main` key and give it the value `cli-test.core`.

We should now have a project file that looks something like the one below.

<script src="https://gist.github.com/markwoodhall/557ec2060c08e4fefc69.js"></script>

Now, lets edit `src/cli_test/core.clj`.

```
vim src/cli_test/core.clj
```

We will make use of clojure AOT compilation here and add a `:gen-class` directive.

>An optional :gen-class directive can be used in the ns declaration to generate a named class corresponding to a namespace. (:gen-class ...), when supplied, defaults to :name corresponding to the ns name, :main true, :impl-ns same as ns, and :init-impl-ns true. All options of gen-class are supported. [more](http://clojure.org/compilation)

The usage of `:gen-class` tells clojure to AOT compile a java class. For clarity we explictly use `:main true` to `:gen-class` a class with a `main` method, this is not required as `:main` defaults to true. We also need to hook up this `main` function, so, we define `-main`.

The reason we use `-main` is because of convention. The generated `main` function is effectively a stub that will look for a function of the same name but prefixed with a `-`.

If we wanted to use a different prefix we could change our usage of the `:gen-class` directive, like so.

<script src="https://gist.github.com/markwoodhall/4efe6d997c7aaa4f2013.js"></script>

Our `-main` function simply prints back the arguments we pass it.

<script src="https://gist.github.com/markwoodhall/75d81577786afc86595c.js"></script>

If we do a `lein compile :all` we can then try to run our application. We can do so using the leiningen run command `lein run hello mark` or we can generate a jar file using `lein uberjar` and then execute that jar using `java -jar target/cli-test-0.1.0-SNAPSHOT-standalone.jar hello mark`.

Generally I prefer to use `lein run` but in some situations I've found it easier to manage more complex command line arguments by using `java -jar`.

## A sprinkling of tools.cli

Now that we have a simple command line application we can start to make use of [tools.cli](https://github.com/clojure/tools.cli).

We will create the structure for a command line application that represents a HTTP server and supports the following commands.

```
start ;; Start a HTTP server on port 8080 by default
```
```
stop ;; Stops a HTTP server on port 8080 by default
```

The application will print help when it receives an unexpected command or when it receives the -h option.

First, lets define a vector of options our application accepts. We will accept `-p` or `--port` as options to the `start` and `stop` commands to specify the port.

<script src="https://gist.github.com/markwoodhall/ecaf3a9ca09ec9cb6431.js"></script>

Note that we can also define a `:default` value, a `:parse-fn` that will parse the option value and a `:validate` function that will validate it.

Now, lets define a function that can give us some option context help.

<script src="https://gist.github.com/markwoodhall/a51769c79e80671798ff.js"></script>

We need to modify the namespace declaration to require `clojure.string` and `clojure.tools.cli`.

<script src="https://gist.github.com/markwoodhall/447568809b379412937d.js"></script>

We can now make use of the `parse-opts` function from `clojure.tools.cli`. As the name suggests, this function will parse the command line arguments against the `cli-options` we defined earlier. It will return a map containing:

```
:options ;; The parsed options
:arguments ;; The non option based arguments
:summary ;; A summary of the options
:errors ;; Any errors
```
To demonstrate this lets change our `-main` function to call `parse-opts` and print the results.

<script src="https://gist.github.com/markwoodhall/3859a4d3fe159edb4e92.js"></script>

When we do a `lein run` we should see the following printed.

<script src="https://gist.github.com/markwoodhall/7b749ede5f35ee0dd98f.js"></script>

If we do a `lein run start -p 8089` we should see the print changes.

<script src="https://gist.github.com/markwoodhall/c01b8016d9b8b58e747a.js"></script>

Now we can see our arguments and options are getting parsed lets do something useful and wire up the help.

<script src="https://gist.github.com/markwoodhall/8dee77acb465b5e7ff56.js"></script>

Note. We also defined an `exit` function that simply displays a message and sets the exit code.

If we do another `lein run` or a `lein run -h`  we should get our awesome help printed out.

Lets see if we can handle our `start` command now.

<script src="https://gist.github.com/markwoodhall/b3b0e572490e9bc5ff6c.js"></script>

All we needed to do was add a case statement to handle our `start` command. We also pulled out the `:port` value from our `options` map.

We can handle the `stop` command in the same way.

<script src="https://gist.github.com/markwoodhall/91402116a5513331f57e.js"></script>

##A little bit of tweaking

While this is quite nice, I think it would be better if we define a map of our handlers.

<script src="https://gist.github.com/markwoodhall/857120dcefb3026f7a3f.js"></script>

Then in our `-main` function we can just lookup the handler.

<script src="https://gist.github.com/markwoodhall/d85d9a545d66ae12290b.js"></script>

All we do here is turn the first argument, in our case `start` or `stop`, into a keyword using the [keyword](http://clojuredocs.org/clojure_core/clojure.core/keyword) function.

The doc string for `keyword` says

>Returns a Keyword with the given namespace and name. Do not use :
in the keyword strings, it will be added automatically.

Once we have the keyword we can lookup its value from the `handlers` map.

##The unhappy path

So far we have only really handled the happy path. What happpens if we try to run an unknown command, for example `lein run unknown -p 1234`.

At the moment this will throw a `NullPointerException` as we don't have a handler defined for the `unknown` command.

Lets fix that.

<script src="https://gist.github.com/markwoodhall/79947d98a806711ee2fd.js"></script>

If we cant find a handler we print the help.

There is also another issue, even though we defined `parse-fn` and `validation` functions for our `-p` or `--port` option we aren't doing anthing to handle the errors they generate. We have to explicitly handle these.

If we run `lein run start -p fred` we will get the output.

```
Starting HTTP server on port 8080
```

Notice that the default value is used because our `-p` option was invalid. It would be better it we notified the user of this.

<script src="https://gist.github.com/markwoodhall/826ef80c287d9c4bb8ed.js"></script>

We add an extra test to our `cond`. If there are any errors then we exit with the appropriate error message. We also add an `error-msg` function that wraps our errors.

If we run `lein run start -p fred` this time we get the output.

```
Error while parsing option "-p fred": java.lang.NumberFormatException: For input string: "fred"
```

If we run `lein run start -p 100000` then we get the output.

```
The were errors processing the command line arguments

Failed to validate "-p 100000": Must be a number between 0 and 65536
```
