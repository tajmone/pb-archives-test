
---
title: Block-Formatting Macros
...

!import(../html-tests/Typography-Tests.pp)

Macros deinition file: `BlockFormatting.pp`

Macros list:

- `!raw{!FakeH3}`
- `!raw{!Caption}`
- `!raw{!QuoteSource}`

# QuoteSource Macro

The `!raw{!QuoteSource}` macro is used to render the source of a blockquote.


!define(BlockQuoteExample)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> A block quote with some text. Blah, blah, blah.
> 
> !QuoteSource(the source of the text)  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TripleTest(!BlockQuoteExample)




