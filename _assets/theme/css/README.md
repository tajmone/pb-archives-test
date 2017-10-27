PureBASIC Archives Theme (CSS)
==============================

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Folder Contents](#folder-contents)
-   [License](#license)
-   [Copyright](#copyright)
-   [Credits](#credits)
    -   [Derivative Code](#derivative-code)
        -   [Normalize-scss](#normalize-scss)
        -   [Primer CSS](#primer-css)
    -   [Color Schemes](#color-schemes)
        -   [PureBASIC](#purebasic)
        -   [Base16 Eighties](#base16-eighties)
        -   [Base16 Monokai](#base16-monokai)
    -   [Third Party Tools](#third-party-tools)
        -   [Typey](#typey)
        -   [Chroma](#chroma)
        -   [Gridle](#gridle)
        -   [Font Awesome](#font-awesome)
    -   [Miscellanea](#miscellanea)

<!-- /toc -->

------------------------------------------------------------------------

Folder Contents
===============

This folder contains the css stylesheet of the “**PureBASIC Archives Theme**” and related files:

-   [`LICENSE`](./LICENSE) — MIT License text.
-   [`styles.css`](./styles.css) — Theme stylesheet.
-   [`styles.css.map`](./styles.css.map) — Theme stylesheet map.

License
=======

The theme’s stylesheet was created by Tristano Ajmone (using Sass) and released under the MIT license (see [`LICENSE`](./LICENSE) file for more details).

The original Sass project can be found in:

-   `../_sass/` (only available in the source branch of The PureBASIC Archives)

Copyright
=========

    Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>
    Copyright (c) Nicolas Gallagher and Jonathan Neal and John Albin Wilkins
    Copyright (c) 2016 GitHub Inc.
    Copyright (c) 2012 Chris Kempson
    Copyright (c) 2016 Dave Gandy

Credits
=======

Derivative Code
---------------

The stylesheet contains CSS code derived from the following projects:

### Normalize-scss

-   <https://github.com/JohnAlbin/normalize-scss>

<!-- -->
    MIT License

    Copyright © Nicolas Gallagher and Jonathan Neal and John Albin Wilkins

John Albin Wilkins’ Sass version of Nicolas Gallagher’s Normalize.css, a collection of HTML element and attribute rulesets to normalize styles across all browsers:

-   <http://necolas.github.io/normalize.css>
-   <https://github.com/necolas/normalize.css>

The theme’s Sass project uses the “Typey, Chroma and KSS” fork-version of Normalize-scss:

-   <https://github.com/JohnAlbin/normalize-scss/tree/master/fork-versions/typey-chroma-kss>

### Primer CSS

-   <https://github.com/primer/primer-css>
-   <http://primercss.io/>

<!-- -->
    MIT License

    Copyright (c) 2016 GitHub Inc.

The CSS framework that powers GitHub’s front-end design.

> **NOTE**: Various SCSS/CSS snippets have been taken from Prime CSS source code and adapted in the Theme’s Sass project to implement a GitHub-like style for some HTML elements (more details can be found in the SCSS source files comments).

Color Schemes
-------------

The color values of the following color schemes were used in this theme for syntax highlighting:

### PureBASIC

The color scheme adopted for syntax highlighting PureBASIC code reuses the default colors of PureBASIC’s native IDE.

-   <https://www.purebasic.com>

PureBasic is copyright © 1998-2017 Fantaisie Software.

PureBasic IDE was build by Frédéric Laboureur, aka «Fred».

### Base16 Eighties

-   <https://github.com/chriskempson/base16-builder/blob/master/schemes/eighties.yml>

<!-- -->
    MIT License

    Copyright (c) 2012 Chris Kempson

The color scheme adopted for syntax highlighting Fasm code was created by converting to SCSS the YAML source of the “Eighties” color scheme by Chris Kempson (<http://chriskempson.com>).

### Base16 Monokai

-   <https://github.com/chriskempson/base16-builder/blob/master/schemes/monokai.yml>

<!-- -->
    MIT License

    Copyright (c) 2012 Wimer Hazenberg
    Copyright (c) 2012 Chris Kempson

The default syntax highlighting color scheme (adopted for code for which there is no specific theme) was created by converting to SCSS the YAML source of the “Monokai” color scheme by Wimer Hazenberg (<http://www.monokai.nl>).

Third Party Tools
-----------------

The following third-party Sass modules were employed in the source project to build the final CSS stylesheet of the theme:

### Typey

-   <https://github.com/jptaranto/typey>

<!-- -->
    GPLv2 License

    Copyright (c) Jack Taranto

A complete Sass framework for working with typography on the web.

### Chroma

-   <https://github.com/JohnAlbin/chroma>
-   <http://johnalbin.github.io/chroma/>

<!-- -->
    GPLv2 License

    Copyright (c) John Albin Wilkins

A Sass library for color management.

### Gridle

-   <http://gridle.org>
-   <https://github.com/Coffeekraken/gridle>

<!-- -->
    MIT License

    Copyright Olivier Bossel

Gridle is a set of complete and simple settings, mixins and classes that make the creation and usage of grid systems (even complex ones) really simple.

### Font Awesome

-   <http://fontawesome.io/>
-   <https://github.com/FortAwesome/Font-Awesome>

The iconic font and CSS toolkit.

This project includes the Font Awesome Sass module (`/scss/` folder of the original project).

<!-- -->
    MIT License

    Font Awesome by Dave Gandy - http://fontawesome.io

Miscellanea
-----------

-   The theme’s breadcrumbs CSS was inspired by Sebastiano Guerriero’s tutorial *Breadcrumbs & Multi-Step Indicator*:

    -   <https://codyhouse.co/gem/css-breadcrumbs-and-multi-step-indicator/>


