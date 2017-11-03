---
title:          PureBasic and Object-Oriented Programming
subtitle:       6\. Synthesis and Notation
meta-title:     PureBasic OOP (6) Synthesis and Notation
author: Dräc
description: >-
    PureBASIC OOP Tutorial (6/9) — Synthetic resume, in formal notation,
    on how to implement object classes and methods in PureBasic.
keywords:       PureBasic, OOP, object-oriented, programming, reference,
                implementation
pagination:
    - text: PREV
      link: purebasic-oop-5.html
      alt:  Go to previous page
    - text: TOC
      link: index.html
      alt:  Tutorial's Table of Contents 
    - text: NEXT
      link: purebasic-oop-7.html
      alt:  Go to next page
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Synthese_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before presenting the final Class implementation, I’m going to spend some time summarizing in a formal notation the work made so far. Implementation of an object involved the following elements:

*   An **Interface**,
*   A *Class* (concrete/abstract) including methods definitions,
*   A *Constructor* provided with a routine for initializating attributes,
*   A **Destructor**.

The following table summarizes what is our object in PureBasic.

*   The word `Class` refers to the name of the Class (e.g.: `Methd_Class`)
*   The word `Parent` refers to the name of the Parent Class during inheritance (e.g.: `Methd_ ParentClass`)
*   Expressions between braces `{…}` are to be used during inheritance

!comment( Example N. 7-1 )

!Caption(Interface)
!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface <Interface> {Extends <ParentInterface>}
  Method1()
  [Method2()]
  [Method3()]
  ...
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 7-2 )

!Caption(Class)
!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure <Class> {Extends <ParentClass>}
  *Methods
  [Attribute1]
  [Attribute2]
  ...
EndStructure

Procedure Method1(*this.Class, [arg1]...)
  ...
EndProcedure

Procedure Method2(*this.Class, [arg1]...)
  ...
EndProcedure
...

Structure <Mthds_Class> {Extends <Mthds_ParentClass>}
  *Method1
  *Method2
  ...
EndStructure

Procedure Init_Mthds_Class(*Mthds.Mthds_Class)
  {Init_Mthds_ParentClass(*Mthds)}
  *Mthds\Method1 = @Method1()
  *Mthds\Method2 = @Method2()
  ...
EndProcedure

Mthds_Class.Mthds_Class
Init_Mthds_Class(@Mthds_Class)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 7-3 )

!Caption(Constructor)
!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mbers_Class(*this.Class, [var1]...)
  {Init_Mbers_ParentClass(*this)}
  [*this\Attibute1 = var1]
  ...
EndProcedure

Procedure New_Class([var1]...)
  Shared Mthds_Class
  *this.Class = AllocateMemory(SizeOf(Class))
  *this\Methods = @Mthds_Class
  Init_Mbers_Class(*this, [var1]...)
  ProcedureReturn *this
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 7-4 )

!Caption(Destructor)
!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Free_Class(*this)
  FreeMemory(*this)
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!anchor(first code-example)
!FakeH3(First Code-Example)


Here is an example file of inheritance in action:

* [`OOP-Inheritance-Ex1.pb`]

