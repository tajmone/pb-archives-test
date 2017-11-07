!comment(   pp-macros loader module   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"macros.pp" v0.4 (2017-11-07) Alpha

The main macro that imports all other macros modules. Importing is done via
the "!importAdd(MODULE FILE)" custom macro, which also creates a MD list of all
the imported modules (see end comments).

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!import(   macros-init.pp   )



!importAdd(  GFM-TaskList.pp      )
!importAdd(  Verbatim.pp          )
!importAdd(  Highlight.pp         )
!importAdd(  InlineFormatting.pp  )
!importAdd(  LinkingHelpers.pp    )
!importAdd(  BlockFormatting.pp   )




!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              MAINTAINERS MACROS                              
------------------------------------------------------------------------------
This module also creates (via "macros-init.pp") some useful macros for 
maintainers of project documentation:

- !ListMacrosFiles
        Emit a markdown list (unordered) of all the modules files that were
        loaded here.

- !ListMacrosFilesLinks
        Like !ListMacrosFiles, but list entries have links to the files.

- !ROOT
        Relative path back to project's root (empty if we are already in root).
        Always ends with "/" (unless empty).

- !PATH2MACROS
        Relative path to the project's PP macros folder (ie: /_butler_/macros/)

------------------------------------------------------------------------------
NOTES:

-- The ROOT symbol is dynamically created by Butler, via the CLI invocation
   option "-D".
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
