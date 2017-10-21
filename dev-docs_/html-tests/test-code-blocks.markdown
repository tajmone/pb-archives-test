---
title: "Code Blocks Tests"
---

!import(Typography-Tests.pp)


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

!HighlightSmall(purebasic)()(xxx)
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


__MARKDOWN SOURCE:__

``` html
<pre>I'm a preformatted block, no code inside</pre>
```

__HTML RESULT:__

<pre>I'm a preformatted block, no code inside</pre>

# Non-Highlighted Code Blocks

To define a code block without any highlighting, just enclosed it in tildas or backticks (fenced code), or use indentation (4 spaces or one Tab).

__MARKDOWN SOURCE:__

fenced (backticks):

~~~~~~~~ markdown
```
For i=1 To 10
  Debug("Counting " + Str(i))
Next
```
~~~~~~~~

identented (4 spaces):

``` markdown
    For i=1 To 10
      Debug("Counting " + Str(i))
    Next
```

__HTML OUTPUT:__

``` html
<pre><code>For i=1 To 10
  Debug("Counting " + Str(i))
Next</code></pre>
```

__HTML RESULT:__

    For i=1 To 10
      Debug("Counting " + Str(i))
    Next


# Pandoc Highlighting

## Line Numbers

__MARKDOWN SOURCE:__

``` markdown
~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~
```

__HTML OUTPUT:__

``` html
<div class="sourceCode" id="mycode" startfrom="100"><table class="sourceCode haskell numberLines"><tbody><tr class="sourceCode"><td class="lineNumbers"><pre>100
101
102
</pre></td><td class="sourceCode"><pre><code class="sourceCode haskell">qsort []     <span class="fu">=</span> []
qsort (x<span class="fu">:</span>xs) <span class="fu">=</span> qsort (filter (<span class="fu">&lt;</span> x) xs) <span class="fu">++</span> [x] <span class="fu">++</span>
               qsort (filter (<span class="fu">&gt;=</span> x) xs)</code></pre></td></tr></tbody></table></div>
```

__HTML RESULT:__

~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~

### Test line numbers...

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


@on_platforms(platforms)
class AndroidGesturesSauceTests(SauceTestCase):

    def test_drag_and_drop(self):
        # first get to the right activity
        self.driver.start_activity("io.appium.android.apis", ".view.DragAndDropDemo")

        start = self.driver.find_element_by_id("io.appium.android.apis:id/drag_dot_3")
        end = self.driver.find_element_by_id("io.appium.android.apis:id/drag_dot_2")

        action = TouchAction(self.driver);
        action.long_press(start).move_to(end).release().perform()

        sleep(.5)

        text = self.driver.find_element_by_id("io.appium.android.apis:id/drag_result_text").text
        self.assertEqual(text, "Dropped!")


    def test_smiley_face(self):
        # just for the fun of it.
        # this doesn't really assert anything.
        # paint
        eye1 = TouchAction()
        eye1.press(x=150, y=100).release()

        eye2 = TouchAction()
        eye2.press(x=250, y=100).release()

        smile = TouchAction()
        smile.press(x=110, y=200) \
            .move_to(x=1, y=1) \
            .move_to(x=1, y=1) \
            .move_to(x=1, y=1) \
            .move_to(x=1, y=1) \
            .move_to(x=1, y=1) \
            .move_to(x=2, y=1) \
            .move_to(x=2, y=1) \
            .move_to(x=2, y=1) \
            .move_to(x=2, y=1) \
            .move_to(x=2, y=1) \
            .move_to(x=3, y=1) \
            .move_to(x=3, y=1) \
            .move_to(x=3, y=1) \
            .move_to(x=3, y=1) \
            .move_to(x=3, y=1) \
            .move_to(x=4, y=1) \
            .move_to(x=4, y=1) \
            .move_to(x=4, y=1) \
            .move_to(x=4, y=1) \
            .move_to(x=4, y=1) \
            .move_to(x=5, y=1) \
            .move_to(x=5, y=1) \
            .move_to(x=5, y=1) \
            .move_to(x=5, y=1) \
            .move_to(x=5, y=1) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=0) \
            .move_to(x=5, y=-1) \
            .move_to(x=5, y=-1) \
            .move_to(x=5, y=-1) \
            .move_to(x=5, y=-1) \
            .move_to(x=5, y=-1) \
            .move_to(x=4, y=-1) \
            .move_to(x=4, y=-1) \
            .move_to(x=4, y=-1) \
            .move_to(x=4, y=-1) \
            .move_to(x=4, y=-1) \
            .move_to(x=3, y=-1) \
            .move_to(x=3, y=-1) \
            .move_to(x=3, y=-1) \
            .move_to(x=3, y=-1) \
            .move_to(x=3, y=-1) \
            .move_to(x=2, y=-1) \
            .move_to(x=2, y=-1) \
            .move_to(x=2, y=-1) \
            .move_to(x=2, y=-1) \
            .move_to(x=2, y=-1) \
            .move_to(x=1, y=-1) \
            .move_to(x=1, y=-1) \
            .move_to(x=1, y=-1) \
            .move_to(x=1, y=-1) \
            .move_to(x=1, y=-1)
        smile.release()

        ma = MultiAction(self.driver)
        ma.add(eye1, eye2, smile)
        ma.perform()

        # so you can see it
        sleep(10)
~~~~

----------------


# Highlight

## Block Simple

!Highlight(purebasic)()()
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

## Block With Line Numbers

!Highlight(purebasic)(--line-numbers --line-number-length=1)()
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

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