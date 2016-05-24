{:title  "Introducing clova, a small validation library for Clojure and ClojureScript."
 :layout :post
 :date   "17-11-2015"
 :tags   ["clojure" "clojurescript" "validation" "clova"]}

TL;DR

I wrote a small validation library for Clojure and ClojureScript. It's "alright" and it's called [clova](https://github.com/markwoodhall/clova), I'd appreciate any feedback over on [GitHub](https://github.com/markwoodhall/clova).

##About

[clova](https://github.com/markwoodhall/clova) is a small validation library written for Clojure and ClojureScript.

Existing libraries like [Prismatic Schema](https://github.com/Prismatic/schema) offer much more functionality but that may not be what is required. [clova](https://github.com/markwoodhall/clova) focuses more on targeted validation, like checking if something is a url or an email address, instead of schematic validation.

[clova](https://github.com/markwoodhall/clova) supports ClojureScript to enable scenarios like server and client side sharing of validation logic. To do so it makes use of [reader conditionals](http://dev.clojure.org/display/design/Reader+Conditionals) introduced in Clojure 1.7. Earlier versions used [cljx](https://github.com/lynaghk/cljx) but that is considered deprecated because of the language support for reader conditionals.

##How to use

Add the following dependency to `project.clj :dependencies`.

[![Clojars Project](http://clojars.org/clova/latest-version.svg)](http://clojars.org/clova)

Pull in the core namespace `(:require [clova.core :as core])`.

###Define a validation set

Validation sets are pairs of keys to validate and the functions used to validate them.

<script src="https://gist.github.com/markwoodhall/bce0cc499c7c6f4e3751.js"></script>

They support nested map access and validation functions can have variadic arity.

###Defining a validator

Validators are just functions with some meta data and are defined using the [defvalidator](http://markwoodhall.github.io/clova/clova.core.html#var-defvalidator) macro.

<script src="https://gist.github.com/markwoodhall/442996da139e1f539514.js"></script>

You can make use of the key name, value and any arguments passed to the validator in the `:default-message`. The only thing to consider is the ordering of arguments, when the validation message is formatted it will supply the values in the following order: 1. The key to validate, 2. The current value, 3. The arguments passed to the validator (in the order they are specified).

It is worth noting that using positional arguments of the format `%1$s` in `:default-message` is supported in Clojure only. The string format function used in ClojureScript `goog.string.format` does not support them.

###Using a validation set

Using a validation set is simple. Pass the validation set you want to use and the map you wish to validate.

<script src="https://gist.github.com/markwoodhall/48e91226ebff9a6c6f17.js"></script>

Result is a map, including a valid? flag and a sequence of results.

<script src="https://gist.github.com/markwoodhall/bbf879f9e2f8d5b3b751.js"></script>

You can view API documentation [here](http://markwoodhall.github.io/clova/).

###Built in validators
[clova](https://github.com/markwoodhall/clova) includes the following validators as of v0.4.0.

1. [between?](http://markwoodhall.github.io/clova/clova.core.html#var-between.3F)
2. [email?](http://markwoodhall.github.io/clova/clova.core.html#var-email.3F)
3. [greater?](http://markwoodhall.github.io/clova/clova.core.html#var-greater.3F)
4. [lesser?](http://markwoodhall.github.io/clova/clova.core.html#var-lesser.3F)
5. [matches?](http://markwoodhall.github.io/clova/clova.core.html#var-matches.3F)
6. [negative?](http://markwoodhall.github.io/clova/clova.core.html#var-negative.3F)
7. [positive?](http://markwoodhall.github.io/clova/clova.core.html#var-positive.3F)
8. [post-code?](http://markwoodhall.github.io/clova/clova.core.html#var-post-code.3F)
9. [present?](http://markwoodhall.github.io/clova/clova.core.html#var-present.3F)
10. [url?](http://markwoodhall.github.io/clova/clova.core.html#var-url.3F)
11. [zip-code?](http://markwoodhall.github.io/clova/clova.core.html#var-zip-code.3F)

###Positives

1. It is easy to create and test new validators, the built in validators are simple pure functions.
2. Error messages are specific. For example, instead of "Age must be in the specified range" we get "Age is 10 but it should be between 18 and 30".

###To do

~~* Custom validation messages, probably localisable.~~
#
~~* Composition of multiple validation functions per key.~~
* Make string interpolation for default messages more intuitive.

###Alternatives

[clova](https://github.com/markwoodhall/clova) is still new and prone to change, plus I'm still learning Clojure. Here are a couple of alternatives that are more stable.

[bouncer](https://github.com/leonardoborges/bouncer)
|
[validateur](https://github.com/michaelklishin/validateur)

