{:title  "Using New Relic to monitor non web based Clojure applications."
 :layout :post
 :date   "25-02-2015"
 :tags   ["clojure" "new relic"]}

Recently I wanted to use [New Relic](http://newrelic.com/) to monitor and profile a Clojure application. This specific application was a "sentiment agent" running as a daemon and calculating the sentiment of various URLS.

The rest of this post assumes that you've already created a [New Relic](http://newrelic.com/) account and installed the [New Relic](http://newrelic.com/) agent for your platform of choice.

In order to record basic information in [New Relic](http://newrelic.com/) all I needed to do was start my application using `newrelic.jar` as the `-javaagent`. While not perfect I decided that I'd bundle `newrelic.jar` and `newrelic.yml` with my application, so I commited them to BitBucket.

```
java $JVM_OPTS -javaagent:newrelic/newrelic.jar -cp newrelic/newrelic.jar -jar target/sentimizer.jar
```

This is enough to get basic metrics like memory and CPU but I'm used to using [New Relic](http://newrelic.com/) for web applications and exploring the data it captures for "Transactions".

This [blog post](http://blog.newrelic.com/2012/11/13/setting-up-custom-instrumentation-using-the-new-relic-java-agent/) provides instructions for adding custom instrumentation to Java applications. All we really need to do is make sure `newrelic.jar` is on the class path and that we have set `enable_custom_tracing` equal to `true`. Then we can `import com.newrelic.api.agent.Trace;` and decorate the method we wish to consider a transaction with the `@Trace(dispatcher=true)` annotation. The `dispatcher=true` part is what tells [New Relic](http://newrelic.com/) that we should consider this to be a new transaction.

As luck would have it, Clojure also has support for annotations. As far as I understand to be able to use annotations as we require, we need to use a record or type in Clojure. I just came up with the simple record below.

<script src="https://gist.github.com/markwoodhall/d27c8957396caf172cce.js"></script>

This allows us to use a `Profiler` to wrap any function and have its execution recorded as a [New Relic](http://newrelic.com/) transaction. Like so:

<script src="https://gist.github.com/markwoodhall/fd1295f7b51ff0f0dce7.js"></script>

Instrumenting our function like this gives us much more detail. We will be able to see throughput and timings as well as a whole host of information relating to external resources, like databases, HTTP apis etc.

As an added bonus we can also uses [New Relics "Thread Profiler"](http://newrelic.com/thread-profiler) to profile and find hot spots in our Clojure application.

Thanks to [Sean Corfield](http://corfield.org/blog/post.cfm/instrumenting-clojure-for-new-relic-monitoring) for documenting his efforts.

