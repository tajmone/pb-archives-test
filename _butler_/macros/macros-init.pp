!comment(   pp-macros initializer module   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"mmacros-init.pp" v0.1 (2017-11-07) Alpha

This module contains helpers for the "macros.pp" file (the main module that
loads all other macros modules in the library). Kept in a seperate file in
order to keep clean the "macros.pp" file.

It creates the "!importAdd" macro, to be used by "macros.pp" in place of the
default "!import" --- !importAdd creates macros to emit markdown lists of all
the imported modules, helpful to maintain documentation automatically updated.

MACROS LIST:

- !PATH2MACROS
- !importAdd(FILENAME)
- !ListMacrosFiles
- !ListMacrosFilesLinks

------------------------------------------------------------------------------
NOTES:

-- !ROOT symbol is defined by Butler via CLI; it contains the relative path
   back to the project's root folder (empty if we are already in root).
   It uses Unix-style path separators ("/") and always ends with a "/" (unless
   it's empty because we're in root already). Eg:

   		../../../

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   PATH2MACROS   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Relative path to the PP macros folder. Mainly used in this module
			for populating !ListMacrosFilesLinks; but might also be useful to
			maintainer of project documentation.

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
!define(    PATH2MACROS   )(!ROOT_butler_/macros/)
``````````````````````````````````````````````````````````````````````````````
!define(    PATH2MACROS   )(!pp[!ROOT]_butler_/macros/)





!comment(   importAdd   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Imports a macros-definition file and adds it to the entries of
			!ListMacrosFiles and !ListMacrosFilesLinks (Markdown lists).

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
``````````````````````````````````````````````````````````````````````````````
!define(    importAdd   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!append(ListMacrosFiles)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- `!1`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!append(ListMacrosFilesLinks)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- [`!1`](!PATH2MACROS!1 "View the source of '!1' PP macros definition file")
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!import(!1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
