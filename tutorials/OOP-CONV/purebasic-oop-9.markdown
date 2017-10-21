---
title:    PureBasic and Object-Oriented Programming
subtitle: Appendix
# meta-title: TITLE_SHOWN_IN_BROWSER_BAR
author: Dräc
# date: YYMMDD
# description: METADATA_DESCRIPTION
# keywords: METADATA_KEYWORDS_LIST
baseliner: true
...

!comment{   ORIGINAL DOC URL   }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Annexes_en.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## STATUS: WIP

- [WWW ORIGINAL](http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Annexes_en.htm)

__TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Fix Ordered Lists (`. text`)]
!Task[ ][Add metadata (description, keywords, ecc)]
!Task[ ][Fix links]
!Task[ ][Add `subtitle` and fix header levels]
!Task[x][Fix subtitle casing]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


This section offers some considerations on how to improve runtime performance of our Object-oriented approach.

# Optimisation: Get() and Set() Methods

Making frequent calls to `Get()` and `Set()` methods means lots of function calls, and therefore a loss in performance.

For those seeking performance, there are two possible ways to speedup the process: both consist in coupling a pointer to the object, but the second solution adds a layer to the first one.

## First Solution

The pointer is specified by the Class’ Structure.

So, for an object `Rect` of the `Rectangle1` Class, write:

!comment( A.1.1-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect.Rect = New_Rect()
*Rect.Rectangle1 = Rect
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To act on the `var2` attribute write:

!comment( A.1.1-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*Rect\var2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


It is then possible to both examine and modify it.

This is the simpler solution to implement.

## Second Solution

The first solution requires that we work with two differently typed elements: `Rect` and `*Rect`.
This second solution suggests grouping these two elements in a `StructureUnion` block.

!comment( A.1.2-1 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Structure Rect_
  StructureUnion
    Mthd.Rect
    *Mbers.Rectangle1
  EndStructureUnion
EndStructure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Creating an object of `Rectangle1` Class means declaring the object through this new Structure, by adapting its constructor like this:

!comment( A.1.2-2 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New_Rect(@Rect.Rect_)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


with,

!comment( A.1.2-3 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure New_Rect(*Instance.Rect_)
  *Rect = AllocateMemory(SizeOf(Rectangle2))
  Init_Rect1(*Rect)
  Init_Rect2(*Rect)
  *Instance\Mthd = *Rect
EndProcedure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To access to the `Draw()` method, write:

!comment( A.1.2-4 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect\Mthd\Draw()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


To access to the `var2` attribute, write:

!comment( A.1.2-5 )

!PureBasic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rect\Mbers\var2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The advantage of this second solution is that there is just a single element that can be dealt with, like an object whose attributes are all accessible from outside of the class.
It also preserves object-oriented notation, although it introduces an extra level in its fields.

The inconvenience lies in the fact that it introduces the necessity of maintaining a new structure within the Class.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

