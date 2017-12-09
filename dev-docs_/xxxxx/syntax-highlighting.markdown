---
title: "Syntax Highlighting Tests"
---

> __NOTE__: Pandoc code with line-numbers doesn't produce H-scrollbar when exceeding width --- issue is with table's CSS: must implement `overflow`!

# Pandoc Highlighting

## Default Theme

The default theme for pandoc highlighting is __Base16 Monokai__.


### YAML

``` yaml
!inc(example.yaml)
```


### Haskell Example

!define(exHaskell)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Long comment to test when code overflows and how the horizontal scrollbar looks like.
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

~~~~ haskell
!exHaskell
~~~~

With line-numbers:

~~~~ {.haskell .numberLines startFrom="1000"}
!exHaskell
~~~~

### Go Lang

!define(exGo)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!include(../_codeEx/medium.go)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

~~~~ go
!exGo
~~~~


### Ruby

!define(exRuby)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
require "gem"

string = "base16"
symbol = :base16
fixnum = 0
float  = 0.00
array  = Array.new
array  = ['chris', 85]
hash   = {"test" => "test"}
regexp = /[abc]/

# This is a comment
class Person
  
  attr_accessor :name
  
  def initialize(attributes = {})
    @name = attributes[:name]
  end
  
  def self.greet
    "hello"
  end
end

person1 = Person.new(:name => "Chris")
print Person::greet, " ", person1.name, "\n"
puts "another #{Person::greet} #{person1.name}"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

~~~~ ruby
!exRuby
~~~~

With line-numbers:

~~~~ {.ruby .numberLines startFrom="1"}
!exRuby
~~~~

### Python

!define(exPython)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!include(../_codeEx/long.py)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

~~~~ python
!exPython
~~~~

With line-numbers:

~~~~ {.python .numberLines startFrom="1"}
!exPython
~~~~


# TESTS

## Linenumber Without Highlighting

Here I try to line-number non-highlighted python code via:

````````````````````````
~~~~ { .numberLines startFrom="1" }
~~~~
````````````````````````

... since no `.python` attribute is present, it will be treated as non-highlitable code:

~~~~ { .numberLines startFrom="1" }
!exPython
~~~~

## Pre Emulation

Based on the previous test, I can emulate preformatted blocks by using custom classes for code blocks. This has the added benefit that I could also line number pre block.

!define(exPre)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I'm just a preformatted block.
No highlighting applies to me.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

````````````````````````
~~~~ { .Pre }
~~~~
````````````````````````

~~~~ { .Pre }
!exPre
~~~~

with line nums:

~~~~ { .Pre .numberLines }
!exPre
~~~~

> __NOTE__: with the former, pandoc doesn't add highlighter tags:
> 
>  ``` { .html .small }
>  <pre class="Pre">
>   <code>I'm just a preformatted block.
>  ```
>  
>  But line numbering introduces highlighter tags even though it's not being highlighted:
>  
>  ``` { .html .small }
>  <pre class="sourceCode numberSource Pre numberLines" id="cb13">
>    <code class="sourceCode">
>      <a class="sourceLine" id="cb13-1" data-line-number="1">I'm just a preformatted block.</a>
>  ```

# Highlight Default

Some examples of how Highlight syntax highlights languages for which there is no custom theme defined.

Without line-numbers:

!Highlight(python)()()()(!exPython)

With line-numbers:



!HighlightLN(python)(100)(3)(!exPython)

# Highlight

## PureBASIC

