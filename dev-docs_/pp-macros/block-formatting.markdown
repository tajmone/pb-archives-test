
---
title: Block-Formatting Macros
...

Macros definition file: `BlockFormatting.pp`

!FakeH3(Macros list:)

!raw
~~~~~~~~~~~~~~~~~~~~~~
- `!FakeH3`
- `!Caption`
- `!QuoteSource`
~~~~~~~~~~~~~~~~~~~~~~

# QuoteSource Macro

The `!raw{!QuoteSource}` macro is used to render the source of a blockquote.


!define(BlockQuoteExample)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> A block quote with some text. Blah, blah, blah.
> 
> !QuoteSource(the source of the text)  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!MDExampleHTML(!BlockQuoteExample)




