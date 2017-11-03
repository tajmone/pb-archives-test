---
title:          PureBasic and Object-Oriented Programming
subtitle:       1\. Why OOP in PureBasic?
meta-title:     PureBasic OOP (1) Why OOP?
author: Dräc
description: >-
    PureBASIC OOP Tutorial (1/9) — Introductiory remarks on implementing
    object-oriented programming in PureBasic. 
keywords:       PureBasic, OOP, object-oriented, programming, tutorial
# Pagination Alt text macros defined in "_bulter.pp":
pagination:
    - text: PREV
      link: index.html
      alt:  !PREV
    - text: TOC
      link: index.html
      alt:  !TOC 
    - text: NEXT
      link: purebasic-oop-2.html
      alt:  !NEXT
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Pourquoi_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since many object-oriented languages already exist, trying to achive OOP in PureBasic — which is a procedural language — might come as a surprise.

The fact that some languages are defined «Object-Oriented», while others are not, is merely indicating the presence of specific keywords which facilitate writing code according to the OOP paradigm.
That is to say: object-oriented languages introduce richer semantics; but compilation-wise they are not introducing any new aspects compared to a non-OO language, they’re just adding a layer over the latter.

Therefore, we can fully implement the OO paradigm in PureBasic, but we have to pay a price in terms of accuracy — both in development and in notation. And here we face the immediate advantages of (natively) object-oriented languages.

Nevertheless, besides the possibility of programming in PureBasic according to the OO paradigm, implementing object-oriented concepts in PureBasic offers us the interesting chance to reveal some of the underlying mechanisms of OO languages keywords.

This paper presents a programming technique that allows large projects to benefit from object oriented design. It is not intended as a course on OOP, and it assumes that the reader has good knowledge of PureBasic language.
