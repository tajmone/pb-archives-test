---
title:          PureBasic and Object-Oriented Programming
subtitle:       5\. Second Implementation
meta-title:     PureBasic OOP (5) 
author: Dräc
description: >-
    PureBASIC OOP Tutorial (5/9) — Second implementation of Object-Oriented
    paradigm in PureBasic: Object Instanciation, Constructor, Initialization,
    Destructor, Inheritance, Get() and Set() object methods.
keywords:       PureBasic, OOP, object-oriented, programming, tutorial,
                instanciation, initialization, constructor, destructor,
                inheritance
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Implementation2_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In our first implementation, object concepts were adapted in a more or less extended way.
Now, it’s time to improve this first implementation thanks to the use of the `Interface` instruction.

# Notion of Object Interface

The main purpose of encapsulation is to make visible, to the user, only part of an object contents.
The visible part of an object’s contents is called its **interface**, the hidden part is called it **implementation**.

Therefore, an object’s interface is the only input/output access available to the user for interacting with it.

This is the aim that we are going to achieve through the use of the `Interface` instruction.

The `Interface` instruction allows to group, under the same name, all or part of an object’s methods which the user will have the right to access.

# Object Instanciation and Object Constructor

Implementing an Interface involves three steps:

1. An `Interface` describing the required methods,
2. A `Structure` describing the pointers of the corresponding functions,
3. A **method table**: a structured variable initialized with the required functions adresses.

Step 1, consists in specifying the object’s `Interface`; this is not difficult. Just name the methods.

Steps 2 and 3 are linked. In our object approach, we already have the adapted `Structure`: it’s the one that describes the Class of an object.
Moreover, the Interface and the Class of an object are similar: both contain functions pointers.
Simply, the `Interface` instruction doesn’t contain the Class attributes but only all or part of its methods.

Therefore it’s possible to use an object’s Class to initialize its Interface. This approach is the most natural one. Let’s not forget that an interface is the visible part of an object’s Class, so it is natural that the Class determines the Interface.

To see how this can be achieved, let’s carry on with the example of the `Rectangle2` class, which provided the `Draw()` and `Erase()` methods.

The corresponding Class is:

