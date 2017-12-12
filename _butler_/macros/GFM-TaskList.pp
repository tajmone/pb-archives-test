!comment(   "GFM-TaskList" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"GFM-TaskList.pp" v0.4 (2017-12-12) Alpha

A set of macros for enabling GFM task lists within pandoc documents:

-- https://help.github.com/articles/basic-writing-and-formatting-syntax/#task-lists

------------------------------------------------------------------------------
MACROS LIST:

-- !TaskList
-- !Task
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
REQUIREMENTS: GitHub's Primer CSS style definitions for the "task-list" and
              "task-list-item" classes, so that Task Lists are displayed
              correctly.
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment(   Usage Examples   )
``````````````````````````````````````````````````````````````````````````````
The usage of the TaskList macros is best illustrated by examples.

SIMPLE TASK LIST EXAMPLE:

    !TaskList
    ~~~~~~~~~~~~~~~~
    !Task[ ][Task 1]
    !Task[x][Task 2]
    !Task[ ][ ...  ]
    !Task[ ][Task n]
    ~~~~~~~~~~~~~~~~

NESTED TASK LIST EXAMPLE:

Using brackets and indentation to wrap sublists.

    !TaskList
    ~~~~~~~~~~~~~~~~~~~~~~~
    !Task[ ][Task 1][
      !Task[x][SubTask 1]
      !Task[ ][SubTask 2][
        !Task[x][Sub-SubTask 1]]]
    !Task[x][Task 2]
    ~~~~~~~~~~~~~~~~~~~~~~~

NESTED TASK LIST ALTERNATIVE SYNTAX EXAMPLE:


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

``````````````````````````````````````````````````````````````````````````````



!comment(   TaskList   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Macro to enclose all Tasks of a Task-List.

``````````````````````````````````````````````````````````````````````````````
!define(   TaskList   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<ul class="task-list">
!1
</ul>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!comment(   Task   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Macro to define single task-list items.
            The third parameter (optional) can be used to enclose a sublist
            of tasks.

USAGE: !Task( TASK STATE )( TASK TEXT )[( A SUB-TASKS LIST )]

``````````````````````````````````````````````````````````````````````````````
!define(   Task   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<li class="task-list-item"><input type="checkbox" disabled=""!ifeq[!1][x][ checked=""]>&thinsp;!2!ifndef(3)(</li>)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!TaskList(!3)
</li>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

