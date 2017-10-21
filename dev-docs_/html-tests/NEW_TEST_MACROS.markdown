---
title: "Test MD 2 HTML Macros"
---

!import(Typography-Tests.pp)

Testing the new changes to Test macros, implementing escaping in Markdown 2 HTML.

> NOTE: In order for this macros to work correctly, you'll have to escape some chars in the markdown source, according to context — eg: `` ` ``

Here are some excerpts from Pandoc documentation regarding escaping and the `all_symbols_escapable` extension...

## Backslash escapes

- <http://pandoc.org/MANUAL.html#backslash-escapes>


Extension: `all_symbols_escapable`

Except inside a code block or inline code, any punctuation or space character preceded by a backslash will be treated literally, even if it would normally indicate formatting. 

...

This rule is easier to remember than standard Markdown’s rule, which allows only the following characters to be backslash-escaped:

    \`*_{}[]()>#+-.!


A backslash-escaped newline (i.e. a backslash occurring at the end of a line) is parsed as a hard line break. It will appear in HTML as `<br />`. 

---

# Test HTML Escaping

## md2html


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!raw{!md2html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
INLINE CODE: \`inline code\` END.
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__BECOMES:__

!md2html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INLINE CODE: \`inline code\` END.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

----------------------------------------------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!raw{!md2html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
\`\`\`
If X = 1
    printN("xxx")
EndIf
\`\`\`
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__BECOMES:__

!md2html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\`\`\`
If X = 1
    printN("xxx")
EndIf
\`\`\`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-------

# Double Tests

## DoubleTest

!DoubleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The _limerick packs_ laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are __clean__
| And the clean ones so seldom are \`comical\`.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<br />

----------------------------------------------------------------

!DoubleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\`\`\`
If X = 1
    printN("xxx")
EndIf
\`\`\`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-------

# Triple Tests

## TripleTest

!TripleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| The _limerick packs_ laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are __clean__
| And the clean ones so seldom are \`comical\`.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<br />

----------------------------------------------------------------

!TripleTest
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\`\`\`
If X = 1
    printN("xxx")
EndIf
\`\`\`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
