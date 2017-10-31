---
title:          PureBasic and Object-Oriented Programming
subtitle:       2\. Object Concepts
meta-title:     PureBasic OOP (2) Object Concepts
author: Dräc
description: >-
    PureBASIC OOP Tutorial (2/9) — Analysis of the Object-Oriented Programming
    paradigm, its concepts and features. 
keywords:       OOP, object-oriented, programming, paradigm, concepts
baseliner: true
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_ConceptObjet_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## STATUS: CHECKED

- [WWW ORIGINAL](http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_ConceptObjet_en.htm)

__TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Wrap __Terminlogy__ in `Alert`]
!Task[x][Add metadata (description, keywords, ecc)]
!Task[x][Fix links (internal, using Header identifiers):]
~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][... allow defining [Object Classes][The Notion of Class]]
~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Add `subtitle` and fix header levels]
!Task[x][Fix subtitle casing]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Object-Oriented Programming paradigm introduces concepts like: objects,  inheritance and polymorphism.
Before jumping into how these concepts can be implemented in PureBasic, we must first define them.

# The Notion of Object

An object has an internal state:

*   The state is represented by the value of each inner component at a given moment,
*   A component is either a value or another object.

It uses and provides services:

*   It interacts with the outside through functions called «methods».

It is unique (notion of identity).

An object can be seen at two levels:

*   By the services which it provides: external view (specification). This is the User side,
*   By the way these services are implemented within it: internal view (implementation). This is the Developer side.

From the developer’s point of view, an object is a contiguous memory area containing information: variables called *attributes* and functions called **methods**.

The fact that we refer to an object’s functions as «its methods» is because they belong to it and allow manipulation of its attributes.

# The Notion of Class

This is an extension of the concept of «*type*» found in PureBasic.

In a given context, multiple objects can have the same structure and behavior.
They can therefore be grouped together in the same «**Class**».

From a developer’s point of view, a Class defines the type of contents that will be held by objects belonging to it: the nature of their attributes (type of each variable) and their methods (names, implementation).

Just as integer is the type of a variable, the type of an object is its Class.

# The Notion of Instance

An instance is an object defined from a Class.

This process is called «**instanciation**».

It corresponds to the assignement of variables in PureBasic.

Normally, an object is *initialized* at the time of its instanciation.

# Encapsulation

In theory, the manipulation of an object’s attributes should be possible only through its methods. This technique, which allows making visible to the user only a part of the object, is called «**encapsulation**».

The advantage of encapsulation is that it guarantees the integrity of attributes. Indeed, the developer is the only one who, through the methods provided to the user, manages the modifications allowed on an object.

!comment( TODO: SENTENCE BELOW NEEDS CHECKING )

At our level, this is the least that should be retained of the encapsulation concept.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ORIGINAL TEXT:
At our level, it is at least what it shall be retain about encapsulation concept.

C'est du moins, à notre niveau ce que l'on en retiendra.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Inheritance

Inheritance allows defining new Classes by using already existing ones.

From the developer’s point of view, it means being able to add/modify attributes and methods to/of an existing Class in order to define a new Class.

There are two kinds of inheritances:

*   **Simple inheritance**: the new Class is defined from a single existing Class.
*   **Multiple inheritance**: the new Class is defined from several existing Classes.

Multiple inheritance is complex to implement, and it will not be covered here.
Thus, this papers deals only with simple inheritance.

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Terminology:

* The Class which inherits from another Class, is usually called **Child Class**.
* The Class which gives its inheritance to a Child Class is usually called **Parent Class**.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Overloading

A method is overloaded if it carries out different actions according to the nature of the target objects.

Let us take an example:

The following objects: circle, rectangle and triangle are all geometrical shapes.
We can define for these objects the same Class with the given name: `Shape`.
Thus, these objects are all instances of the `Shape` Class.

If we want to display the objects, the `Shape` Class needs to have a `Draw` method.

So endowed, every object has a `Draw` method to display itself. Now, this method could not possibly be the same for each object, since we want to display a circle, in one case, a rectangle, in another, etc.

Objects of the same Class employ the same `Draw` method, but the object’s nature (Circle, Rectangle, or Triangle) dictates the actual implementation of the method.
The `Draw` method is overloaded: for the user, displaying a circle or a rectangle is achieved in the same way.
From the developer’s point of view, the methods implementations needs to be different.

Instead of overloaded methods, we can also speak of polymorphic methods (having several forms).

# The Notion of Abstract Class

As we’ve seen, a Class includes the definition of both attributes and methods of an object.
Let us suppose that we can’t provide the implementation of one of the Class methods. This method is just a name without code. We’re then speaking of an «**abstract method**».
A Class containing at least one abstract method qualifies as an «**abstract Class**».

You might wonder why an abstract class should exist at all, since objects of such a Class can’t be created. Abstract Classes allow defining [Object Classes][The Notion of Class], which are considered — by opposition — as being «concrete». The transition from the former to the latter occurs through inheritance, where the concrete Class takes care of providing the missing implementations to the abstract methods inherited.

Thus, abstract Classes are a kind of interface, because they describe the generic specification of all the Classes which inherit from them.

