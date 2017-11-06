
:::::: Warning :::::::::::::::::::::::::::::
__WIP WARNING__ --- This page and all the documents in this section are still work in progress, most pages are rough sketches, tests, and their contents might not reflect the current state of code/macros changes.
::::::::::::::::::::::::::::::::::::::::::::

PP macros extend pandoc's markdown syntax with built in PP macros and custom macros definitions.

# PP Macros Definitions Files

PP macross definitions are scattered in various files (aka "pp-macros set", each file/set covering a specific area of application.) The macros definition files reside in the [`/_butler_/macros/`][macros folder] folder.

Butler only imports a single macros definition file:

- [`macros.pp`][macros.pp]

... this is the main macros file which takes care of importing all the other definitions files, namely:

!ListMacrosFiles

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REMOVED MACROS FILE LIST WITH LINKS:

- [`BlockFormatting.pp`][BlockFormatting.pp]
- [`GFM-TaskList.pp`][GFM-TaskList.pp]
- [`Highlight.pp`][Highlight.pp]
- [`InlineFormatting.pp`][InlineFormatting.pp]
- [`LinkingHelpers.pp`][LinkingHelpers.pp]
- [`Verbatim.pp`][Verbatim.pp]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Files List

- [`macros-Verbatim.html`](./macros-Verbatim.html)
- [`block-formatting.html`](./block-formatting.html)
- [`FASM-TEST.html`](./FASM-TEST.html)
- [`inline-formatting.html`](./inline-formatting.html)
- [`task-lists.html`](./task-lists.html)
- [`test-highlight.html`](./test-highlight.html)

:::::: Note ::::::::::::::::::::::::::::::::
Some of the FASM source code examples used for testing highlighting macros where taken from the FASM package:

Copyright (c) 1999-2017, Tomasz Grysztar.

License: Simplified BSD with a weak copyleft clause. For full details, see:

- [`FASM_LICENSE.TXT`](./FASM_LICENSE.TXT)
::::::::::::::::::::::::::::::::::::::::::::



