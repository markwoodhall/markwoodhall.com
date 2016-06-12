{:title  "OmniSharp-Vim and Completion Snippets"
 :layout :post
 :date   "12-06-2016"
 :image  "http://i.imgur.com/cSUS4mV.gif"
 :tags   ["omnisharp" "vim" "completion" "snippets" ".net"]}

I'm really happy that I finally managed to get a long running PR for the
[omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim) plugin merged into master. I started work on it about 12
months ago but it took some time to get it merged and the pull request became
stale and needed some attention. During those 12 months I had a lot of
positive feedback from people that really wanted to get the functionality
merged and I spent a lot of time using it every day. This post explains a bit about
the functionality and how it works.

## What does it do

As far as I know the first [OmniSharp](http://www.omnisharp.net/) plugin to have this functionality was
[omnisharp-emacs](https://github.com/OmniSharp/omnisharp-emacs), I was first made aware of it by [@jasonimison](https://twitter.com/JasonImison).
What the functionality does is use the concept of snippets to aid auto completion.
Selecting a completion on a function that accepts arguments will cause a
dynamic snippet to be expanded and in the case of vim place you in
SELECT mode on the first argument to the function. At this point the functionality of
the snippet engine takes over and you can jump to different arguments with ease. I think this is much
easier to explain graphically.

I've included KeyCastr captures below. It's also worth pointing out I have C-j mapped to
jump to the next snippet placeholder.

### Dotted access

![Dotted Access](http://i.imgur.com/cSUS4mV.gif)

### Constructor calls

![Constructors](http://i.imgur.com/ZpUsClz.gif)

### Single function calls

![Function](http://i.imgur.com/FaVslDS.gif)

### Multiline dotted access

![Multiline](http://i.imgur.com/lTgPV6m.gif)

### Nested snippet completion

![Nested](http://i.imgur.com/pUUA6vN.gif)

### Generics

![Generics](http://i.imgur.com/lvp1JjR.gif)

## Setup and compatibility

Completion snippets rely on [UltiSnips](https://github.com/SirVer/ultisnips), it is currently the
only snippet engine supported. You can use regular [UltiSnips](https://github.com/SirVer/ultisnips) snippets
and expand generated completion snippets inside of them.

I have [UltiSnips](https://github.com/SirVer/ultisnips) configured in my .vimrc as below:

```
let g:UltiSnipsListSnippets ="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
```

Completion snippets work well with many completion engines in vim, I've done the majority of testing
with [neocomplete](https://github.com/Shougo/neocomplete.vim), [supertab](https://github.com/ervandew/supertab),
and standard C-x C-o completion. They require a recent version of vim. You can
check if your version is supported by running `:echo has("patch-7.3-598")`,
it should output 1. This requirement is because we make use of
the `CompleteDone` event.

Completion snippets are not enabled by default. To enable them the following should be included in your .vimrc.

```
" Enable snippet completion, requires completeopt-=preview
let g:OmniSharp_want_snippet=1
```

### How it works

You can checkout the [diff](https://github.com/OmniSharp/omnisharp-vim/pull/209/files) for the pull request if you are interested.
Both [omnisharp-server](https://github.com/OmniSharp/omnisharp-server) and [omnisharp-roslyn](https://github.com/OmniSharp/omnisharp-roslyn) have support to return a snippet template for completion data.
With the above mentioned .vimrc configuration this data is requested from the server,
when vim fires it's `CompleteDone` event then a regex is run against a combination of the completion data and the context of the current line,
if the regex matches then the completion is a candidate for snippet expansion and
the [UltiSnips](https://github.com/SirVer/ultisnips) internals are invoked. The snippet is also cached in a dictionary, keyed by the calculated completion term.

```
function! OmniSharp#ExpandAutoCompleteSnippet()
  if !g:OmniSharp_want_snippet
    return
  endif

  if !exists("*UltiSnips#AddSnippetWithPriority")
    echoerr "g:OmniSharp_want_snippet is enabled but this requires the UltiSnips plugin and it is not installed."
    return
  endif

  let line = strpart(getline('.'), 0, col('.')-1)
  let remove_whitespace_regex = '^\s*\(.\{-}\)\s*$'

  let completion = matchstr(line, '.*\zs\s\W.\+(.*)')
  let completion = substitute(completion, remove_whitespace_regex, '\1', '')

  let should_expand_completion = len(completion) != 0

  if should_expand_completion
    let completion = split(completion, '\.')[-1]
    let completion = split(completion, 'new ')[-1]

    if has_key(s:omnisharp_last_completion_dictionary, completion)
      let snippet = get(get(s:omnisharp_last_completion_dictionary, completion, ''), 'snip','')
      if !has_key(s:generated_snippets, completion)
        call UltiSnips#AddSnippetWithPriority(completion, snippet, completion, 'iw', 'cs', 1)
        let s:generated_snippets[completion] = snippet
      endif
      call UltiSnips#CursorMoved()
      call UltiSnips#ExpandSnippetOrJump()
    endif
  endif
endfunction
```

## Summary

I've found the completion snippets to be a real improvement over the standard completion. It is relatively
complicated (for my brain) to determine exactly when a snippet should be expanded and to make sure they work well
for Generics, Lambdas, and nested snippets.

If you notice any issues then please raise them on [GitHub](https://github.com/OmniSharp/omnisharp-vim).

