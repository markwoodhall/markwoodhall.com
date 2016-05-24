{:title  "Event sourcing in Clojure."
 :layout :post
 :date   "04-05-2015"
 :tags   ["clojure" "event sourcing"]}

Recently I came across [a blog post](http://jen20.com/2015/02/08/event-sourcing-in-go.html) by [James Nugent](http://www.jen20.com) that described some example patterns for implementing event sourcing in Go. I'm no expert, I've not studied much Go code before and I've never written any but I'd certainly have to agree with the observation James made, there is much less code than some C# implementations.

James made available the [code](https://github.com/jen20/go-event-sourcing-sample) for his post on GitHub, so I thought it would be interesting to have a look and come up with a Clojure implementation based on the same domain. I'd suggest reading James [post](http://jen20.com/2015/02/08/event-sourcing-in-go.html) as this one will follow the same structure.

FWIW, the comparison between Go and Clojure is a bit of an odd one really, this is just a bit of fun.

####Events

As per James's post we will use a simplified domain model of a frequent flier. James uses mutable Go structures to define his events, we can make use of immutable Clojure records. We could probably just use Clojure maps but I'm planning to perform dispatch based on the event type, so a record or type is probably more suitable.

If we really wanted to use maps then we could probably attach some meta data to them using Clojures [with-meta](https://clojuredocs.org/clojure.core/with-meta) and then switch on that meta data. I don't think we need to worry about it though, Clojure records can be used as if they were maps in most scenarios.

######Go
<script src="https://gist.github.com/markwoodhall/ff71bcea3c59031502f2.js"></script>

######Clojure
<script src="https://gist.github.com/markwoodhall/b8fb86fd48a9c3b97466.js"></script>

Obviously the Clojure version of the events are dynamically typed, we could use [type hints](http://clojure.org/java_interop#Java%20Interop-Type%20Hints) if we really wanted to.

####Aggregates

In the Go example, James uses structs to represent aggregates and capture the state that will enable invariants during future behaviour, e.g. changing the frequent fliers status based on the stateful "tier points" value.
######Go
<script src="https://gist.github.com/markwoodhall/1c515599c88b8ab96f4f.js"></script>

######Clojure
<script src="https://gist.github.com/markwoodhall/92edcee1840945f32cd2.js"></script>

Its worth noting that the Go code above uses a `Status` enumeration to represent the frequent flier status, in the Clojure example I'll just be using the keys `:red`, `:silver` and `:gold`.

####State transition and change tracking

######Go
<script src="https://gist.github.com/markwoodhall/b46e79eaf4c96c328a55.js"></script>

######Clojure
<script src="https://gist.github.com/markwoodhall/f17dbe8e4e733a47a9bd.js"></script>

In general the Clojure version of the code implements the same pattern as the Go code. We call a function on the aggregate, perform some invariant checking if applicable, track the event and apply the "state" transition.

The Go version of the code switches based on the type of the event being processed and applies the state mutations.

<script src="https://gist.github.com/markwoodhall/de5e3fb3c663064aeb40.js"></script>

The Clojure version of the code uses a [multimethod](http://clojure.org/multimethods) to dispatch based on the event type being processed, each chunk of "state" mutation is isolated in its own function. Of course, when we say mutation that's not true, since really we just return a new version of the aggregate with the updated "state".

The Clojure code benefits from having no mutable state, each of the functions are pure in nature. James does mention in his post that having immutable records can make for a more elegant implementation. I'm not sure the Clojure version is "more elegant" but I think its pretty nice.

<script src="https://gist.github.com/markwoodhall/6c4c91a7003be80fdb0f.js"></script>

####Loading history
######Go
<script src="https://gist.github.com/markwoodhall/dd2ae7c3781da691facc.js"></script>

######Clojure
<script src="https://gist.github.com/markwoodhall/c9e0b3781389b517557e.js"></script>

In the situation where you need to hydrate an aggregate using a collection of past events I think the Clojure implementation is pretty neat. All we need to do is `(reduce transition ff history)`. We reduce the history of events using the transition function and an inital default state frequent flier. If we had a massive number of events we could probably even use Clojures fold [reducer](http://clojure.org/reducers), this would carry out the reduce operation in parallel. We also assoc in an expected version based on the history.

####Example usage
######Go
<script src="https://gist.github.com/markwoodhall/5eb46d9d6fc16da4dc3a.js"></script>

######Clojure
<script src="https://gist.github.com/markwoodhall/3b127c8b127ee43aac1f.js"></script>

Both of the above examples hydrate a frequent flier from a history of events and print out the aggregate. They then record another `FlightTaken` event so that the accumulation of tier points causes an upgrade to gold status.

####Conclusion
Have a look at both the [Go version](https://github.com/jen20/go-event-sourcing-sample) and the [Clojure version](https://github.com/markwoodhall/clj-event-sourcing-sample) and see what you think. I noticed a few things:

1. Lisp is beautiful (subjective at best)
2. Clojures immutability and built in support for things like map/reduce make things like hydrating an aggregate easy
3. Multimethods are quite a consice way of dispatching based on an event type
4. Go is a bit tricky to read but then again I am a total newbie

If you know Clojure then please let me know if I'm doing anything really stupid or not very idiomatic by [sending a pull request](https://github.com/markwoodhall/clj-event-sourcing-sample).

I'm going to write a Clojure follow up post with a more complicated domain model and a storage implementation, probably using [Event Store](https://geteventstore.com).
