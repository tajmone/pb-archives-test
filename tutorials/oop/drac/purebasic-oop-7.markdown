---
title:          PureBasic and Object-Oriented Programming
subtitle:       7\. PB Class
meta-title:     PureBasic OOP (7) PB Class
author: Dräc
description: >-
    PureBASIC OOP Tutorial (7/9) — Implementing Classes in PureBASIC: the
    final source code for achieving Object-Oriented Programming, commented
    and explained with examples.
keywords:       PureBasic, OOP, object-oriented, programming, classes,
                implementation, example, library
# Pagination Alt text macros defined in "_bulter.pp":
pagination:
    - text: PREV
      link: purebasic-oop-6.html
      alt:  !PREV
    - text: TOC
      link: index.html
      alt:  !TOC 
    - text: NEXT
      link: purebasic-oop-8.html
      alt:  !NEXT
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Classes_PB_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IN THE ORIGINAL DRAC SITE INDEX, THESE ARE THE H1 LEVELS OF THIS CHAPTER:
 - Class
 - Class : EndClass
 - Method : EndMethod
 - New : EndNew
 - Free : EndFree
 - Inheritance
 - Discussion
 - Reminder of types

IN THIS DOC, CURRENTLY THE H1s ARE:

 - PureBasic Class
 - Second Code-Example
 - Class : EndClass
 - Method : EndMethod
 - Object Constructor
 - Object destructor
 - Inheritance
 - Discussion
 - Reminder of Types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Now that we’ve explored OOP concepts and their possible implementations in PureBasic, it’s time to establish an implementation.

Here I shall present an implementation which I deem, to the best of my current knowledge, as the one best fitting OOP programming in PureBasic.

It is based on all the previously exposed work, as well as on my personal practical experience with the subject matter at hand.
Another goal here is to simplify the use of object concepts, through clear commands and by automating operations as much as possible.
During this step, macros are going to play a decisive role.
Greatly facilitated by the `Interface` and `Macro` commands, the proposed implementation remains naturally limited by the language itself.

At first, I’ll present the instructions for a Class in PureBasic. Then I’ll analyze what hides behind by firing parallels with the previous pages. This chapter ends with a discussion about the choices made.

# PureBasic Class

!comment( Example N. 8.1-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object class
Class(<ClassName>)
  [Method1()]
  [Method2()]
  [Method3()]
  ...
  Methods(<ClassName>)
    [<*Method1>]
    [<*Method2>]
    [<*Method3>]
    ...
  Members(<ClassName>)
    [<Attribute1>]
    [<Attribute2>]
    ...
EndClass(<ClassName>)

; Object methods (implementation)
Method(<ClassName>, Method1) [,<variable1 [= DefaultValue]>,...])
  ...
  [ProcedureReturn value]
EndMethod(<ClassName>, Method1)

; ...(ditto For each method)...

; Object constructor
New(<ClassName>)
  ...
EndNew

; Object destructor
Free(<ClassName>)
  ...
EndFree
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


As shown, a PureBasic Class revolves around four main themes:

*   Definition of the Class via the `Class : EndClass` block,
*   Implementation of the Class’ methods via the `Method : EndMethod` block,
*   Construction of the object via the `New : EndNew` block,
*   Destruction of the object via the `Free : EndFree` block.

# Second Code-Example

Here is a header file cotaining the definition of this set of commands, along with a usage-example file (based on the [previous inheritance example], so that you might compare them):

* [`OOP.pbi`]
* [`OOP-Inheritance-Ex2.pb`]

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you have already looked at the source code of the `OOP.pbi` file, you might have noticed that the code of the final OOP implementation is slightly more complex than its presentation in this tutorial. This is because some rearrangements were made in the code in order simplify its maintainance.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Let me guide you through the PureBasic Class declaration…

# Class : EndClass

The `Class : EndClass` block allows declaring three types of constituent:

