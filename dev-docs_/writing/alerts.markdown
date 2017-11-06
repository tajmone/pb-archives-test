---
title:      Creating Alert Messages
subtitle:   --- via pandoc fenced divs ---
meta-title: Alert Messages
# css: 
baseliner: true
...

Whenever you need to make a block of text stand out from the main content, as an aside text that catches the reader's attention, Alert Messages (aka "Alerts", of "Flash Messages") are available as `<div>` classes in the project's CSS Theme:

- `Alert`
- `Warning`
- `Error`
- `Success`
- `Note`

:::::: Warning :::::::::::::::::::::::::::::
__WARNING__: The class names in the above list are case-sensitive!
::::::::::::::::::::::::::::::::::::::::::::

:::::: Note ::::::::::::::::::::::::::::::::
__NOTE__: The warning box above is an example of an Alert (with `Warning` class); and this note box is an Alert too (with `Note` class).
::::::::::::::::::::::::::::::::::::::::::::


# Creating An Alert Message

Alerts are just blocks of contentes inside `<div>` tags using classes predfined in the CSS Theme. Pandoc markdown has the special fenced divs syntax for creating div blocks:

!def(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
:::::::::::: Warning
### A Warning Alert

This is a Warning Alert. It's just a block of Markdown content enclosed in
colon-fences (three colons or more), where the opening fence is followed by
the `<div>`'s class name (mandatory), and its closing counterpart not.
::::::::::::
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!MDExampleHTML(!example)

You can also specify more than one class on the opening fence, as well as an identifier, by enclosing them withing curly braces and using CSS notation:

!def(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
:::::::::::: {#small-text-example .Alert .small}

This is an alert with smaller text via the additional `small` class from
the CSS Theme.

::::::::::::
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!MDExampleHTML(!rawdef[example])


-------------------

# Extension: `fenced_divs`

- <http://pandoc.org/MANUAL.html#extension-fenced_divs>

Allow special fenced syntax for native Div blocks. A Div starts with a fence containing at least three consecutive colons plus some attributes. The attributes may optionally be followed by another string of consecutive colons. The attribute syntax is exactly as in fenced code blocks (see [Extension: `fenced_code_attributes`]). As with fenced code blocks, one can use either attributes in curly braces or a single unbraced word, which will be treated as a class name. The Div ends with another line containing a string of at least three consecutive colons. The fenced Div should be separated by blank lines from preceding and following blocks.

Example:

!def(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::::: {#special .sidebar}
Here is a paragraph.

And another.
:::::
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!MDExampleHTML(!example)


Fenced divs can be nested. Opening fences are distinguished because they must have attributes:


!def(example)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::: Warning ::::::
This is a warning.

::: Danger
This is a warning within a warning.
:::
::::::::::::::::::
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!MDExampleHTML(!example)


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[Extension: `fenced_code_attributes`]: http://pandoc.org/MANUAL.html#extension-fenced_code_attributes