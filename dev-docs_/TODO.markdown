

---
title: "PureBASIC Archives: TODOs List"
meta-title: "TODOs"
date: 2017-10-14
author: Tristano Ajmone
# toc:
---

# TODO Before Publishing

The following tasks must be fulfilled before publishing on GitHub:

!comment{
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}

## Miscellanea

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Cleanup all folders]
!Task[x][Create Git files:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][`.gitattributes`] to handle EOL normalization.
!Task[ ][`.gitignore`:]
~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Add `*.url` and `*.lnk`]
!Task[X][Add `__*` pattern (etc) for temp & backup files]
~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Pagination

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Instead of using Gridle Rows, try to fit pagination bars inside document, and top bar below title/subtitle.]
!Task[ ][If `_butler.yaml` file was loaded _before_ actual source document, macros could be defined to be injected in pagination's YAML header (as well as other useful places.)]
!Task[ ][When implemented loading `_butler.yaml` before doc, use custom PP macros for pagination vars in OOP tutorial]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


---------------------------------------

!inc(_TODO-inc_PP-Macros.markdown)

---------------------------------------

!inc(_TODO-inc_Theme.markdown)

---------------------------------------

!inc(_TODO-inc_Butler.markdown)

---------------------------------------

!inc(_TODO-inc_Pandoc-Template.markdown)

---------------------------------------

!inc(_TODO-inc_Sass-Folder.markdown)

---------------------------------------

!inc(_TODO-inc_Licenses.markdown)


------------------

# Long-Term TODOs

The following tasks are for the long-term planning, and can be taken care even after publishing on GitHub:

## Sass/CSS

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Add FontAwesome Sass code]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Pandoc Template

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Make sidebar after TOC usable on demand]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Butler

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Implement functionality:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][download/update PP]
!Task[ ][download/update Pandoc]
!Task[ ][download/update Highlight]
!Task[ ][version constraints `~` and `^` (SemVer and Ver)]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Implement options:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][`--dry-run`]
!Task[ ][`--unbuild` (folder and All)]
!Task[ ][`--undeploy`]
!Task[ ][`--create-ini`]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## PP Macros

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Create Licenses macros (to emit tables like on [choosealicense.com](https://choosealicense.com))]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment{
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
