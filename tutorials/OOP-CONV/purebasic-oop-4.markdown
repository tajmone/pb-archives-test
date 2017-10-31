---
title:          PureBasic and Object-Oriented Programming
subtitle:       4\. Interface Instruction
meta-title:     PureBasic OOP (4) Interface Instruction
author: Dräc
description: >-
    PureBASIC OOP Tutorial (4/9) — A closer look at the Interface instruction
    and how to implement object classes and initialization via method tables
    and procedure pointers.
keywords:       PureBasic, OOP, object-oriented, programming, method table,
                pointers, interface, tutorial, example
baseliner: true
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Interface_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## STATUS: WIP

- [WWW ORIGINAL](http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Interface_en.htm)

__TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix Ordered Lists (`. text`)]
!Task[x][Add metadata (description, keywords, ecc)]
!Task[x][Fix links: NONE]
!Task[x][Add `subtitle` and fix header levels]
!Task[x][Fix subtitle casing]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 5-1 )

!Caption(Syntax)
!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface <Name1> [Extends <Name2>]
  [Procedure1]
  [Procedure2]
  ...
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The PureBasic `Interface` instruction allows grouping under the same Name (`<Name1>` in the above box) various procedures.

!comment( Example N. 5-2 )

!Caption(Example)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface My_Object
  Procedure1(x1.l, y1.l)
  Procedure2(x2.l, y2.l)
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


It’s now sufficient to declare an element as being of the `My_Object` type in order to access all the procedures that it contains. The declaration is carried out in the same manner as with `Structure`types:

!comment( Example N. 5-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Object.My_Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


As a result, we can now acess the `Object`’s functions directly:

!comment( Example N. 5-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Object\Procedure1(10, 20)
Object\Procedure2(30, 40)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Thanks to the `Interface` instruction, procedures can be called via a very practical and pleasant notation.
By writing `Object\Procedure1(10, 20)`, the `Procedure1()` from `Object` is called.
This notation is typical of the Object-oriented Programming paradigm.

# Initialization

Any typed variable declaration is normally followed by initialization. The same applies when declaring an element whose type is an `Interface`.

Unexpectedly, naming the `Interface : EndInterface` block with the name of a desired Procedure isn’t enough to make it refer to its implementation — i.e., to reference the `Procedure : EndProcedure` block of the desired procedure.

In fact, we can rename procedures inside an `Interface : EndInterface` block: we can give any name we like to the procedures that we are going to use.

Then, how are we going to connect this new name with the desired real procedure?

As with overloaded methods, the solution is in function addresses.
We must see the names inside the `Interface : EndInterface` block as function pointers to the desired function — i.e., as pointer holding function addresses.

However, to initialize the function pointers of an `Interface` typed element, the approach is different from that of a `Structure` typed element.
Indeed, it isn’t possible to initialize individually each field defined by an `Interface`, because, you must remember, that writing `Object\Procedure1()` means calling that procedure.

Initialization occurs indirectly, by giving to the element the address of a pre-initialized variable storing functions pointers.

This kind of variable is called a **method table**.

!FakeH3(Example:)

Let us carry on with the `Interface My_Object`.
Consider the following `Structure` describing the function pointers:

!comment( Example N. 5.1-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure My_Methods
  *Procedure1
  *Procedure2
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


and its associated method table:

!comment( Example N. 5.1-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Methods.My_Methods
Methods\Procedure1 = @My_Procedure1()
Methods\Procedure2 = @My_Procedure2()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


where `My_Procedure1()` and `My_Procedure2()` are the desired procedure implementations.

Then, initialization of `Object` (of the `My_Object` type, an `Interface`) looks like this:

!comment( Example N. 5.1-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Object.My_Object = @Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Next, by writing

!comment( Example N. 5.1-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Object\Procedure2(30, 40)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


the `Object`’s `Procedure2()` function is called — i.e., `My_Procedure2()`.

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When declaring elements of an `Interface`, it’s essential to initialize them before using their procedures. Therefore, it is strongly advisable to initialize elements at declaration time.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!anchor(admonition-on-structure-interface-symmetry)
The **method table**’s `Structure` must reflect exactly the composition of its correlated `Interface`.
It must contain the same number of fields, and preserve their order, to ensure the correct assignation of each function’s name and address.
It is only under these conditions that the element will be properly initialized.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To summarize, using an `Interface` involves:

* an `Interface` describing the required procedures to use,
* a `Structure` describing the function pointers,
* a **method table**: a structured variable initialized with the required function adresses.

And its benefits are:

* an object-oriented notation
* an easy way to rename procedures
