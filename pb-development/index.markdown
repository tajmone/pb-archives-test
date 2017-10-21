
---
title:    PureBASIC Development
subtitle: Resources for Devloping in PureBASIC
# baseliner: true
...

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__WIP TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][[`/licenses/`](./licenses/index.html): Update files to 5.61 (current: 5.50!)]
!Task[ ][[`/pb-ide/tools/pbhgen/`](./pb-ide/tools/pbhgen/index.html):]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Rewrite index file with better text]
  !Task[ ][Also keep original `README.md` file for GH repo viewing]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][[`/purelibs/scintilla/`](./purelibs/scintilla/index.html)]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Subfolders need index?]
  !Task[ ][Update files to 5.61 (current: 5.50!)]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][[`/purelibs/regex/`](./purelibs/regex/index.html)]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Checks PCRE docs integration]
  !Task[ ][Update files to 5.61 (current: 5.50!)]
~~~~~~~~~~~~~~~~~~~~~~~~~
regex!Task[ ][Fix]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


PureLibraries
=============

-   [`/purelibs/`](./purelibs/index.html)

This folder contains reference material and resources for PureLibraries (PureBASIC’s built-in libraries).

------------------------------------------------------------------------

Licenses
========

-   [`/licenses/`](./licenses/index.html)

This folder contains resources for software and software-related licenses.

------------------------------------------------------------------------

PureBASIC IDE Tools
===================

Beside PureBASIC IDE’s built-in Tools, it’s possible to add custom external tools to the **Tools** menu.

-   [Using external tools](https://www.purebasic.com/documentation/reference/ide_externaltools.html) (PB online documentation)

Users have created a wide range of custom tools to enhance PB development workflow withouth leaving the IDE. I’ll try to maintain here a curated list of such tools.

PBHGEN (PureBasic Header Generator)
-----------------------------------

by [Henry de Jongh](https://00laboratories.com/about/henry-de-jongh) | License: [CC-BY 4.0](https://bitbucket.org/Henry00/pbhgen/src/e5828286b22ca59ec6168e49c57a1c51718978b4/LICENSE?at=master&fileviewer=file-view-default) | Supported OS: All

-   [`/pb-ide/tools/pbhgen/`](./pb-ide/tools/pbhgen/index.html) – PBHGEN v5.42 (taken from [PBHGEN on Bitbucket](https://bitbucket.org/Henry00/pbhgen))
-   [PBHGEN homepage](http://00laboratories.com/downloads/programming/purebasic-header-generator) (00laboratories)
-   [PBHGEN on Bitbucket](https://bitbucket.org/Henry00/pbhgen)
-   [PBHGEN thread on PB Forums](http://www.purebasic.fr/english/viewtopic.php?f=27&t=53414)

PBHGEN will read a PureBasic source file (`*.pb`) and generate a header file (`*.pbi`) out of it, automatically generating `Declare` statements for every procedure. Works also with [SpiderBasic](https://www.spiderbasic.com/).

External Links to IDE Tools
---------------------------

### History Viewer

by HeX0Rs | License: Copyrighted, closed-source | Supported OS: Win + Linux

-   [History Viewer for Windows](http://hex0rs.coderbu.de/e107_plugins/download/download.php?view.2)
-   [History Viewer for Linux](http://hex0rs.coderbu.de/e107_plugins/download/download.php?view.10)
-   [History Viewer thread on PB Forums](http://www.purebasic.fr/english/viewtopic.php?f=27&t=45757)

History Viewer is a simple personal VCS (Version Control System) and projects-backup tool:

-   create semantic versioned snapshots of your projects
-   granular preferences-control over which files to include/exclude in snapshots
-   easily view a project’s versioned history
-   view source code changes (diffs) between snapshots
-   selectively restore any snapshot
-   all files archiving and handling transparently managed in the background
-   database driven
-   *and more*…

