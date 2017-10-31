
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
baseliner: true
...

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
= PureBasic and Object-Oriented Programming
Dräc
v1.4, December 3, 2016: Reprinted and revised edition.



:title: PureBasic and Object-Oriented Programming — or «the OOP demystified»
:doctype: article
:encoding: utf-8
:lang: en
:toc: left
:sectnums!:
:highlightjsdir: ../hjs
:idprefix:
:idseparator: -
:icons: font
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROGRESS: All tutorial pages revised, except this one.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertError
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FIX THIS PAGE:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix Metadata]
!Task[ ][Fix Tutorial Info (dates, version, adoc to MD porting, etc.)]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# About This Tutorial

**CREDITS**: This is a reprint of «Dräc»’s multi-part tutorial __PureBasic and the Object-Oriented Programming__, also knwon as __the OOP demystified__, published in 2005  on [drac.site.chez-alice.fr].

**LICENSE**: It was reprinted with explicit permission of the author, who released the tutorial text and source codes under [Creative Commons Attribution] (CC BY 4.0) in response to the permission request to reproduce it inside the [PureBASIC Archives].

**CHANGES**: The tutorial was ported from HTML to AsciiDoc and Markdown by [Tristano Ajmone], who also polsihed the English text — introducing slight adjustments in line with the tutorial aims (using the [original French tutorial] as a reference) — and made minor changes to code examples (either aesthetic, or minor corrections, or to ensure compatibility with latest version of PureBASIC).

First republished: 2016/11/18 — by [\@tajmone][Tristano Ajmone].
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

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[OOP 1]: ./purebasic-oop-1.html
[OOP 2]: ./purebasic-oop-2.html
[OOP 3]: ./purebasic-oop-3.html
[OOP 4]: ./purebasic-oop-4.html
[OOP 5]: ./purebasic-oop-5.html
[OOP 6]: ./purebasic-oop-6.html
[OOP 7]: ./purebasic-oop-7.html
[OOP 8]: ./purebasic-oop-8.html
[OOP 9]: ./purebasic-oop-9.html

[drac.site.chez-alice.fr]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Pourquoi_en.htm "View Dräc's original OOP tutorial, English version"

[original French tutorial]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Pourquoi.htm "View Dräc's original OOP tutorial, French version"

[Tristano Ajmone]: https://github.com/tajmone "Visit Tristano Ajmone's GitHub profile"

[Creative Commons Attribution]: https://creativecommons.org/licenses/by/4.0/ "Visit the webpage of the Creative Commons Attribution 4.0 International (CC BY 4.0) license"

[PureBASIC Archives]: https://github.com/tajmone/purebasic-archives "Visit the PureBASIC Archives repository on GitHub"