!comment( Example N. 6.2-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2
  *Draw
  *Erase
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure

Procedure Draw_Rectangle(*this.Rectangle2)
  ; [ ...some code... ]
EndProcedure

Procedure Erase_Rectangle(*this.Rectangle2)
  ; [ ...some code... ]
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The associated Interface is:

!comment( Example N. 6.2-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rectangle
  Draw()
  Erase()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Since the user can handle an object only through its Interface, the object must be created directly from the `Rectangle` Interface, rather than from the `Rectangle2` Class.

The object will thus be created by writing:

!comment( Example N. 6.2-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect.Rectangle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


instead of `Rect.Rectangle2`.

However, you should not forget to connect the Interface to the Class.
For this, it is necessary to initialize the `Rect` object during its declaration.
Correction made, the proper instruction to declare the object is the following one:

!comment( Example N. 6.2-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect.Rectangle = New_Rect(0, 10, 0, 20)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


`New_Rect()` is a function which performs the initialization operation.
We already know that its returned value is the memory address containing the functions addresses to be processed by the interface.

Here is the body of the `New_Rect()` function:

!comment( Example N. 6.2-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure New_Rect(x1.l, x2.l, y1.l, y2.l)
  *Rect.Rectangle2 = AllocateMemory(SizeOf(Rectangle2))

  *Rect\Draw = @Draw_Rectangle()
  *Rect\Erase = @Erase_Rectangle()

  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2

  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


This function allocates a memory area with the same size as the object’ Class size.
Then it initializes the methods and attributes of the object.
Finally, it ends by returning the memory area’s address.
Because the addresses of the `Draw()` and `Erase()` functions are positioned at the beginning of this memory area, the Interface is effectively initialized.

To access the methods of the `Rect` object, just write:

!comment( Example N. 6.2-6 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect\Draw()
Rect\Erase()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Therefore, we have ascertained that:

* Class `Rectangle2` allows initialization of the object’s Interface .
* `Rect` — declared via `Interface` — is an object of the `Rectangle2` Class, and can use the `Draw()` and the `Erase()` methods.

Thus the `Interface` instruction and the `New_Rect()` function perform the instanciation of a `Rect` object from the `Rectangle2` Class.
The `New_Rect()` function is the *Constructor* for objects of the `Rectangle2` Class.

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
All the Methods implementations (`Procedure : EndProcedure` blocks) must contain, as first argument, the `*this` pointer of the object. On the other hand, the `*this` argument mustn’t appear at the `Interface` level. In fact, as this instruction allows to write `Rect\Draw()`, it knows that the `Draw()` method involves the `Rect` object: no ambiguity! Everything happens as if the object `Rect` was «aware» of its state.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!anchor(admonition-constructor-parameters)
The Constructor could receive, as parameters, the whole functions addresses which implement the methods. This is not the case here, because we know the implemented methods: the ones from the class. On the other hand the initial state desired by the user is unknown. Thus, the Constructor may contain parameters for attributes initialization.
This case applyes here: the paramters required by `New_Rect()` are the two coordinates (`x1`, `y1`) and (`x2`, `y2`) of the diametrically opposite points of the rectangle.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Object Initialization

We’ve seen that after allocating the required memory area for an object, the Constructor initializes the various members of the object (methods and attributes).
This operation can be isolated in a specific procedure, called by the Constructor.
This precaution allows to make a distinction between an object’s memory allocation and its initialization. This approach will turn out to be very useful later on, when implementing the concept of Inheritance, because a single memory allocation is sufficient, but several initializations are required.

In addition, initialization of methods and attributes are separated too — because the methods implementation depends on the class, while the attributes initialization depends on the object itself (see [previous remark]).

In our example, the two initialization procedures will be implemented as:

!comment( Example N. 6.3-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mthds_Rect(*Rect.Rectangle2)
  *Rect\Draw = @Draw_Rectangle()
  *Rect\Erase = @Erase_Rectangle()
EndProcedure

Procedure Init_Mbers_Rect(*Rect.Rectangle2, x1.l, x2.l, y1.l, y2.l)
  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


and the Constructor becomes:

!comment( Example N. 6.3-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure New_Rect(x1.l, x2.l, y1.l, y2.l)
  *Rect = AllocateMemory(SizeOf(Rectangle2))
  Init_Mthds_Rect(*Rect)
  Init_Mbers_Rect(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Object Destructor

An object *Constructor* is always associated with its counterpart: the object **Destructor**.
During construction of an object, a memory area is allocated to store its method and attribute definitions.
When an object becomes useless, it must be destroyed to free the computer memory.
This process is performed by using a specific function, known as the object’s **Destructor**.

In our example of `Rectangle2` objects, the Destructor will be:

!comment( Example N. 6.3-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Free_Rect(*Rect)
  FreeMemory(*Rect)
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


and can be used by:

!comment( Example N. 6.3-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Free_Rect(Rect2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Destructor could be seen as a method of the object. But to avoid weighing down the object, and to preserve homogeneity with the Constructor, I have chosen to see it as a function of the Class.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To delete an object by its Destructor means releasing the memory area containing its information (the methods it uses, and the state of its attributes) but not deleting the object’s infrastructure.
So, in our example, after doing a:


!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Free_Rect(Rect2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


`Rect2` can be reused without specify its type again:


!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect2 = New_Rect(0, 10, 0, 20)
Rect2\Draw()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Indeed, after we instantiate an object with:


!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect2.Rectangle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


the life cycle of object `Rect2` follows the same rules that apply to variables — because `Rect2` is first of all a variable: it is a structured variable, holding the functions pointers of the object’s methods. (See also the following reminder)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Small reminder: the life cycle of a variable is linked to the life cycle of the program part where the variable is declared:

* If the variable is declared inside a procedure, its life cycle will be linked to that of the procedure — i.e., it’s equal to the function’s time of use.
* If the variable is declared outside any procedure, in the program’s main body, its life cycle is linked to that of the program.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Memory Allocations

At every new instanciation, the Constructor has to dynamically allocate a memory area the size of the information describing the object.
For this purpose, the Constructor should use the `AllocateMemory()` command; and the Destructor should use its associated counterpart, the `FreeMemory()` command.

But there are also other candidates for achieving dynamic memory allocation.
Under Windows OS, for example, the Windows API could be employed directly.

PureBasic’s standard library provides linked lists, which are also a good candidate for dynamically allocating some memory.

# Encapsulation

Suppose now that we wanted to restrict the user’s access to just the `Draw()` method of the Class `Rectangle`. We shall begin by defining the desired interface:

!comment( Example N. 6.6-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rectangle
  Draw()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Instanciation of a new object reamins the same:

!comment( Example N. 6.6-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect.Rectangle = New_Rect()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


with

!comment( Example N. 6.6-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mthds_Rect(*Rect.Rectangle2)
  *Rect\Draw = @Draw_Rectangle()
  *Rect\Erase = @Erase_Rectangle()
EndProcedure

Procedure Init_Mbers_Rect(*Rect.Rectangle2, x1.l, x2.l, y1.l, y2.l)
  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2
EndProcedure

Procedure New_Rect(x1.l, x2.l, y1.l, y2.l)
  *Rect = AllocateMemory(SizeOf(Rectangle2))
  Init_Mthds_Rect(*Rect)
  Init_Mbers_Rect(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


It is similar to the previous example, because the first function address is that of the `Draw()` method.

Now, suppose that we wanted to give to the user only the access to the `Erase()` method. We shall begin by defining the new interface:

!comment( Example N. 6.6-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rectangle
  Erase()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Nevertheless, to instanciate the new object I cann’t use the `New_Rect()` Constructor above:
doing so would yeld results identical to the previous case, and `Rect\Erase()` would call the `Draw()` method.

Thus, a new Constructor is needed, capable of returning the correct function address.

Here it is:

!comment( Example N. 6.6-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mthds_Rect2(*Rect.Rectangle2)
  *Rect\Draw = @Erase_Rectangle()
  *Rect\Erase = @Draw_Rectangle()
EndProcedure

Procedure Init_Mbers_Rect(*Rect.Rectangle2, x1.l, x2.l, y1.l, y2.l)
  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2
EndProcedure

Procedure New_Rect2(x1.l, x2.l, y1.l, y2.l)
  *Rect = AllocateMemory(SizeOf(Rectangle2))
  Init_Mthds_Rect2(*Rect)
  Init_Mbers_Rect(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Notice how the functions addresses were simply inverted at the initialization level.
Certainly, it is not a very elegant solution to allocate the `Draw` field of `Rectangle2`’s `Structure` with an other function’s address.
But it allows to preserve the same `Structure` of the Class; and it also underlines a point:
function pointers’ names are less interesting than their values!

To solve this false problem, just rename the pointers of the Class as follows:

!comment( Example N. 6.6-6 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2
  *Method1
  *Method2
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Indeed, it’s the Interface and the Constructor which give meaning to these pointers:

* by giving them a name (task of the interface)
* by allocating them the adequate functions addresses (task of the constructor)

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In spite of this arrangement concerning the function pointers’ names, it remains more practical to keep an explicit name when not considering to hide methods (which is the most common scenario). This allows to modify a Parent Class without having to retouch the pointers’ numbering in Children Classes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Inheritance

For our first implementation of the inheritance concept, let’s takes advantage of the fact that the `Structure` and `Interface` instructions can be extended thanks to the `Extends` keyword.

So, to pass from the `Rectangle1` Class, which has a single `Draw()` method…

!comment( Example N. 6.7-1 )

!Caption(Interface)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rect1
  Draw()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-2 )

!Caption(Class)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle1
  *Method1
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure

Procedure Draw_Rectangle(*this.Rectangle1)
  ; [ ...some code... ]
EndProcedure

Procedure Init_Mthds_Rect1(*Rect.Rectangle1)
  *Rect\Method1 = @Draw_Rectangle()
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-3 )

!Caption(Constructor)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mbers_Rect1(*Rect.Rectangle1, x1.l, x2.l, y1.l, y2.l)
  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2
EndProcedure

Procedure New_Rect1(x1.l, x2.l, y1.l, y2.l)
  *Rect = AllocateMemory(SizeOf(Rectangle1))
  Init_Mthds_Rect1(*Rect)
  Init_Mbers_Rect1(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


…to a `Rectangle2` Class, which has two methods: `Draw()` and `Erase()`, we write:

!comment( Example N. 6.7-4 )

!Caption(Interface)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rect2 Extends Rect1
  Erase()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-5 )

!Caption(Class)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2 Extends Rectangle1
  *Method2
EndStructure

Procedure Erase_Rectangle(*this.Rectangle1)
  ; [ ...some code... ]
EndProcedure

Procedure Init_Mthds_Rect2(*Rect.Rectangle2)
  Init_Mthds_Rect1(*Rect)
  *Rect\Method2 = @Erase_Rectangle()
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-6 )

!Caption(Constructor)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mbers_Rect2(*Rect.Rectangle2, x1.l, x2.l, y1.l, y2.l)
  Init_Mbers_Rect1(*Rect, x1, x2, y1, y2)
EndProcedure

Procedure New_Rect2(x1.l, x2.l, y1.l, y2.l)
  *Rect = AllocateMemory(SizeOf(Rectangle2))
  Init_Mthds_Rect2(*Rect)
  Init_Mbers_Rect2(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Carrying out an inheritance doesn’t consist only in extending the object’s `Interface` and Class `Structure`, but also in adapting the initialization of its methods and attributes.
The `Init_Mthds_Rect2()` and `Init_Mbers_Rect2()` procedures call, respectively, the initialization of Class `Rectangle1`’s  methods (`Init_Mthds_Rect1()`) and attributes (`Init_Mbers_Rect1()`), rather than the `New_Rect1()` Constructor.
This because the Child Class object (`Rectangle2`) doesn’t need to instantiate its Parent Class object (`Rectangle1`), but just to inherit its methods and attributes.

On the other hand, we must verify that any changes made to the Parent Class (adding a method or a variable) should be immediately reflected in its Child Class.

So, is the current state of inheritance correct? No, because it doesn’t allow the object of the Child Class (`Rectangle2`) to use the new `Erase()` method.
The reason being that the function pointer `*Method2` doesn’t immediately follow `*Method1` in order of succession.

If we look at the explicit `Structure` of the `Rectangle2` Class, we find:

!comment( Example N. 6.7-7 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2
  *Method1
  x1.l
  x2.l
  y1.l
  y2.l
  *Method2
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


instead of the `Structure` below, which permits a correct initialization of the interface:

!comment( Example N. 6.7-8 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2
  *Method1
  *Method2
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Remember that a correct interface initialization requires that this successsion of functions addresses appears in the same order within its `Interface` ([see previous note]).

To solve this problem, we’ll just group all the methods into a specific `Structure`!
The Class’s `Structure` will need just a pointer to this new `Structure`, as shown in the following example:

!comment( Example N. 6.7-9 )

!Caption(Interface)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rect1
  Draw()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-10 )

!Caption(Class)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle1
  *Methods
  x1.l
  x2.l
  y1.l
  y2.l
EndStructure

Procedure Draw_Rectangle(*this.Rectangle1)
  ; [ ...some code... ]
EndProcedure

Structure Methds_Rect1
  *Method1
EndStructure

Procedure Init_Mthds_Rect1(*Mthds.Mthds_Rect1)
  *Mthds\Method1 = @Draw_Rectangle()
EndProcedure

Mthds_Rect1.Mthds_Rect1
Init_Mthds_Rect1(@Mthds_Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-11 )

!Caption(Constructor)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mbers_Rect1(*Rect.Rectangle1, x1.l, x2.l, y1.l, y2.l)
  *Rect\x1 = x1
  *Rect\x2 = x2
  *Rect\y1 = y1
  *Rect\y2 = y2
EndProcedure

Procedure New_Rect1(x1.l, x2.l, y1.l, y2.l)
  Shared Mthds_Rect1
  *Rect.Rectangle1 = AllocateMemory(SizeOf(Rectangle1))
  *Rect\Methods = @Mthds_Rect1
  Init_Mbers_Rect1(*Rect, x1, x2, y1, y3)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `Methds_Rect1` structure describes all the functions pointers of the Class’ methods.
Then follows the `Methds_Rect1` variable declaration (of the `Methds_Rect1` type) and its initialization thanks to `Init_Mthds_Rect1()`.

The `Methds_Rect1` variable is the Class’ **method table**, because it contains the set of all the addresses of its methods. This set constitutes the complete description of the methods of the Class.

The `Structure` of `Rectangle1` now contains the `*Methods` pointer, which is initialized by passing the `Methds_Rect1` variable address to the Constructor.

!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The following expression:

!comment( Example N. 6.7-12 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Mthds_Rect1.Mthds_Rect1
Init_Mthds_Rect1(@Mthds_Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


can be condensed into:

!comment( Example N. 6.7-13 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Init_Mthds_Rect1(@Mthds_Rect1.Mthds_Rect1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Inheritance can be now performed correctly, because by extending `Methd_Rect1`’s `Structure` into the new `Methd_Rect2`, the functions’ addresses are going to be consecutive:

!comment( Example N. 6.7-14 )

!Caption(Interface)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface Rect2 Extends Rect1
  Erase()
EndInterface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-15 )

!Caption(Class)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rectangle2 Extends Rectangle1
EndStructure

Procedure Erase_Rectangle(*this.Rectangle2)
  ; [ ...some code... ]
EndProcedure

Structure Methds_Rect2 Extends Methds_Rect1
  *Method2
EndStructure

Procedure Init_Mthds_Rect2(*Mthds.Mthds_Rect2)
  Init_Mthds_Rect1(*Mthds)
  *Mthds\Method2 = @Erase_Rectangle()
EndProcedure

Mthds_Rect2.Mthds_Rect2
Init_Mthds_Rect2(@Mthds_Rect2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( Example N. 6.7-16 )

!Caption(Constructor)

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Init_Mbers_Rect2(*Rect.Rectangle2 , x1.l, x2.l, y1.l, y2.l)
  Init_Mbers_Rect1(*Rect, x1, x2, y1, y2)
EndProcedure

Procedure New_Rect2(x1.l, x2.l, y1.l, y2.l)
  Shared Mthds_Rect2
  *Rect.Rectangle2 = AllocateMemory(SizeOf(Rectangle2))
  *Rect\Methods = @Mthds_Rect2
  Init_Mbers_Rect2(*Rect, x1, x2, y1, y2)
  ProcedureReturn *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


In this example, `Rectangle2`’s `Structure` is empty, and it isn’t a problem. Here are two reasons why:

* First, the `*Methods` pointer only needs to exist once, and this is in the Parent Class.
* Second, no supplementary attributes have been added to it.

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
There are three advantages in having the methods’ initialization function external to the Constructor, and the method table in a single variable:

* The Class’ method table needs to be initialized only once, and not at each object instanciation,
* Object instances will hold a single pointer toward their methods’ pointers: it is a substantial gain in memory,
* Since all objects referr to the same method table, this guarantees identical behavior for all objects of the same Class.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Get() and Set() Object Methods

Through an `Interface`, it’s only possible to access an object’s methods.
The interface encapsulates completely the object’s attributes.
In order to allow access the object’s attributes — to examine, or to modify them — we must provide specific methods to the user.
The methods allowing to examine objects’ attributes are called `Get()` methods.
The methods allowing to modify objects’ attributes are called `Set()` methods.

In our example of the `Rectangle1` Class, if I want to examine the value of the `var2` attribute, I should create the following `Get()` method:

!comment( Example N. 6.8-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Get_var2(*this.Rectangle1)
  ProcedureReturn *this\var2
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Similarly, to modify the value of the `var2` attribute, I should write the following `Set()` method:

!comment( Example N. 6.8-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure Set_var2(*this.Rectangle1, value)
  *this\var2 = value
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Since `Get()` and `Set()` methods exist only to allow the user to modify all (or some) of the object’s attributes, they necessarily belong to the `Interface`.

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
See the [Appendix] of the tutorial for possible optimizations of `Get()`’s and `Set()`’s performance during execution.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[previous remark]: #admonition-constructor-parameters

[see previous note]: purebasic-oop-4.html#admonition-on-structure-interface-symmetry

[Appendix]: purebasic-oop-9.html

