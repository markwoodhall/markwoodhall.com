{:title  "Unifying server and client validation using Clojure[Script] and Clova."
 :layout :post
 :date   "16-05-2016"
 :image  "http://i.imgur.com/qj5aG47.jpg"
 :tags   ["clojure" "clojurescript" "clova"]}

[clova](https://github.com/markwoodhall/clova) supports both Clojure and ClojureScript, in this blog post we will create a simple [Compojure](https://github.com/weavejester/compojure) server that validates a request and we will apply that same validation on the client side.

I'll be pushing all the code for this post to [here](https://github.com/markwoodhall/clova-blog-post).

## Getting started

Let's start by creating a new project using `lein`.

```
lein new compojure clova-blog-post
```

Once we've done that let's make sure it compiles...

```
lein compile :all
```

.. and that the server starts up.

```
lein ring server
```

You should see a new window in your default browser open and load `http://localhost:3000`, displaying "Hello World".

The current state of the project should match [the v0.0.1 tag](https://github.com/markwoodhall/clova-blog-post/tree/v0.0.1).

Now that's out of the way, let's pull in the [clova](https://github.com/markwoodhall/clova) dependency. Open `project.clj` in your editor of choice (it's vim right?).

Once you've opened `project.clj` add `[clova "0.26.0"]` to `:dependencies` and run:

```
lein compile :all
```

Next, open `src/clova_blog_post/handler.clj` and `:require` [clova.core](http://markwoodhall.github.io/clova/clova.core.html).

<script src="https://gist.github.com/markwoodhall/001d6aaac3a0baa6b91326b0756a5dd8.js"></script>

## Our first validation set

For this blog post we will handle the `POST` of a simple to-do list model, let's declare the validation set for it.

<script src="https://gist.github.com/markwoodhall/e5055993d43aa785c7d4c7c44d0651d1.js"></script>

Validation sets are just sequences of keys followed by the functions that validate the key. Where a function requires arguments, such as the length value passed to `shorter?` it is wrapped in a sequence. Where map traversal needs to take place to get to the key to validate then we also wrap the key in a sequence, as in the `[:meta :category]` example.

In this validation set we make use of [`required?`](http://markwoodhall.github.io/clova/clova.core.html#var-required.3F), [`stringy?`](http://markwoodhall.github.io/clova/clova.core.html#var-stringy.3F), [`shorter?`](http://markwoodhall.github.io/clova/clova.core.html#var-shorter.3F), [`longer?`](http://markwoodhall.github.io/clova/clova.core.html#var-longer.3F) and [`date?`](http://markwoodhall.github.io/clova/clova.core.html#var-date.3F).

By default [clova](https://github.com/markwoodhall/clova) is somewhat relaxed about it's validation. Unless explicitly told by the use of [`required?`](http://markwoodhall.github.io/clova/clova.core.html#var-required.3F) all keys are considered to be optional.

[`stringy?`](http://markwoodhall.github.io/clova/clova.core.html#var-stringy.3F) does what it says on the tin, checks for the presence of a string like value.

[`shorter?`](http://markwoodhall.github.io/clova/clova.core.html#var-shorter.3F) works on strings and sequences and checks that a given value has a length shorter than X.

[`longer?`](http://markwoodhall.github.io/clova/clova.core.html#var-longer.3F) works on strings and sequences and checks that a given value has a length longer than X.

[`date?`](http://markwoodhall.github.io/clova/clova.core.html#var-date.3F) checks an input value to see if it is a date.

Now, let's compile again.

```
lein compile :all
```

At this point you will probably get an exception.

```
Exception in thread "main" java.lang.RuntimeException: No such var: c/equal?, compiling:(clova/core.cljc:267:7)
```

This is because [clova](https://github.com/markwoodhall/clova) makes use of [clj-time](https://github.com/clj-time/clj-time), as does [Compojure](https://github.com/weavejester/compojure). Unfortunately [Compojure](https://github.com/weavejester/compojure) pulls in an old version without the `equal?` function. We can fix this by excluding [clj-time](https://github.com/clj-time/clj-time) when we reference [Compojure](https://github.com/weavejester/compojure), like so:

<script src="https://gist.github.com/markwoodhall/f5dc3542781e4f07a01d228273789c7a.js"></script>

Notice the `:exclusions` key for [Compojure](https://github.com/weavejester/compojure).

After this run:

```
lein clean
lein compile :all
```

Everything should be good again now. The current state of the project should match [the v0.0.2 tag](https://github.com/markwoodhall/clova-blog-post/tree/v0.0.2).

Now, let's setup `handler.clj` for JSON requests/responses and enable [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS). To start with we need to add   `[ring/ring-json "0.4.0"]` to our `:dependencies` in `project.clj`, then we update our `ns` declaration in `handler.clj` to refer to `handler`, `response`, `wrap-json-response` and `wrap-json-params`, like so:

<script src="https://gist.github.com/markwoodhall/175cc91863a1869c7fd2c84d5fc6c4fd.js"></script>

Still editing `handler.clj` we create a couple of middleware functions to support [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS).

<script src="https://gist.github.com/markwoodhall/cb41a8998d74568310fefb5545cbad6d.js"></script>

Then we define our `app` to make use of both the middleware functions and our imported JSON functions.

<script src="https://gist.github.com/markwoodhall/90accbcd6e3549b8bb62194d645bd6a5.js"></script>

We can now remove the default GET route:

<script src="https://gist.github.com/markwoodhall/2db4ef99f60f988dac995116b151f7d3.js"></script>

Replacing it with a POST route for our to-do item.

<script src="https://gist.github.com/markwoodhall/414745ab7bb9f7301792801fd096cc58.js"></script>

Here, we validate the payload using the `to-do-validation` set we created earlier. If it is `valid?` we return the payload and a 200 status code, if it is not `valid?` we return the `:results` of the validation and a 400 status code.

##Testing the server

If we make a valid request to our handler, like so:

<script src="https://gist.github.com/markwoodhall/339b4e05733a7bccb39b8e41b286d060.js"></script>

We should see the payload in the response:

<script src="https://gist.github.com/markwoodhall/1e87bc28fa15d3c8e7342e3174ab9abc.js"></script>

If we make an invalid request to our handler by passing an invalid date value, like so:

<script src="https://gist.github.com/markwoodhall/ccd2989426f604c478c203d89fae43e4.js"></script>

We should see the validation results in the response:

<script src="https://gist.github.com/markwoodhall/c46335654bd76514fd6573a11411243d.js"></script>

With our server side validation working we can now move onto the client side. The state of the project currently should match [the v0.0.3 tag](https://github.com/markwoodhall/clova-blog-post/tree/v0.0.3)

##Client side

Clojure 1.7 introduced [reader conditionals](http://dev.clojure.org/display/design/Reader+Conditionals), these allow us to reuse as much code as possible across the various Clojure platforms.

In order to make our validation logic useable on the Clojure and ClojureScript platform we need to move it to a `*.cljc` file, which is loadable by both Clojure and ClojureScript, let's do it.

First we need to create `validation.cljc`.

```
vim src/clova_blog_post/validation.cljc
```

Then, let's move our `to-do-validation` definition to that file. It should look like this:

<script src="https://gist.github.com/markwoodhall/b5fcc2b64dbf326001a508b880833cd9.js"></script>

We need to update `handler.clj` to refer to `to-do-validation`, we can add the following to`:require`.

```
[clova-blog-post.validation :refer [to-do-validation]]
```

Just to verify our changes we can restart the server and run our `curl` tests again.

With that out of the way we can open `project.clj` and add the ClojureScript dependency by adding `[org.clojure/clojurescript "1.8.51"]` to `:dependencies`.

If you are new to ClojureScript it is worth checking out the [Quick Start wiki article](https://github.com/clojure/clojurescript/wiki/Quick-Start). We will start by getting a generic "Hello world" to print to the browser console.

First, let's bootstrap the ClojureScript build.

```
vim src/clova_blog_post/build.clj
```

<script src="https://gist.github.com/markwoodhall/9af2a022714a75d2bd20b15bdf817b3b.js"></script>

This is pretty self explanatory, we give it the path the build, the output path and specify a main entry point `clova-blog-post.client` (which we will define later).

I usually wrap this with a shell script.

<script src="https://gist.github.com/markwoodhall/3ee6fb9a1b91a169b3760454a7458871.js"></script>

Now we can create the `clova-blog-post.client` entry point:

```
vim src/clova_blog_post/client.cljs
```
<script src="https://gist.github.com/markwoodhall/e0fb9c1b50617fad9db48d5f619c8c0b.js"></script>

All we do here is enable console printing and write "Hello world", with that done we can create `index.html` and reference our compiled JavaScript.

```
vim index.html
```
<script src="https://gist.github.com/markwoodhall/1dce13aeb5942e1528e4a0936903df82.js"></script>

If you open `index.html` in your browser of choice you should see "Hello world" output to the developer console. (party)

Finally, let's hook up our validation.

```
vim index.html
```

<script src="https://gist.github.com/markwoodhall/f3f9ecb498626016bf8e8fb0dd7e1d6e.js"></script>

Here we add a few text fields to build our to-do and then a text area to dump our validation results to.

Now let's validate those text fields.

```
vim src/clova_blog_post/client.cljs
```
<script src="https://gist.github.com/markwoodhall/0b493c8721f626b5fa2c330c8b834c54.js"></script>

Here we pull out the values from our text boxes and build up our to-do map. Then we use exactly the same validation as we did on the server side (`to-do-validation`) and dump the results to our text area.

##Rounding up
I'm going to cut this short as it's already gone on way too long and we have worked through a simple example of using the same validation logic on the client and the server, even if we've not implemented any interaction between them, the principal remains the same.

Obviously this is a very simple example, we can handle much more complex validation and give a rich experience on the client side while still keeping the integrity of our data using server side validation. All this with as much re-use as possible for our core validation logic.

The state of the project currently should match [the v0.0.4 tag](https://github.com/markwoodhall/clova-blog-post/tree/v0.0.4)


