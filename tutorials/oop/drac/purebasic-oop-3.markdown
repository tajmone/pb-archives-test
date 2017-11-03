---
title:          PureBasic and Object-Oriented Programming
subtitle:       3\. First Implementation of the Concepts
meta-title:     PureBasic OOP (3) First Implementation
author: Dräc
description: >-
    PureBASIC OOP Tutorial (3/9) — First implementation of Object-Oriented
    paradigm in PureBasic: Concrete and Abstract classes, Instanciation,
    Encapsulation, Inheritance and Overloading.
keywords:       PureBasic, OOP, object-oriented, programming, tutorial,
                abstract classes, instanciation, encapsulation, inheritance,
                overloading
# Pagination Alt text macros defined in "_bulter.pp":
pagination:
    - text: PREV
      link: purebasic-oop-2.html
      alt:  !PREV
    - text: TOC
      link: index.html
      alt:  !TOC 
    - text: NEXT
      link: purebasic-oop-4.html
      alt:  !NEXT
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Implementation1_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( TODO: SENTENCE BELOW NEEDS FIXING AND CHECKING )

In this section, I shall demonstrate how the aforementioned object concepts can be implemented in PureBasic.
This implementation doesn’t refer to what is programmed in object-oriented languages. Furthermore, this implementations is meant be improved upon, or adapted according to needs.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ORIGINAL TEXT:
This implementation doesn't refer what is programmed in object-oriented languages.

En aucun cas cela fait référence à ce qui est programmé dans les langages objets.

Furthermore, the goal of an implementation is to be improved or to be adapted to the need.

De plus, le propre de l'implémentation c'est de pouvoir être amélioré ou de s'adapter au besoin.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


I’ll be presenting here one of these implementations, with all its pros and cons.

# Concrete Class and Abstract Class

As seen, a Class defines the contents of an object:

*   Its attributes (each variable type)
*   Its methods (Names, implementation)

For example, if I want to represent Rectangle objects and display them on screen, I shall define a `Rectangle` Class including a `Draw()` method.

The `Rectangle` Class could have the following construction:

!comment( Example N. 4.1-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle
  *Draw
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure

Procedure Draw_Rectangle(*this.Rectangle)
  ; [ ...some code... ]
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


where `x1`, `x2`, `y1` and `y2` are four attributes (the coordinates of the diametrically opposed points of the rectangle) and `*Draw` is a pointer referencing the drawing function which displays Rectangles.

Here `*Draw` is a function pointer used to contain the address of the desired function: `@Draw_Rectangle()`.
Functions referenced in this manner can be invoked by using `CallFunctionFast()`.

Thus, the proposed `Structure` is completely adapted to the notion of Class:
* the structure stores the definition of the object’s attributes: here `x1`, `x2`, `y1` and `y2` are Long variables.
* the structure stores the definition of the object’s method: here the `Draw()` function, through to a function pointer.

When a similar Class definition is followed by the implementations of its methods (in our example, `Draw_Rectangle()`’s `Procedure : EndProcedure` block statement), it becomes a concrete Class. Otherwise, it will be an abstract Class.

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`*this` always refers to the object on which the method must be applied. This notation can be seen in the previous example, within the `Draw_Rectangle()` method.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Instanciation

Now, to create an object called `Rect1` from the `Rectangle` Class, write:

!comment( Example N. 4.2-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect1.Rectangle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To initialize it, simple write:

!comment( Example N. 4.2-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect1\Draw = @Draw_Rectangle()
Rect1\x1 = 0
Rect1\x2 = 10
Rect1\y1 = 0
Rect1\y2 = 20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Next, to draw the `Rect1` object, use:

!comment( Example N. 4.2-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CallFunctionFast(Rect1\Draw, @Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Encapsulation

In this implementation, encapsulation doesn’t exist, simply because there is no way to hide the attributes or the methods of such an object.

By writing `Rect1\x1`, the user can access the `x1` attribute of the object. This is the way we used to initialize the object.
The next implementation ([Second Implementation] section) will show how to fix this.
Although significant, this feature is not essential in implementing OOP.

# Inheritance

Now I want to create a new Class with the capability to Erase rectangles from the screen.
I can implement this new `Rectangle2` Class by using the existing `Rectangle` Class and by providing it with a new method called `Erase()`.

A Class being a `Structure`, let’s take advantage of the extension property of structures. So, the new Class `Rectangle2` could be:

!comment( Example N. 4.4-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2 Extends Rectangle
  *Erase
EndStructure

Procedure Erase_Rectangle(*this.Rectangle2)
  ; [ ...some code... ]
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The Class `Rectangle2` includes the members of the previous `Rectangle` Class as well as those of the new `Erase()` method.
To instanciate an object from this new Class write:

!comment( Example N. 4.4-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect2.Rectangle2

Rect2\Draw = @Draw_Rectangle()
Rect2\Erase = @Erase_Rectangle()
Rect2\x1 = 0
Rect2\x2 = 10
Rect2\y1 = 0
Rect2\y2 = 20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To use `Rect2`’s `Draw()` and `Erase()` methods, I shall proceed the same way as before: through `CallFunctionFast()`.

This demonstrates that the `Rectangle2` Class inherited the properties of the `Rectangle` Class.

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Inheritance is a category of polymorphism. The object `Rect2` can be also seen as an Object from the `Rectangle` Class —  just don’t use the `Erase()` method! By inheritance, the object carries several forms: those of the objects coming from the Parent Classes. It is called inheritance polymorphism.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Overloading

During initialization of an object, its function pointers are initialized by assigning to them the addresses of the methods suiting the object.

So, given an object `Rect` from the `Rectangle` Class, by writing:

!comment( Example N. 4.5-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect1\Draw = @Draw_Rectangle()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


I can invoke its `Draw()` method the following way:

!comment( Example N. 4.5-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CallFunctionFast(Rect1\Draw, @Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Now, imagine that it was possible to implement another method for displaying a rectangle (by using a different algorithm from the one in the first method).

Let us call this implementation as `Draw_Rectangle2()`:

!comment( Example N. 4.5-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Draw_Rectangle2(*this.Rectangle)
  ; [ ...some code... ]
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


It’s possible to initialize our object `Rect1` with this new method effortlessly:

!comment( Example N. 4.5-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect1\Draw = @Draw_Rectangle2()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To use the method, write again:

!comment( Example N. 4.5-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CallFunctionFast(Rect1\Draw, @Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


We can see that with both the former method (ie: `Draw_Rectangle()`) as well as the latter (ie: `Draw_Rectangle2()`) the use of the `Rect1` method is strictly identical.

It isn’t possible to distinguish by the single line of code `CallFunctionFast(Rect1\Draw, @Rect1)` which one of the `Draw()` methods the `Rect1` object is really using.
To know this, it is necessary to go back to the object initialization.

The notion of *function pointer* allows overloading the `Draw()` method.

One limitation: the use of the `CallFunctionFast()` instruction implies paying attention to the number of parameters passed.

# Conclusion:

In this first implementation, we produced an object capable of meeting the main object-oriented concepts, albeit with certain limitations.

We mainly just lay the foundations upon which we shall implement a more complete object — thanks to PureBasic’s `Interface` statement!

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[Second Implementation]: purebasic-oop-5.html

