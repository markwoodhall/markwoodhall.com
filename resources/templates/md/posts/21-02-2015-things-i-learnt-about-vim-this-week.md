{:title  "Things I learnt about Vim this week: Joining lines of text."
 :layout :post
 :date   "21-02-2015"
 :tags   ["vim"]}

I've been using Vim now for [over a year](http://www.markwoodhall.com/2014/11/13/thoughts-9-months-after-switching-to-vim/) but I'm still increasingly amazed how little I know.

This week I've been writing some documentation in markdown. Working with text that isn't a programming language like C#, Clojure or JavaScript helped me to discover a few cool Vim commands I should have known already.

###Joining lines of text

Given the following block of text, when the cursor is on the first line we can use `J` in normal mode to join the two lines of text.

```
this is a line of text
and should be followed by this
```
becomes
```
this is a line of text and should be followed by this
```

With text spread over three lines, like below, when the cursor is on the first line we can use `JJ`  in normal mode to join the three lines of text.

```
this is a line of text
and should be followed by this
and this
```
becomes
```
this is a line of text and should be followed by this and this
```

Obviously, we can do better than bashing the `J` key. Lets take the below text as an example. Vims composability means that `J` is just another command we can apply to word motions, or selections. With the cursor on the first line of the text we can do `VGJ`. `V` goes into Visual mode, `G` selects to the  bottom of the document and `J` joins the selection.

```
this is a line of text
and should be followed by this
and this line

this is a line of text
and should be followed by this
and this line

this is a line of text
and should be followed by this
and this line

this is a line of text
and should be followed by this
and this line
```
becomes
```
this is a line of text and should be followed by this and this line this is a line of text and should be followed by this and this line this is a line of text and should be followed by this and this line this is a line of text and should be followed by this and this line
```

Thats pretty cool, since we can apply `J` to selections we can do more too. If we take the text block below, when the cursor is on line 3, we can enter visual mode `V`, select 2 lines down `2j` and hit `J` to join the selection.

```
this is a line of text and should be followed by this and this line

this is a line of text
and should be followed by this
and this line

this is a line of text and should be followed by this and this line

this is a line of text and should be followed by this and this line
```
becomes
```
this is a line of text and should be followed by this and this line

this is a line of text and should be followed by this and this line

this is a line of text and should be followed by this and this line

this is a line of text and should be followed by this and this line
```

We can apply the same principle using something more concrete as an example. What if we had the `if` statement below and we'd rather just put the condition checking on one line. With the cursor positioned on the opening parentheses we can hit `V%J`, `V` to go into Visual mode, `%` to select to the closing parentheses and `J` to join the text.

```
if (1 == 1 &&
    2 == 2 &&
    3 == 3) {

}
```
becomes
```
if (1 == 1 && 2 == 2 && 3 == 3) {

}
```

Note that `J` joins lines and includes an additional space between them. To join lines without the inclusion of an additional space you can use `gJ`.

A quick mention to a Vim plugin I was using when editing markdown. [vim-livedown](https://github.com/shime/vim-livedown) uses a node module called livedown to preview markdown files in the browser as you edit them.