*   The object’s **Interface**, i.e: the only part of the object that the user can handle.
*   The object’s *Methods* — implementation excluded — which are reduced to pointers to the methods.
*   The object’s *Members* — methods excluded. Henceforth, the terms «**member**» and (more correctly) «**attribute**» will mainly refer to just these elements of an object (not including its methods, which are also members of the object, strictly speaking).

!comment( Example N. 8.2-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object class
Class(<ClassName>)
  [Method1()]
  [Method2()]
  [Method3()]
  ...
  Methods(<ClassName>)
    [<*Method1>]
    [<*Method2>]
    [<*Method3>]
    ...
  Members(<ClassName>)
    [<Attribute1>]
    [<Attribute2>]
    ...
EndClass(<ClassName>)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Each constituent is clearly identified with keywords: `Class`/`Methods`/`Members`.
Their order must be preserved and all keywords must always be present, even when a method or a member will not be declared.
Also, the name of a class is always a parameter of the keyword, and must be enclosed in parentheses.

The explanation for this is to be found in the definition of each keyword. Here is the code:

### Class keyword

!comment( Example N. 8.2-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Class(ClassName)
  ; Declare the class interface
  Interface ClassName#_
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The keyword `Class` defines just the header of the `Interface` statement. The name of the interface is derived from the Class’ name followed by “`_`”. So, whatever follows `Class` will become the definition of the object’s interface.

### Methods keyword

!comment( Example N. 8.2-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Methods(ClassName)
  EndInterface
  ; Declare the method-table structure
  Structure Mthds_#ClassName
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The keyword `Methods` starts by closing the interface’s definition with `EndInterface`. Then it opens the definition of the `Structure` which defines the pointers to the methods.

### Members keyword

!comment( Example N. 8.2-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Members(ClassName)
  EndStructure
  ; Create the method-table
  Mthds_#ClassName.Mthds_#ClassName
  ; Declare the members
  ; No parent class: implement pointers for the Methods and the instance
  Structure Mbrs_#ClassName
    *Methods
    *Instance.ClassName
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The keyword `Members` is more complicated than the two previous ones.

It begins by closing the `Structure` definition previously opened by `Methods`. Then it declares the **method table**, using the freshly-built structure (as its type). For the moment this table is empty; it will be filled up a the end of `Method : EndMethod` statement. I’ll be discussing this further on ([I can’t wait!][EndMethod keyword]).

Finally `Members` ends by opening the `Structure` declaration which defines the object’s members. In first position — as expected — we find the pointer to the *method table* (i.e.: to the variable just mentioned above). Its assignment will be done later, by the Constructor.
Then follows another pointer, which will contain the address of the object itself. I shall explain later the reasons for this new member ([no, now!]).

!comment( TODO: SENTENCE BELOW NEEDS CHECKING )

After the `Members` keyword, the user has only to declare the other members of the object.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ORIGINAL TEXT:
It remains for the user simply to declare the other members of the object next Members keyword.

Il reste simplement pour l’utilisateur qu’à déclarer les autres membres de l’objet à la suite de l’instruction Members.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### EndClass keyword

!comment( Example N. 8.2-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro EndClass(ClassName)
  EndStructure

  Structure ClassName
    StructureUnion
      *Md.ClassName#_     ; its methods
      *Mb.Mbrs_#ClassName ; its memebers
    EndStructureUnion
  EndStructure
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `EndClass` keyword code is at the origin of the implementation chosen for our object. So I’m now going to describe it correctly.

As with `Methods` and `Members`, it begins by closing what was opened by the previous keyword, in this case: the `Structure` describing the object’s members.

Then, follows a `Structure` named as the Class’ name, which will be use to instanciate the object.

This `Structure` is in fact the union of two elements:

1.  The first is a pointer typed by the interface which allows to call the object’s methods.
2.  The second is a pointer typed by the structure defining members. It helps accessing the object’s members.

This design puts into practice the optimizations for `Get()` and `Set()` methods presented in the [Appendix]. The benefit of this choice is twofold:

-   It provides a seamless approach for reaching an object’s methods and members.

    To reach a method, write:

    !comment( Example N. 8.2-6 )

    !PureBasic
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    *Rect\Md\Draw()
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    To reach an attribute, write:
    
    !comment( Example N. 8.2-7 )
    
    !PureBasic
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    *Rect\Mb\var1
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


*   It prevents having to systematically declare an object’s `Get()` and `Set()` methods, when these are trivial. This saves time and it’s practical.
At the same time, it reduces the number of objects’ methods (small optimization).

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The price of this choice is that all members of an object are visible to the user.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This structure could be slighly retouched. Since terms like “`Md`» and “`Mb`» are visually very similar, a better distinction could be arranged. Although this choice was not retained, here is an interesting possibility:

!comment( Example N. 8.2-8 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure ClassName
  StructureUnion
    *Md.ClassName#_       ; methods
    *Get.Mbrs_#ClassName  ; used to read a member
    *Set.Mbrs_#ClassName  ; used to modify a member
  EndStructureUnion
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


In this code, the `*Mb` pointer was replaced by two pointers: `*Get` and `*Set`. They have the same functionality but they can lead to more legible code, by clarifying if an attribute is being read or modified.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Method : EndMethod

The `Method : EndMethod` block allows to achieve implementation of the various methods of an object.

!comment( Example N. 8.3-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object methods (implementation)
Method(<ClassName>, Method1) [,<variable1 [= DefaultValue]>,...])
  ...
  [ProcedureReturn value]
EndMethod(<ClassName>, Method1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Each keyword occurence has the Class name and the method name as parameters.

Usewise, `Method : EndMethod` works like `Procedure : EndProcedure` — in fact it’s a wrapper of this block, as we shall see next.

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Note the very special syntax of the method which requires two closing parentheses. This specificity ensues from the use of a macro combined with a different number of possible arguments for each method.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Method keyword

!comment( Example N. 8.3-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Method(ClassName, Mthd)
  Procedure Mthd#_#ClassName(*this.Mbrs_#ClassName
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `Method` keyword is nothing more than a `Procedure` instruction for pre-declaring the variable `*this`, which is required as first argument.

The code omits the closing parenthesis so that the user might complete it by adding the parameters specific to its method.
It’s the user’s responsibility to close this parenthesis, as shown in the syntax — and if he forgets, the compiler won’t fail to notice it!

### EndMethod keyword

!comment( Example N. 8.3-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro EndMethod(ClassName, Mthd)
  EndProcedure
  ; Save the method’s address into the method-table
  Mthds_#ClassName\Mthd=@Mthd#_#ClassName()
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `EndMethod` keyword begins by closing the `Procedure` opened by the `Method` keyword.
Once defined, the method can be referenced in the `method table` (declared by the `Members` keyword of the Class). Actually, by declaring a method, this method is automatically referenced.

# Object Constructor

The `New : EndNew` block allows to instanciate a new object of the Class by declaring and initializing it.

!comment( Example N. 8.4-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object constructor
New(<ClassName>)
  ...
EndNew
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `New` keyword takes the class name as parameter.

### New keyword

!comment( Example N. 8.4-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro New(ClassName)
  Declare Init_Mbers_#ClassName(*this, *input.Mbrs_#ClassName=0)

  Procedure.l New_#ClassName(*input.Mbrs_#ClassName =0)
    Shared Mthds_#ClassName
    ; Allocate the memory required for the object members
    *this.Mbrs_#ClassName = AllocateMemory(SizeOf(Mbrs_#ClassName))
    ; Attach the method-table to the object
    *this\Methods=@Mthds_#ClassName
    ; The object is created then initialized
    ; Create the object
    *this\Instance= AllocateMemory(SizeOf(ClassName))
    *this\Instance\Md = *this
    ; Now init members
    Init_Mbers_#ClassName(*this, *input)
    ProcedureReturn *this\Instance
  EndProcedure

  Init_Mbers(ClassName)
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment( TODO: SENTENCE BELOW NEEDS CHECKING )

The `New` keyword is dense, but hasn’t really changed compared to the previous design.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OR MAYBE:
The `New` keyword is dense, but not really different in design compared to what seen so far.

NOTE: It’s not clear what the author is comparing it to:
(1) The general macros design seen so far, or
(2) The previous implementation of the New() concept in the First Implementation.
The English text seems to point to (1), but the French text to (2).

ORIGINAL TEXT:
New keyword is dense but doesn’t change really compare to previous design.

L’instruction New est dense mais ne change pas vraiment par rapport à la structuration vue auparavant.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The goal of this keyword is to create a new object and initialize it. These tasks are performed in the `New_ClassName` procedure, which is the main part of the `New` macro.

This procedure accepts a single argument, the one required by `Init_Mbers` for attributes initialization.

It begins by allocating the memory space required for the object’s members.

Then it attaches to the object the *method table* of the Class.

Next it instanciates the object by assigning an address to it and initializing the interface.

Then follows initialization of the object’s attributes via the `Init_Mbers` method.

Finally, `New` returns the object’s address.

The trick in the `New` macro is that it ends with the `Init_Mbers` keyword. This way, what the user has to add inside the `New : EndNew` block is simply the attributes initialization. More on that in a moment though ([Show me now!][Init_Mbers : EndInit_Mbers private block]).

This arrangement is made possible by declaring the `Init_Mbers` method first in the macro.

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Notice how the `New_ClassName` procedure is common to all kind of Classes. It is because its variable part (and therefore object-specific) was externalized into the `Init_Mbers` method.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### EndNew keyword

!comment( Example N. 8.4-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro EndNew
  EndInit_Mbers
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `EndNew` keyword is limited to calling the `EndInit_Mbers` keyword, which completes the  attributes’ initialization declaration started at the end of the `New` macro.

Conclusion: the goal is reached. Through the `New : EndNew` block, we have created from the Class a new object with initialized methods and attributes.

In practical use, the `New : EndNew` block allows to initialize attibutes like this:

!comment( Example N. 8.4-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New(Rect1)
  *this\var1 = *input\var1
  *this\var2 = *input\var2
  ; [ ...some code... ]
EndNew
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


to instanciate such an object, write:

!comment( Example N. 8.4-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
input.Mbrs_Rect1
input\var1 = 10
input\var2 = 20

; *Rect is a new object from Rect1 class
*Rect.Rect1 = New_Rect1(input)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Note that the constructor name is `New` followed by the Class’ name separated by “`_`”.

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!anchor(admonition-on-object-being-a-pointer)
In relation to what was studied up to now, the object will always be a pointer. It isn’t an issue, rather it’s the consequence of our choice of grouping together access to methods and members ([What?! I don’t remember!][EndClass keyword]).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!anchor(admonition-about-this-instance)
The choice of `StructureUnion` requires two different memory allocations: one for the members, and one to regroup methods and members (4 bytes here).
This bivalence — which didn’t exist in the previous implementation — leads us to store information into the object itself. So, within the object’s methods you can access its members address through `*this`, and its instance’s address (method and members) through `*this\Instance`.

An important feature ensues: the us of `*this\Instance` to call the object’s methods within its methods (__No, I’m not drunk__!). This is the best way to do it, because it hides the name of the procedure behind the method, which is an essential part of the inheritance process.

For this purpose, a `Mtd` macro is present in the [`OOP.pbi`] file.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Init_Mbers : EndInit_Mbers private block

The `Init_Mbers: EndInit_Mbers` is a private block of the OOP implementation, used by the `New : EndNew` block to initialize an object’s attributes. Explaining this internal block is important for understanding how initialization of an object will be carried out.

!comment( Example N. 8.4-6 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Attributes initialization
Init_Mbers(<ClassName>)
  ...
EndInit_Mbers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Between the two keywords are a series of member’s initialization.
Note that only the `Init_Mbers` keyword requires the Class’ name as parameter.

##### Init_Mbers keyword

!comment( Example N. 8.4-7 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Init_Mbers(ClassName)
  Method(ClassName, Init_Mbers), *input.Mbrs_#ClassName =0)
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `Init_Mbers` instruction is defined as a method of the object accepting a single argument.

In order to initialize the object according to the user’s wishes, and because the number of its members can’t be known in advance, it was chosen to pass information by reference.

This choice is reinforced by the bias that it’s the Constructor’s responsibility to initialize the object (by calling this particular method).
Last but not least, this arrangement allows to automate the process of inheritance.

In practical use, members’ initialization will mostly look like this:

!comment( Example N. 8.4-8 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Init_Mbers(Rect1)
  *this\var1 = *input\var1
  *this\var2 = *input\var2
  ; [ ...some code... ]
EndInit_Mbers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##### EndInit_Mbers keyword

!comment( Example N. 8.4-9 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro EndInit_Mbers
  EndProcedure
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `EndInit_Mbers` keyword is nothing more than the `EndProcedure` keyword, which ends the definition of the object’s initialization method.

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you are the impatient sort, and have already peeked at the source code, you might have noticed that the final OOP implementation file includes extra optional parameters, named `arg1` to `arg5`. This is because in some situations it is useful to complete the standard `*input` pointer by additional information.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Object destructor

The `Free: EndFree` block allows to destroy an object of the Class and to restore its memory.

!comment( Example N. 8.5-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object destructor
Free(<ClassName>)
 ...
EndFree
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `Free` keyword takes the Class’ name as parameter.

#### Free : EndFree block

!comment( Example N. 8.5-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Macro Free(ClassName)
  Procedure Free_#ClassName(*Instance.ClassName)
    If *Instance
EndMacro

Macro EndFree
      FreeMemory(*Instance\Md)
      FreeMemory(*Instance)
    EndIf
  EndProcedure
EndMacro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The `Free : EndFree` block is rather simple.

*   `Free` opens a `Procedure` with the object’s address as argument. We then check that the passed argument is not a Null address — nevertheless, it doesn’t guarantee that it’s a valid address for `FreeMemory()`!
*   `EndFree` releases the memory allocated to the object’s members, then that of the object itself — in that specific order.

In practical use, to free an object’s intance write:

!comment( Example N. 8.5-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Free_Rect1(*Rect)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


As for the constructor, note that the destructor’s name is “`Free`” followed by the class’ name separated by “`_`”.

!AlertError
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If your object consists of other objects — i.e.: that some objects are members of the current object, and they exist by (and for) this object (__hic__!) — it’s then important to free them too, by calling their destructors in-between the `Free` and `EndFree` keywords.

Even if PureBasic does automatically free the allocated memory areas, it will occur only when the programs ends. During programs execution, it is up to the user to take care of any garbage memory, especially its bloat.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Inheritance
In the set of commands just exposed, nothing makes reference to the process of inheritance. It is normal, because the current commands do not support it! (__Damn__! __What an anguish__!)! We need to introduce an additional set of commands to deal with the concept (__Arghhh__! __Mega-anguish__!).

Fortunately, it is not rocket science, and our design is ready for this (__Phew__! __I’m feeling better now__).

Here is what the Class looks like in this case:

!comment( Example N. 8.6-1 )

!PureBasicEX()(pseudocode)(PureBASIC pseudocode for syntax illustration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Object class
ClassEx(<ClassName>,<ParentClass>)
  [Method1()]
  [Method2()]
  [Method3()]
  ...
  MethodsEx(<ClassName>,<ParentClass>)
    [<*Method1>]
    [<*Method2>]
    [<*Method3>]
    ...
  MembersEx(<ClassName>,<ParentClass>)
    [<Attribute1>]
    [<Attribute2>]
    ...
EndClass(<ClassName>)

; Object methods (implementation)
Method(<ClassName>, Method1) [,<variable1 [= DefaultValue]>,...])
  ...
  [ProcedureReturn value]
EndMethod(<ClassName>, Method1)

; ...(ditto For each method)...

; Object constructor
NewEx(<ClassName>,<ParentClass>)
  ...
EndNew

; Object destructor
Free(<ClassName>)
  ...
EndFree
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Four extra keywords are supplied as replacements for `Class`, `Methods`, `Members` and `New` keywords: `ClassEx`, `MethodsEx`, `MembersEx` and `NewEx` (respectively).

For each new keyword, in addition to the current class’ name, its parent class’ name is now a parameter being passed.

The operation is simple enough for the end user, making the process of inheritance easily accessible.

In order to save space, I won’t review here the code of the new keywords; but it might be a good idea to check out [`OOP.pbi`] in your IDE to get a feel of it.

# Discussion

Phew! The presentation of a PureBasic Class is finished.

What else? Well, macros allow to define a real set of commands that:

*   Clarify the object’s structure,
*   Facilitate or automate some processes, like methods’ initialization or inheritance.

I list here the various design choices which drive the object’s conception. Let me remind you that it’s possible to partly re-adapt the design to customize objects, according to your own style, without fundamentally altering it:

1.  Use `StructureUnion` to define the object. It confers to the object the peculiarity to act on the members without requiring any mutator (setter/getter) method.

2.  The *method table* is class-specific and not object-specific:

    *   It is initialized only once, at the beginning of program execution, rather than at objects’ instanciation time,
    *   Objects’ instances store only a pointer to their **method table**: a substantial save of memory space,
    *   All the objects point to the same **method table**, which guarantees identical behavior for all objects of the same class.

3.  A constructor which initializes the object by taking a single pointer as its input parameter, which store the initialization data of the object. The process of inheritance is largely facilitated.
We can envisage to split the process in two steps: step one, the user create an object; step two, the user calls the initialization routine himself. In this case, the `Init_Mbers` method is no longer called by the `New` method, and therefore it might contain any number of arguments. Two disadvantages:

    *   The risk of an incorrect initialization of the object: one can forget to do it, but — more important — it’s no longer possible to automate the inheritance process: it’s up to the user to manage it!
    *   Strong class-interdependence of input parameters: as soon as the initialization method’s parameters of a parent class change, the user has to carry out this changes across all its children classes.

    In extreme — but it’s not advisable — we can imagine the user initializing all members, one after the other, by using mutators (setters).
    But members’ initialization doesn’t always boil down to mere assignment operations: it may involve more complex internal operations to reach its goal.
    If this is going to be repeated with each new object, it is strongly recommended to keep a dedicated method.

4.  A destructor consistent with the constructor. It is not part of the interface, although it possibly could be. In this case, to free an object write `Objet\Md\Free()` instead of writing `Free_ClassName(object)`. This arrangement is easy to operate, and doesn’t alter the design of the object.

5.    I have not managed to automate the generation of the `method table`. It is important to remember why it was implemented with a `Structure`. Structures allow to create abstract classes — i.e.: classes whose methods are not implemented. It is a major notion of OOP’s concepts. Structures facilitate preserving the addresses’ order within the *method table* — whatever the implemented methods of the Class might be —, which in turn preserves the inheritance process! Using an array, a linked list, or a hash map as replacement for a Structure shall not provide this flexibility (at least I didn’t find such a solution).

# Reminder of Types

Here is a list of the types used by a Class:

|               Type               |     Applied to    |   Origin   |
|----------------------------------|-------------------|------------|
| `<ClassName>`                    | Object instance   | `EndClass` |
| `<ClassName>_`                   | Interface         | `Class`    |
| `Mthds_<ClassName>`              | Method Table      | `Methods`  |
| `Mbrs_<ClassName>_` !fa(warning) | Members structure | `Members`  |
| `Mbrs_<ClassName>`               | Members structure | `EndClass` |

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!fa(warning) The `Mbrs_<ClassName>_` type wasn’t presented in this paper. It is an intermediate step used to build the `Mbrs_<ClassName>` structure of the members definition. This arrangement is required to achieve the `*this\Instance` feature [explained here].
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          

NOTE: More ref.links are defined in "_butler.yaml"!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[previous inheritance example]: purebasic-oop-6.html#first code-example

[no, now!]: #admonition-on-object-being-a-pointer

[Appendix]: purebasic-oop-9.html

[explained here]: #admonition-about-this-instance