!define(exPureBASIC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

!PureBasic(!exPureBASIC)

With line-numbers:

!PureBasicLN(100)(3)(!exPureBASIC)


## Fasm

!define(exFasm)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Simple text editor - fasm example program

format PE GUI 4.0
entry start

include 'win32a.inc'

IDR_ICON = 17
IDR_MENU = 37

IDM_NEW   = 101
IDM_EXIT  = 102
IDM_ABOUT = 901

section '.text' code readable executable

  start:

    invoke  GetModuleHandle,0
    mov [wc.hInstance],eax
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Without line-numbers:

!Fasm(!exFasm)

With line-numbers:

!FasmLN(100)(3)(!exFasm)

# Preformatted Blocks

There is no markdown syntax for `<pre>` blocks. Instead, a code block without any language declaration can be used:

```
I'm a code block without any language or classes specified.
```

# Code Rulers Test

__NORMAL__:

A normal (default) code block can show up to 80 chars before displaying a horizontal scrollbar:

!Ruler80()

__SMALL__:


A code block with `<code class="small">` can show up to 100 chars before displaying a horizontal scrollbar:


!Ruler100(small)

# Test `!raw(!Code)` and `!raw(!CodeSmall)`


# `!raw(!Code)` Macro


__NORMAL__:

(Using the `!raw(!Code)` macro)

!Code()
~~~~~~~~~~~~~~~~~~~~~~~~~
Some fictional code
  If this or that
    X = 10 * y
  EndIf
~~~~~~~~~~~~~~~~~~~~~~~~~

__SMALL__:

(Using the `!raw(!CodeSmall)` macro)

!CodeSmall()
~~~~~~~~~~~~~~~~~~~~~~~~~
Some fictional code
  If this or that
    X = 10 * y
  EndIf
~~~~~~~~~~~~~~~~~~~~~~~~~

# Test  `!raw(!HighlightSmall)` 

!HighlightSmall(purebasic)()()()
~~~~~~~~
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~

----------

# Code and Verbatim

Some tests for code, syntax highlighting and preformatted blocks.

- [Pandoc Documentation](http://pandoc.org/MANUAL.html):
  + [Verbatim (code) blocks](http://pandoc.org/MANUAL.html#verbatim-code-blocks)

# Preformatted Blocks

In order to achieve a simple `<pre>` block (not followed by the `<code>` code) you have to resort to raw HTML tags inside markdown --- ie: there is no way to achived it in pure markdown.

!define(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<pre>I'm a preformatted block, no code inside</pre> 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!MDExampleHTML(!example)


# Non-Highlighted Code Blocks

To define a code block without any highlighting, just enclosed it in tildas or backticks (fenced code), or use indentation (4 spaces or one Tab).

## Fenced (backticks)

!define(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```
For i=1 To 10
  Debug("Counting " + Str(i))
Next
```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!MDExampleHTML(!example)

## Indented (4 spaces)

:::::: Note ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
__NOTE__ --- The raw html comment tag `<!---->` was added to create a context in the snippet, otherwise pandoc would convert it as a paragraph.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

!define(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<!---->
    For i=1 To 10
      Debug("Counting " + Str(i))
    Next

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!MDExampleHTML(!example)


------

# Line blocks

    Extension: line_blocks

A line block is a sequence of lines beginning with a vertical bar ("`|`") followed by a space. The division into lines will be preserved in the output, as will any leading spaces; otherwise, the lines will be formatted as Markdown. This is useful for verse and addresses:

!def(LineBlock)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

```
!LineBlock
```

... which produces (horizontal rulers added):

--------------------------------------------

!LineBlock

--------------------------------------------

It basicall wraps the contents in a `<div style="white-space: pre-line;">`.

The lines can be hard-wrapped if needed, but the continuation line must begin with a space.

!def(LineBlock)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The Right Honorable Most Venerable and Righteous Samuel L.
  Constable, Jr.
| 200 Main St.
| Berkeley, CA 94718
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

```
!LineBlock
```

... which produces (horizontal rulers added):

--------------------------------------------

!LineBlock

--------------------------------------------

Long lines will wrap around:

!def(LineBlock)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| A very lengthy and overly-verbose line of text that will surely exceed its container's width by an abundant measure and force wrapping!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

```
!LineBlock
```

... which produces (horizontal rulers added):

--------------------------------------------

!LineBlock

--------------------------------------------

# SNIPPETS

__MARKDOWN SOURCE:__

``` markdown

```

__HTML OUTPUT:__

``` html

```

__HTML RESULT:__