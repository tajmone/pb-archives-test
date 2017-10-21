
# Task Lists

The usage of the TaskList macros is best illustrated by examples.

## SIMPLE TASK LIST EXAMPLE:

!TaskList
~~~~~~~~~~~~~~~~
!Task[ ][Task 1]
!Task[x][Task 2]
!Task[ ][ ...  ]
!Task[ ][Task n]
~~~~~~~~~~~~~~~~

## NESTED TASK LIST EXAMPLE:

Using brackets and indentation to wrap sublists.

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Task 1][
  !Task[x][SubTask 1]
  !Task[ ][SubTask 2][
    !Task[x][Sub-SubTask 1]]]
!Task[x][Task 2]
~~~~~~~~~~~~~~~~~~~~~~~

## NESTED TASK LIST ALTERNATIVE SYNTAX EXAMPLE:


Using tildas to wrap sublists.


!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Task 1]
~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][SubTask 1]
!Task[ ][SubTask 2]
~~~~~~~~~~~~~~~~~~~
!Task[x][Sub-SubTask 1]
~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Task 2]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~