{:title  "Destructuring in Clojure."
 :layout :post
 :date   "23-06-2014"
 :tags   ["clojure"]}

> [Clojure desctructuring](http://clojure.org/special_forms#Special Forms--Binding Forms (Destructuring)) - Clojure supports abstract structural binding, often called destructuring, in let binding lists, fn parameter lists, and any macro that expands into a let or fn. The basic idea is that a binding-form can be a data structure literal containing symbols that get bound to the respective parts of the init-expr. The binding is abstract in that a vector literal can bind to anything that is sequential, while a map literal can bind to anything that is associative.

##Sequential binding destructuring

More often called "Vector binding destructuring" this allows us to bind names to parts of sequential things.

A typical example may be.

<script src="https://gist.github.com/markwoodhall/9905812da129b8eb05e2.js"></script>

Here we assign the names a, b and c to the items in a vector. The example above outputs `[1 2 3]```.

We can also capture parts of a sequential item and make the item as a whole available.

<script src="https://gist.github.com/markwoodhall/e416048722c9936aa24a.js"></script>

Here we capture the first two parts of the sequence as a and b while making available the whole sequence `:as` v. The example above outputs `{:a 1 :b 2 :v [1 2 3 4 5]}```

Sequential binding destructuring is not limted to vectors or lists, it can be used for anything that supports `nth```.

We can use it on strings.

<script src="https://gist.github.com/markwoodhall/9212da5aef418804556b.js"></script>

Again we capture the first two parts of the sequence as a and b while making available the whole sequence `:as` s. The example above outputs `{:a \d :b \e :s "destructuring"}```.

## Map binding destructuring
This allows us to bind names to parts of a map.

<script src="https://gist.github.com/markwoodhall/64829e8ee717139140c2.js"></script>

Here we capture the values of the `:a` and `:b` keys from the map. This outputs `30```.

The same principals discussed in relation to sequential binding apply to map binding as well.

So, we can make available the whole map as follows.

<script src="https://gist.github.com/markwoodhall/371bdc06b7f76a08248f.js"></script>

Again we capture `:a` and `:b` but we also make the whole map available using `:as` m.

When we want to desctructure to bindings with the same name as map keys we can make this more concise by using `:keys```.

<script src="https://gist.github.com/markwoodhall/069717b7edbabb5cb599.js"></script>

##Destructuring function arguments

We can also destructure function arguments. As an example we can define a function like so.

<script src="https://gist.github.com/markwoodhall/dfcbf2521354c30d04ea.js"></script>

Then we can call it.

<script src="https://gist.github.com/markwoodhall/2cc7943e15707561691d.js"></script>

We can use what we learnt above to make available the whole map as well.

<script src="https://gist.github.com/markwoodhall/86267845b9e9d4db76c7.js"></script>

Now we can call it like this.

<script src="https://gist.github.com/markwoodhall/355946019515a9570273.js"></script>

What if we want to apply some default values?

<script src="https://gist.github.com/markwoodhall/daf14377c1934603889b.js"></script>

We can use `:or` to define default values to use if the keys are not present in the map.

We can call it like this.

<script src="https://gist.github.com/markwoodhall/1e6798950a259e074fcf.js"></script>

We can even add `:pre` conditions based on the destructures.

<script src="https://gist.github.com/markwoodhall/b038170c6ed9da2a9425.js"></script>

Calling like so will result in a `AssertionError`.

<script src="https://gist.github.com/markwoodhall/a9cf776c3089e7cfc1f6.js"></script>

