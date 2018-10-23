{:title  "Thoughts 9 months after switching to Vim for .NET."
 :layout :post
 :date   "13-11-2014"
 :tags   ["vim" ".net"]}

It was about 9 months ago that I first started trying to invest in using Vim. Up to then I'd spent nearly 100% of development time in Visual Studio. If I was playing around learning something new then I might use Sublime Text.

My first experience of Vim was some years ago and it was very brief, at the time I was doing some development in PHP and I remember, when initially firing up vim, thinking I'd downloaded the wrong thing. I moved quickly onto NuSphere PhpEd.

Fast forward a good few years and I decided to spend some time getting comfortable in Vim, initially by doing Clojure development. Once I felt comfortable I was ready to give .NET a go, hopefully I'd be productive enough to use it for the day job as well.

At this point I was mostly using terminal Vim on Windows. With the fantastic [ConEmu](https://code.google.com/p/conemu-maximus5/) I was able to get a really great setup with decent colour support in the terminal.

##Essential Plugins

* [OmniSharp](http://www.omnisharp.net/)

OmniSharp is just awesome. It is made up of a [client](https://github.com/OmniSharp/omnisharp-vim) and [server](https://github.com/OmniSharp/omnisharp-server). The client consumes an API exposed by the server over HTTP. There are clients available for a number of text editors that allow us to make use of functionality from [NRefactory](https://github.com/icsharpcode/NRefactory).

It gives us the following:

-	Code completion
-   Find types, implementations and usages
-   Refactoring suggestions
-   Building
-   Test runner

There is way more though, have a look at the [OmniSharp](https://github.com/OmniSharp/omnisharp-vim) github page.

* [ctrlp](https://github.com/kien/ctrlp.vim)

ctrlp is a fuzzy file search plugin, for ReSharper users it gives you functionality like "Go to File". I use ctrlp so much, especially when I'm working on a project that follows good structural and naming conventions.

Again, this is very brief, there is much more to ctrlp so go and [check it out](https://github.com/kien/ctrlp.vim).

* [NerdTREE](https://github.com/scrooloose/nerdtree)

Although I'm finding files 99% of the time using CtrlP sometimes I do need that help you get from looking at a visual tree of files. NerdTREE allows easy file/directory navigation and manipulation. These days though I'm only using it to get a mental picture of the structure of unfamiliar projects.

* [neocomplete](https://github.com/Shougo/neocomplete.vim)


In order to get code completion as you type you can install the neocomplete plugin, it is a little bit more complicated to install than some other plugins and it requires that you have a Vim install with Lua enabled.

##Improving the experience


I think thats probably it for essential plugins, there are however a few more plugins that really improve the experience.

* [Exuberant Ctags](http://ctags.sourceforge.net/)

This isnt actually a plugin but a command line utility that generates an index of all identifiers (tags) in a project, so for C# we end up with an index of classes, interfaces, methods etc. Using Vim you can easily navigate a project by tags. I like mapping `<leader>}` to jump to the tag under the cursor. [ctrlp](https://github.com/kien/ctrlp.vim) also has support for fuzzy match searching of tags.

* [vim-csharp](https://github.com/kien/ctrlp.vim)

vim-csharp has a bunch of useful functionality for working with C# in Vim. I just use it as it provides better syntax highlighting than standard.

* [syntastic](https://github.com/scrooloose/syntastic)

Syntastic is an awesome syntax checking plugin for Vim, it has support for lots of languages and shows syntax errors in a number of ways.

- A list of syntax errors in the location list
- Shows the syntax error for the position of the cursor in the command window
- Signs are displayed in the gutter for lines with syntax errors
- Error ballons when the mouse is hovered over a syntax error
- Parts of a line have syntax errors highlighted

##Scaffolding
In order to scaffold .NET solutions I'm making use of [grunt-init](http://gruntjs.com/project-scaffolding). Its really easy to create templates of common .NET projects.

##Scripting

While [OmniSharp](http://www.omnisharp.net/) provides good functionality for building and testing I decided to write a few simple scripts to handle that for me.

Initially these were PowerShell scripts. Since I was using the bash bundled with [mysysgit](http://msysgit.github.io/) as the shell for ConEmu I created bash aliases to make calling them simpler.

The following are the bash aliases I setup.

`rmsb` - Recursively calls msbuild for all *.sln files in the current directory.

`rtest` - Recursivly calls common tests runners for all *.Tests.\*.dll in the current directory.

`rbt` - Calls rmsb and rtest

`autocmd $cmd` - Watches the current directory for changes to \*.cs|\*.csproj|*.config etc and calls the specified command. So `autocmd rbt` watches and triggers a build/test when there are changes.

##Rolling with it

I settled on this setup and stuck with it for 4-5 months. It was generally pretty awesome and I felt as productive as I was before. I was working on both personal projects and projects for my day job, developing great software at [ByBox](http://www.bybox.com/).


####Little niggles
There were however a few little problems, some of them I'd spent a ridiculous number of hours trying to fix.

The biggest thing that I couldn't easily manage outside of Visual Studio was installing NuGet packages that had a dependency on the DTE environment, to this day there still isn't a good story for that.

I was also feeling a bit limited by terminal support in Windows and I had some annoying screen rendering issues with ConEmu and Vim. It was totally useable but I wanted it to be better.

##Big changes

I'd seen screenshots and videos of other people using similar setups on Linux and OS X and everything was much more polished. I decided I should try it out, so instead of using my Windows VM I started using OS X on my iMac.

Now, I knew I could roll with using Mono for my personal projects but I also knew that wouldn't be possible for the day job. Even if I could reliably build all the projects with Mono, all of the related scripting would be reliant on PowerShell and Windows.

In an ideal world I'd have setup an SSH server on Windows, used iTerm2, SSH'd to the Windows box and called it a day but I had endless problems with terminal colors and weird cursor behaviour and a host of other little things.

So, in the end, I decided I should do as much as possible on OS X and decided on the following:


####OS X
- iTerm2/Tmux/Vim (With all the above mentioned plugins)
- Source code (hg/git)
- Port the `autocmd` alias mentioned above to bash
- Bash scripting to `tar`, `gzip` and `scp` the current working directory to a mirror location on a remote box
- Aliases to make `scp` operations easier.
	- `scpmk` - Does a full copy of the working directory over SSH
    - `scpwd` - Does a partial copy of the working
   directory over SSH based on differences reported by hg or git
   - `srcpd $pattern` - Does a copy of remote files matching `$pattern` via SSH to the working directory
- Aliases for `rmsb` and `rbt` that run over SSH and so build and test on Windows
- The `rmsb` alias starts a background job to `srcpd /Packages/*` so that NuGet packages are pulled down to OS X and the OmniSharp server can find them for code completion. If I had access to corporate VPN from OS X I'd just run NuGet locally and be done with it



####Windows
- Msbuild, test runners, iisexpress, sql server
- Sql server management studio (I am using the [dbext plugin](https://github.com/vim-scripts/dbext.vim) for Vim to run basic queries)
- VPNS required for work that aren't compatible with OS X (Also aliased for easy use over SSH)
- SSH server

This structure makes it possible to:

1. Clone a project on OS X using hg/git
2. Init that project on the remote Windows box, using `scpmk`
3. Start an `autocmd rbt` in bash on OS X
4. Make some code changes using Vim on OS X
5. The `autocmd rbt` picks up the change, does an `scpwd` to copy the differences to the remote windows box and then issues the `rbt` command over SSH to run a build and test
6. Commit changes from OS X using hg/git

This is all much nicer than it sounds and using the tools outside of Windows has been a much better experience. Keep in mind that I'm jumping through hoops that aren't relevant if you just make use of Mono, I can't really get away without building and testing on a Windows box.

Many of these issues will hopefully go away as the [.NET platform becomes more open and we get compatability with Linux and OS X](http://news.microsoft.com/2014/11/12/microsoft-takes-net-open-source-and-cross-platform-adds-new-development-capabilities-with-visual-studio-2015-net-2015-and-visual-studio-online/). Its a great time to be doing .NET development.

##The positives

- Transferable knowledge

Using Vim as a primary editor for a variety of languages means that none of the investment is wasted. If you move onto a different language in the future its pretty certain Vim will have support for it.

- The command line

Working using a combination of iTerm2, Tmux, Vim and SSH is really quite nice. It forces you to learn more about the command line and become less reliant on the mouse, ultimately I think this is a productivity win.

- Cross platform editor

Since Vim is cross platform, again, the investment put into learning it means that you can take your development skills anywhere. Version controlling your dot files makes this pretty easy.

- Not relying on Visual Studio

There is nothing wrong with Visual Studio but I think breaking the reliance is a good thing. Being able to do development in whatever environment suits you is a liberating feeling.

- Using Vim every day

Not only is it totally awesome but it started a chain of learning that I think will change the way I develop for the better.

##The negatives

- NuGet support

While there is some level of NuGet support outside of Visual Studio you can't rely on it for everything. Packages that use Visual Studios DTE will be problematic.

- Pairing

Pairing with colleagues who may have an expectation that you are using Visual Studio can be awkward.

- Debugging

Visual Studio has an awesome debugger. In some scenarios I'll fire it up just to debug an issue but mostly I've found that making subtle improvements to logging and tests not only help investigate the issue but also have a positive impact in the long term.

Here are a couple of videos.

<iframe width="420" height="315" src="//www.youtube.com/embed/bl58hR1FpAI" frameborder="0" allowfullscreen></iframe>

<iframe width="420" height="315" src="//www.youtube.com/embed/73B3QHMqNRs" frameborder="0" allowfullscreen></iframe>









