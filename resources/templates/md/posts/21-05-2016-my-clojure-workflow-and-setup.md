{:title  "My Clojure Workflow and Setup."
 :layout :post
 :date   "21-05-2016"
 :image  "http://i.imgur.com/9TmA2s2.jpg"
 :tags   ["clojure" "vim" "workflow"]}

I've been using Clojure for at least a couple of years now, in that time I've jumped around various text editors. When I was first getting started I used [Light Table](http://lighttable.com/).

> Light Table is the next generation code editor. Light Table Connects you to your creation with instant feedback and showing data values flow through your code.

Looking back I think that was probably a good decision as it was easy to get started with but still offered a very rich and interactive experience.

Given that I already had experience with vim it made sense to try that next and I found the experience to be good. I did always have the feeling like I was missing something though. Emacs!

I always felt inclined to move to Emacs because of its superior lisp support, not to mention its programmability using Elisp. In the end I did end up sticking with vim, I'd already got too much invested in using vim at this point and not just for Clojure, ultimately it was a habit I just couldn't break and as it turns out I've ended up very happy with the Clojure support.

#vim plugins

##[vim-clojure-static](https://github.com/guns/vim-clojure-static)

>Meikel Brandmeyer's excellent Clojure runtime files, extracted from the VimClojure project for use with alternate Clojure REPL plugins.

>These files ship with Vim versions 7.3.803 and later, and are periodically merged into the official Vim repository.

Even though this ships with newer versions of vim I prefer to pull in the plugin from GitHub and keep up with development. As an example, support was added for `*.cljc` and `*cljx` files not that long ago.

##[rainbow_parentheses](https://github.com/kien/rainbow_parentheses.vim)

>Rainbow colors for parentheses, based on rainbow_parenthsis.vim of which there are multiple versions by Martin Krischik, John Gilmore, Luc Hermitte, and Steve Losh.

>This version uses significantly less code than the older ones (~80% less) and has new options to make it easier to change the colors and the parentheses depth.

Rainbow parentheses isn't exactly a *must have* plugin but I really like it, it helps identify start and end brackets using colour and has support for a number of bracket types. It looks cool too.

![parentheses](http://i.imgur.com/IbSfb74.png)

##[vim-fireplace](https://github.com/tpope/vim-fireplace)

> Clojure REPL support

> There's a REPL in fireplace, but you probably wouldn't have noticed if I hadn't told you. Such is the way with fireplace.vim. By the way, this plugin is for Clojure.

This is the main one for me really. Everything I do with Clojure in vim revolves around [vim-fireplace](https://github.com/tpope/vim-fireplace).

[vim-fireplace]() connects to a running nREPL server automagically using the .nrepl-port file generated by leiningen. You can tell it to connect manually using the `:Connect` command, in all honesty I've used this sparingly.

### Hot reloading

I find myself running the `:Require` command all of the time. It's the equivalent of running `require` at the REPL and specfying `:reload`. `:Require!` is much the same but specifies `:reload-all`.

### Documentation

The `:Doc` command takes a symbol to look up documentation for. e.g `:Doc reduce`.

![Doc](http://i.imgur.com/p9iDOKJ.gif)

`K` is mapped to call `:Doc` for the symbol under the cursor.

![Imgur](http://i.imgur.com/nE8rqxs.gif)

### Running tests

`:RunAllTests` executes `(clojure.test/run-all-tests)` and `:RunTests`
executes `(clojure.test/run-tests '$namespace)`, where `$namespace` is the namespace for the current file. `cpr` is mapped to `:RunTests`.

![Imgur](http://i.imgur.com/70z8iVR.gif)

Thanks to [@tpope](https://twitter.com/tpope)!

##[paraedit](https://github.com/vim-scripts/paredit.vim)

> Paredit performs structured editing of Lisp S-expressions in Vim. Paredit.vim is similar to paredit.el for Emacs. Paredit Mode tries to maintain the balanced state of matched characters (parenthesis marks, square and curly braces, double quotes).

paraedit is an essential plugin for me. Even if it only balanced "matched characters" that would be enough but it also supports "slurpage" and "barfage" (moving an opening or closing bracket to include or exclude an element from a list).

![Slurp&Barf](http://i.imgur.com/f5ZkMNH.gif)

##[vim-surround](https://github.com/tpope/vim-surround)

> Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.

While I **love** Paraedit I often find most pain when I want to remove brackets and it's balancing is preventing me from doing so. I use [vim-surround](https://github.com/tpope/vim-surround) to help with this. In the example below I use `ds(` to delete the surrounding bracket.

![delete surrounding](http://i.imgur.com/khdGmh4.gif)

I don't use [vim-surround](https://github.com/tpope/vim-surround) just for this though, or just for Clojure, it's an awesome vim plugin in general. Check it out.

Thanks to [@tpope](https://twitter.com/tpope)!

# lein plugins

##[ultra](https://github.com/venantius/ultra/)

> A Leiningen plugin for a superior development environment

### Colour in the REPL

![REPL Colour](http://i.imgur.com/rQBfHmA.png)

### Colour on source

![Imgur](http://i.imgur.com/gspklgb.png)

[ultra](https://github.com/venantius/ultra/) is awesome. It makes working in the REPL a real pleasure. There isn't much I can say about it, the images above do the talking.

Thanks to [@venantius](https://twitter.com/venantius)!

##[eastwood](https://github.com/jonase/eastwood)

> Eastwood is a Clojure lint tool that uses the tools.analyzer and tools.analyzer.jvm libraries to inspect namespaces and report possible problems.

I run `lein eastwood` for Clojure linting. I've not yet tried the [vim-eastwood](https://github.com/venantius/vim-eastwood) plugin but it's on my list of things to try.