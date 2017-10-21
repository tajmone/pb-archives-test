---
title: "Test Pandoc Line Blocks"
---

!import(Typography-Tests.pp)

Line blocks is a feature of pandoc markdown which allows preserving whitespaces and newlines in a block of markdown text.

# Line Blocks Usage

From [pandoc documentation](http://pandoc.org/MANUAL.html#line-blocks):

> Extension: `line_blocks`
> 
> A line block is a sequence of lines beginning with a vertical bar (`|`) followed by a space. The division into lines will be preserved in the output, as will any leading spaces; otherwise, the lines will be formatted as Markdown. This is useful for verse and addresses:
> 
> ```
> | The limerick packs laughs anatomical
> | In space that is quite economical.
> |    But the good ones I've seen
> |    So seldom are clean
> | And the clean ones so seldom are comical
> 
> | 200 Main St.
> | Berkeley, CA 94718
> ```
>
> The lines can be hard-wrapped if needed, but the continuation line must begin with a space.
> 
> ```
> | The Right Honorable Most Venerable and Righteous Samuel L.
>   Constable, Jr.
> | 200 Main St.
> | Berkeley, CA 94718
> ```
>
> This syntax is borrowed from [reStructuredText](http://docutils.sourceforge.net/docs/ref/rst/introduction.html).

# Examples

## Basic Example

!TripleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> __NOTE__: As you can see from the HTML output, pandoc wraps the contents of a Line Block in a `<div style="white-space: pre-line;">` instead of a `<p>` paragraph.

## Example With Styled Text

In this example normal markdown styling is applied to the text:

!TripleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The _limerick packs_ laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are __clean__
| And the clean ones so seldom are comical.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


## Hard-Wrapping Example

When hard-wrapping, the continuation line must begin with a space:

!TripleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The Right Honorable Most Venerable and Righteous Samuel L.
  Constable, Jr.
| 200 Main St.
| Berkeley, CA 94718
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

