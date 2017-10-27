Syntax Highlighting SCSS Modules
================================

The Sass modules for creating syntax highlighting themes for code higlighted by pandoc (Skylighting) or Highlight.

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Files List](#files-list)
-   [Themes](#themes)
-   [Theme Templates](#theme-templates)
    -   [Pandoc/Skylighting](#pandocskylighting)
-   [Code Classes](#code-classes)

<!-- /toc -->

------------------------------------------------------------------------

Files List
==========

-   [`_code-classes.scss`](./_code-classes.scss) — Color schemes for non-highighlited code with classes.
-   [`_fasm.scss`](./_fasm.scss)
-   [`_purebasic.scss`](./_purebasic.scss)
-   [`___skylighting-template.scss`](./___skylighting-template.scss)

Themes
======

-   [`_fasm.scss`](./_fasm.scss) — Fasm theme (Highlight)
-   [`_purebasic.scss`](./_purebasic.scss) — PureBASIC theme (Highlight)

Theme Templates
===============

-   [`___skylighting-template.scss`](./___skylighting-template.scss)

Pandoc/Skylighting
------------------

The file [`___skylighting-template.scss`](./___skylighting-template.scss) is a template for creating SCSS syntax higlighting themes for code highlighted by pandoc. Just copy it and start building your theme on top of it:

    ==============================================================================
                         Bare-Bones Pandoc Highlighting Theme                     
    ==============================================================================
    "bare-bones.scss" v1.0 (2017-07-11) by Tristano Ajmone.

    This Sass template emulates the definitions and structure of pandoc's built-in
    CSS styles (skylighting themes for syntax highlighting).

    All possible syntax tokens are covered.

    Use it as a starting point for your custom themes: adjust it to your needs and
    delete tokens that don't apply to the language/syntax you're targeting.

It was taken from the [Pandoc-Goodies](https://github.com/tajmone/pandoc-goodies) project:

-   <https://github.com/tajmone/pandoc-goodies/blob/master/skylighting-css/sass-templates/bare-bones.scss>

Code Classes
============

The [`_code-classes.scss`](./_code-classes.scss) file defines color schemes for (non-highighlited) code with classes:

-   `cmd` class: Mimick Window’s CMD default color scheme.
-   `dos` class: Mimick Window’s DOS default color scheme.

> **NOTE**: Currently `cdm` and `dos` classes yeld the same result, but in the future they will have a bar above with “CMD” or “MS DOS” caption!
