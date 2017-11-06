---
title: Headings Advanced Tests
---



> __TODO__: ADD TITLE (pandoc title) to all tests!

Advanced testing of `<h1>` to `<h6>` headings by all sorts of inline tags and  edge cases. Just to check that all CSS definitions are fine and prevent unwanted results.

# Plain

!GenHeadings(Lorem Ipsum)

# Inline Tags

## Strong & EM

Test `<strong>` and `<em>` tags.

!GenHeadings(+ __strong__ + _em_ + ___strong-em___)

## Bold, Italic & Underline

Test the old HTML4 `<b>`, `<i>` and `<u>` tags.

!GenHeadings
~~~~~~~~~~~~~~~~~~~~
+ <b>bold</b> + <i>italic</i> + <b><i>bold-italic</i></b> + <u>underline</u>
~~~~~~~~~~~~~~~~~~~~

## Mark

!GenHeadings(+ <mark>mark tag</mark>)

## Inline Code

!GenHeadings(+ `inline code`)

## Samp

!GenHeadings(+ <samp>samp tag</samp>)

## Keystrokes

Testing the `<kbd>` tag.

!GenHeadings(With Keystrokes: <kbd>Ctrl</kbd>+<kbd>Z</kbd>)

# Long Titles

Verify how lengthy titles wrap around...

!GenHeadings
~~~~~~~~~~~~~~~~~~~~
With an Extremely Lengthy and Overly Verbose Title That Will Most Definitely Span Across Multiple Lines Even with the Smallest One of the Six Headings
~~~~~~~~~~~~~~~~~~~~
