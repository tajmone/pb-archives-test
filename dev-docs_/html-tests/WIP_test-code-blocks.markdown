---
title: "Code Blocks Tests"
---

> __NOTE__: Pandoc code with line-numbers doesn't produce H-scrollbar when exceeding width --- issue is with table's CSS: must implement `overflow`!

# Code Blocks Examples

__NORMAL__:

(Using the `!raw(!PureBasic)` macro)

!PureBasic
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

__SMALL__:

(Using the `!raw(!PureBasicSmall)` macro)


!PureBasicSmall
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

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

# Pandoc Highlighting

## Line Numbers


!define(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!MDExampleHTML(!example)


### Test line numbers...


!define(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~ {#mycode .python .numberLines startFrom="1"}
from appium import webdriver
from appium import SauceTestCase, on_platforms
from appium.webdriver.common.touch_action import TouchAction
from appium.webdriver.common.multi_action import MultiAction

from time import sleep

app = "http://appium.github.io/appium/assets/ApiDemos-debug.apk"
platforms = [{
                "platformName": "Android",
                "platformVersion": "4.4",
                "deviceName": "Android Emulator",
                "appActivity": ".graphics.TouchPaint",
                "app": app,
                "appiumVersion": "1.3.4"
            }]
~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!MDExampleHTML(!example)


# Highlight

## Block Simple

!Highlight(purebasic)()()()
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

## Block With Line Numbers

!Highlight(purebasic)(--line-numbers --line-number-length=1)()()~~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next~~~~~~~~~~~

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