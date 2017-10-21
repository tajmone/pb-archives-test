PP Macros
=========

Butler’s PP macros for The PureBASIC Archives project.

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Introduction](#introduction)
-   [License](#license)
-   [Credits](#credits)

<!-- /toc -->

------------------------------------------------------------------------

Introduction
============

This folder contains the PP macros employed by Butler CMS to build The PureBASIC Archives html documentation. The macros were created by Tristano Ajmone, 2017.

Macros definitions are organized by categories, in separate modules. The `macros.pp` file imports all the module filess:

-   [`macros.pp`](./macros.pp) (imports all modules)
    -   [`Alerts.pp`](./Alerts.pp) — GitHub-style [Alerts](http://primercss.io/archive/alerts/) (aka Flash messages).
    -   [`BlockFormatting.pp`](./BlockFormatting.pp) — shortcut-macros for various html block elements.
    -   [`GFM-TaskList.pp`](./GFM-TaskList.pp) — mimick GitHub flavored markdown [Task Lists](https://help.github.com/articles/basic-writing-and-formatting-syntax/#task-lists).
    -   [`Highlight.pp`](./Highlight.pp) — syntax highlighting via André Simon’s [Highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php).
    -   [`InlineFormatting.pp`](./InlineFormatting.pp) — shortcut-macros for various html inline elements.
    -   [`LinkingHelpers.pp`](./LinkingHelpers.pp) — macros for cross-reference anchors, navigation, etc.
    -   [`Verbatim.pp`](./Verbatim.pp) — misc. macros to handle verbatim text.

For more information on how PP macros work, see:

-   <https://github.com/CDSoft/pp#macros>
-   <https://github.com/tajmone/markdown-guide/tree/master/pp>

License
=======

-   [`LICENSE`](./LICENSE) (MIT License file)

<!-- -->
    MIT License

    Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>

Credits
=======

My wholeharted gratitude to Christophe Delord «**@CDSoft**», creator of PP, for all the kind and precious support to all my features request. Without his dedication this project wouldn’t have been possible.

-   <http://cdsoft.fr/>
-   <https://github.com/CDSoft>
-   <https://github.com/CDSoft/pp>

