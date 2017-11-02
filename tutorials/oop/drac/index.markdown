---
title:          PureBasic and Object-Oriented Programming
subtitle:       — or «the OOP demystified» —
meta-title:     PureBasic OOP (Table of Contents)
author: Dräc
description: >-
    PureBASIC OOP Tutorial — PureBasic and Object-Oriented Programming (aka
    «the OOP demystified»), by Dräc. A multipart tutorial demonstrating how
    to implement classes and Object-Oriented Programming in PureBasic.
    Source code library and examples included.
keywords:       PureBasic, OOP, object-oriented, programming, tutorial
pagination:
    - text: PREV
      link:
      alt:  Go to previous page
    - text: TOC
      link:
      alt:  Tutorial's Table of Contents 
    - text: NEXT
      link: purebasic-oop-1.html
      alt:  Go to next page
...

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
First Markdown release:
-- v1.5 (2017/10/31), by Tristano Ajmone, PureBASIC Archives.

Ported to Markdown from AsciiDoc reprint v1.4 of Dräc's tutorial:
-- PureBASIC Archives, 2016/12/03, by Tristano Ajmone.

Originally ported to AsciiDoc from Dräc's original HTML online tutorial:
-- PureBASIC Archives, 2016/11/18, by Tristano Ajmone.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Table of Contents

1. [Why OOP in PureBasic?][OOP 1]
2. [Object Concepts][OOP 2]
3. [First Implementation of the Concepts][OOP 3]
4. [Interface Instruction][OOP 4]
5. [Second Implementation of the Concepts][OOP 5]
6. [Synthesis and Notation][OOP 6]
7. [PureBasic Class][OOP 7]
8. [Conclusion][OOP 8]
9. [Appendix][OOP 9]

# About This Tutorial

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**CREDITS**: This is a reprint of «Dräc»’s multi-part tutorial _PureBasic and the Object-Oriented Programming_, also knwon as _the OOP demystified_, published in 2005 on [drac.site.chez-alice.fr][ext OOP EN].

**LICENSE**: It was reprinted with explicit permission of the author, who released the tutorial text and source codes under [Creative Commons Attribution][CC BY 4.0] (CC BY 4.0) in response to the permission request to reproduce it inside the [PureBASIC Archives].

**CHANGES**: The tutorial was ported from HTML to AsciiDoc and Markdown by [Tristano Ajmone], who also polished the English text — introducing slight adjustments in line with the tutorial aims (using the [original French tutorial][ext OOP FR] as a reference) — and made minor changes to code examples (either aesthetic, or minor corrections, or to ensure compatibility with latest version of PureBASIC).

First republished: 2016/11/18 | Laste edited: 2017/10/31 | by [\@tajmone][Tristano Ajmone].
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Tutorial Source Files

-   [`OOP-Inheritance-Ex1.pb`] – [First Implementation][OOP 3] example.
-   [`OOP-Inheritance-Ex2.pb`] – [Second Implementation][OOP 5] example.
-   [`OOP-Inheritance-Ex2_preprocessed.pb`] – preprocessed version of `OOP-Inheritance-Ex2.pb`.[^1]
-   [`OOP.pbi`] – OOP-Implementation include-file.
   
!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__NOTE__: The [`OOP.pbi`] include-file (used in the [Second Implementation][OOP 5] example) contains the full implementation of the OOP paradigm explained in this tutorial, and you can use it in your own OOP-projects.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[^1]: The preprocessed version of `OOP-Inheritance-Ex2.pb` contains all included external code, all macros are expanded (orignal macros are kept as comments next to their expanded code), and comments are preserved. Added by Tristano Ajmone to simplify analysis of how the source code is finalized by PureBASIC compiler.


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          

NOTE: More ref.links are defined in "_butler.yaml"!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




