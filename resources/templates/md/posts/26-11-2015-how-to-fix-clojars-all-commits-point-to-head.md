{:title  "How to fix Clojars all commits point to HEAD."
 :layout :post
 :date   "26-11-2015"
 :tags   ["clojure" "clojars"]}

Recently I noticed an issue with one of the projects I deploy to Clojars. The "Pushed by with this commit" link was only ever linking back to HEAD on the GitHub repo.

###Before

![Clojars-before](http://i.imgur.com/r0b3iWI.png)

This only happens when you specify an `:scm` key in your `project.clj`. Without the `:scm` key Leiningen will automatically discover the details from `.git`. I believe the `:scm` key was added for people using other systems, like HG.

I think there is a bug somewhere in Leiningen where the SCM info added to the artifacts `pom.xml` isn't generated correctly when there is an `:scm` key present. As soon as I removed the `:scm` key with [this commit](https://github.com/markwoodhall/clova/commit/9cbc6bab1dc00fdd8e743f280a2ad0c294a857ef) and did another Clojars deployment the problem was "fixed".

###After
![Clojars-after](http://i.imgur.com/Zx9iTP7.png)

