---
title:    Verbatim PP-Macros Set
# subtitle: SUBTITLE
meta-title: Verbatim.pp
# author: 
# date: YYMMDD
# description: METADATA_DESCRIPTION
# keywords: METADATA_KEYWORDS_LIST
# css: 
# baseliner: true
...

!import(MacrosExamples.pp)


"__Verbatim__" is a set of PP-macros for handling various types of verbatim text:

- Preformatted blocks (`<pre>`)
- Code blocks with custom classes for non syntax-higlighted coloring (`<pre><code class="someclass">`)


!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It looks like I could without the `!raw{!Code}` and `!raw{!CodeSmall}` macros, and use pandoc's support for `{.class}` syntax in fenced blocks (as well as inline code).

But I must check the CSS stylesheets, because pandoc will only put the class on the `<pre>` tag, and nothing on the `<code>` tag! If I can fix the CSS to cover nicely both syntax highlighting and preformatted blocks, it would be better to do without these macros.

See: [Pandoc Markdown Alternative] for examples and test.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Macros List

- `!raw{!Pre}`
- `!raw{!Code}`
- `!raw{!CodeSmall}`
- `!raw{!CMD}`
- `!raw{!DOS}`


# Preformatted Blocks

Thre preformatted blocks macros were devised because markdown doesn't have a syntax for wrapping text so that in the final HTML docs they will be wrapped in `<pre>` tags (without `<code>` tags inside).



## Markdown Lacks a Syntax for Preformatted Blocks

Markdown has no syntax to define verbatim text that will output as preformatted block only (`<pre>`) --- ie: it only allows for  `<pre><code>` blocks.

There is the four-spaces indentantion syntax for "[indented code blocks](http://pandoc.org/MANUAL.html#indented-code-blocks)", which will wrap the text in `<pre><code>` tags:


!def(identedEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A block of text indented four spaces (or one tab) is treated as verbatim text:

    Some verbatim text.
      Whitespace preserved!

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!TripleTest(!identedEx)

... which is just like using the "[fenced code blocks](http://pandoc.org/MANUAL.html#fenced-code-blocks)" syntax without a language specification:

!def(fencedEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```
Some verbatim text.
  Whitespace preserved!
```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TripleTest(!fencedEx)

## The `!raw{!Pre}` Macro

The `!raw{!Pre}` macro will wrap the text block within `<pre>` tags.

!def(preEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Pre
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some verbatim text.
  Whitespace preserved!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TripleTest(!rawdef[preEx])

# Code Blocks Macros

## Pandoc Markdown Alternative

- <http://pandoc.org/MANUAL.html#extension-fenced_code_blocks>

!def(fencedEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```{.someclass}
// Some pseudo-code
if x > 10 Then
    do something
```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TripleTest(!fencedEx)

Using the `small` class:

!def(fencedSmallEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```{.small}
// Some pseudo-code
if x > 10 Then
    do something
```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TripleTest(!fencedSmallEx)