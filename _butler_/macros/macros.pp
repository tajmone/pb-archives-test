!comment( pp-macros loader module )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"macros.pp" v0.3 (2017-11-05) Alpha

The main macro that imports all other macros modules. Also creates a macro to
emit a markdown list of all modules files.

MACROS LIST:

- !ListMacrosFiles

------------------------------------------------------------------------------
NOTE: When adding/deleting modules to the import list, remember to also update
	  the !ListMacrosFiles definition to match the changes!
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!import(  GFM-TaskList.pp      )
!import(  Verbatim.pp          )
!import(  Highlight.pp         )
!import(  InlineFormatting.pp  )
!import(  LinkingHelpers.pp    )
!import(  BlockFormatting.pp   )




!comment(   ListMacrosFiles   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Emits a markdown bullet list of all the macros modules imported by
			"macros.pp". Used in the "/dev-docs_/" section
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
``````````````````````````````````````````````````````````````````````````````
!define(    ListMacrosFiles   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `GFM-TaskList.pp`
- `Verbatim.pp`
- `Highlight.pp`
- `InlineFormatting.pp`
- `LinkingHelpers.pp`
- `BlockFormatting.pp`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
