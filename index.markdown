!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## !fa(exclamation-circle) THIS IS AN ALPHA TEST VERSION!

This repository is for Alpha-stage testing of the upcoming new version of The PureBASIC Archives project. When this new version will be ready for publishing, it will overwrite the original project and this testing repo will be deleted:

- https://github.com/tajmone/purebasic-archives
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## TODOs Tasks-Lists

For a full list of the pending tasks before the project is ready for publishing, see:

- [`/dev-docs_/TODO.html`](./dev-docs_/TODO.html)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__WIP__ — This page is being reworked.

TODOs Tasks:

!TaskList{
!Task[ ][Fix section links to `index.html`]    
!Task[ ][Fix HTML-Preview and RawGit links to local links]    
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For a full list of the project's TODOs, see:

- [PROJECT_STATUS.html](./PROJECT_STATUS.html)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The PureBASIC Archives
======================

A collection of PureBASIC resources.

**DIRECT DOWNLOAD** – You can download a full copy of The PB-Archives without using Git:

-   [`master.zip`](https://github.com/tajmone/purebasic-archives/archive/master.zip) – download the production ready version.
-   [`dev-tutorials.zip`](https://github.com/tajmone/purebasic-archives/archive/dev-tutorials.zip) – download also the WIP drafts of upcoming tutorials.

or you may download selected resources as **Zip archives** from the [“Download Links” section](#download-links).


Vanity URLs
===========

-   [git.io/purebasic-archives](https://git.io/purebasic-archives) – Links to PB-Archives’ website
-   [git.io/pb-archives](https://git.io/pb-archives) – Links to PB-Archives’ repo master (here)
-   [git.io/pb-wiki](https://git.io/pb-wiki) – Links to PB-Archives’ Wiki

------------------------------------------------------------------------

Introduction
============

The PB-Archives is a threefold project consisting of:

1.  [PureBASIC Archives repository](https://github.com/tajmone/purebasic-archives)
2.  [PureBASIC Archives Wiki](https://github.com/tajmone/purebasic-archives/wiki)
3.  [PureBASIC Archives website](https://tajmone.github.io/purebasic-archives/)

The project was started by Tristano Ajmone ([@tajmone](https://github.com/tajmone)) in October 2016. The goal of the project is to create a collaborative centralized place for gathering and sharing PureBASIC-related resources: code examples and snippets, libraries, tutorials, books, and links — anything that can simplify a programmer’s life by either being herein archived or linked/reviewed.

PureBASIC Archives Repository
-----------------------------

-   <https://github.com/tajmone/purebasic-archives>

The Git repository is the core of the PB-Archives project: resources of various types are herein stored, organized into categories through folders structure. Documents and tutorials are stored in the repository both in source format (Markdown or AsciiDoc) and in distribution format (HTML, doc, PDF, ecc.).

By cloning the repo, the end user downloads a copy of all of the project’s reosurces, which then become locally available at all times and extremely easy to update and maintain through Git. Hopefully, this should also encourage users to contribute their own resources to the project.

The idea of creating this repo dawned on me when I realized that in the course of time, while working on various PureBASIC projects, I’ve been cumulating lots of resources and notes – mostly buried within each project’s working folders. At the end of each project – when the dev-frenzy cools down – I always try to reorganize my collected notes and resources in a systematic way, so next time I’ll need them they’ll be at my fingertips (without having to sift through all my past projects just because I forgot where I saved them). Well, this project is something along these lines, but on a collaborative scale.

I hope that developers can benefit from having a pool of resources to fish from, and that they might contribute back by sharing their own findings too. It only takes a handful of PureBASIC developers to quickly populate a project like this one.

The Wiki
--------

-   <https://github.com/tajmone/purebasic-archives/wiki>

The GitHub-hosted Wiki associated to the PureBASIC Archives repo is intended as an online reference for PureBASIC – ie: not for tutorials, reviews of third party tools, ecc., but as place where one can quickly find tech specs, FAQs, cross-platform setup and development guidelines, and any answers relating to PureBASIC as a language and application. Tips and tricks might be mentioned therein, as well as links to external resources that are pertinent to the subject matter of a given Wiki entry, but any full-fledged article/tutorial should go inside the repo and linked from the Wiki.

Possibly, in the future, html standalone snaphsots of the Wiki might be included in the PureBASIC Archives repo, for offline reading — that is, if the Wiki ever reaches an interesting size and richness of contents.

PureBASIC Archives Website
--------------------------

-   <https://tajmone.github.io/purebasic-archives/>

Right now, it’s just a single-page website, created with [GitHub’s Automatic Page Generator](https://help.github.com/articles/creating-pages-with-the-automatic-generator/) and freely hosted on [GitHub Pages](https://pages.github.com/). When the documents and tutorials of PB-Archives’ repo and wiki will reach a mature stage, I’m planning to make it a full-fledged and well organized portal – but this is a long-term project, unlikely to happen soon.

For the time being, a single presentation-page is all the website can offer.

Quick Links
===========

Developers’ Resources
---------------------

-   [**Win Registry Module**](./libs/win-registry/index.html) by Thomas Schulz «**ts-soft**» (Windows only). Adds procedures for handling Windows’ registry read/write and delete operations.
-   [**GoScintilla**](./pb-development/purelibs/scintilla/GoScintilla/index.html) by Stephen Rodriguez (updated to PB 5.x): source-code helpers which wrap a lot of the Scintilla API in order to simplify use of Scintilla within applications.
-   [**PBHGEN v5.42**](./pb-development/pb-ide/tools/pbhgen/index.html) by Henry de Jongh: PB-IDE Tool that generates header files (`*.pbi`) for your source code (automatically creates `Declare` staments for your procedures).
-   [fasm resources](./asm/fasm/index.html) folder.

Tutorials
---------

-   Dräc’s «[*PureBasic and Object-Oriented Programming*](http://htmlpreview.github.io/?https://github.com/tajmone/purebasic-archives/blob/master/tutorials/oop/drac/en/OOP-Demystified.html)» tutorial ([Also in French](http://htmlpreview.github.io/?https://github.com/tajmone/purebasic-archives/blob/master/tutorials/oop/drac/fr/POO-Demystifiee.html)) – [source folder](./tutorials/oop/drac/).
-   Vid’s «[*TAJGA FASM Tutorial*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/tajga-fasm-tutorial.html)» (also [available in CHM format](./asm/fasm/tutorials/)) — [source folder](./asm/fasm/tutorials/).
-   Vid’s «[*FASM Preprocessor Guide*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/fasm-preprocessor-guide.html)»

Miscillaneous Utilities
-----------------------

-   [**pandoc2bbcode**](./tools/pandoc2bbcode/) by [lilydjwg](https://github.com/lilydjwg/2bbcode) (依云) and [Tristano Ajmone](https://github.com/tajmone/2bbcode): a script for converting documents to PureBASIC Forums’ BBCode from over 20 input formats (including markdown, html, ODT and docx). Useful for writing elegantly formatted posts on PB forums using Markdown, or to quickly convert existing documents to BBCode.
-   [PureBASIC Syntax Highlighting](./syntax-highlighting/): resources for publishing neatly formatted source code examples.

Download Links
==============

These links allow you to download specific isolated resources by creating a **Zip archive** copy of their folder (via [@KinoLien](https://github.com/KinoLien)’s [GitZip](https://github.com/KinoLien/gitzip)). The Zipped files will be as in the latest version of the master branch.

-   Dräc’s «[*PureBasic and Object-Oriented Programming*](https://kinolien.github.com/gitzip/?download=https://github.com/tajmone/purebasic-archives/tree/master/tutorials/oop/drac)» – tutorial in AsciiDoc and HTML5 (all languages versions), plus PB source code of examples and OOP library.

Resources Organization
======================

The Archives project is divided into folders according to categories:

-   [`/asm/`](./asm/index.html) — x86 Assembly (FASM and Yasm) resources.
-   [`/books/`](./books/index.html) — books on PureBASIC programming.
-   [`/libs/`](./libs/index.html) – 3rd party PureBASIC libraries, modules, wrappers, ecc.
-   [`/os-linux/`](./os-linux/index.html) — PureBASIC for Linux resources.
-   [`/os-mac/`](./os-mac/index.html) — PureBASIC for macOS resources.
-   [`/os-win/`](./os-win/index.html) — PureBASIC for Windows resources.
-   [`/pb-development/`](./pb-development/index.html) – resources for developing in PureBASIC.
-   [`/syntax-highlighting/`](./syntax-highlighting/index.html) — publishing PureBASIC source code in colored syntax.
-   [`/text-editors/`](./text-editors/index.html) — PureBASIC syntax support in text editors.
-   [`/tools/`](./tools/index.html) — any PureBASIC related tools that don’t quite fit anywhere else.
-   [`/tutorials/`](./tutorials/index.html) — PureBASIC learning tutorials.

Some folders contain material specific to this repo’s developement and maintainance:

-   [`/repo-maintainance-tools/`](./repo-maintainance-tools/) — scripts related to the maintainance of this repository.

Developement Branches
=====================

Some resources might require long-term work before being ready for inclusion in the main branch of the repo — eg: porting code from PB v4, translating documents, porting text to Markdown or Asciidoc (from HTML, Doc, or PDF), and so on.

For this purpose, some developement branches have been created to host different kind of works-in-progress (WIP):

-   [`dev-tutorials`](https://github.com/tajmone/purebasic-archives/tree/dev-tutorials) – WIP for upcoming tutorials.
-   [`dev-syntax-highlighters`](https://github.com/tajmone/purebasic-archives/tree/dev-syntax-highlighters) — WIP relating to syntax highlighting ad keeping track of PureBASIC syntax tokens.

You might consider peeking into the dev-branches to get a preview of what is coming next and — why not?! — join the work.

License
=======

This is a collection of various resources, and each resource comes with its own license. Please read carefully the licenses terms on a per-resource basis before incorporating them into your projects.

This repo acts as a «general container» through compartmentalization: hosting each resource under its own folder, governed by its own license terms. **PureBASIC Archives** provides a license-neutral structure for organizing into categories the various resources it hosts. In this respect, it resembles the CD-Roms with collections of software tools which are distributed with computer magazines — except that **PureBASIC Archives** is freely accesible to all.

Nothing has been incorporated here that would prevent cloning this repository.

Third Party Resources Licensing Terms
-------------------------------------

Licenses are placed (or linked/mentioned) in the main folder of each resource and sub-project, and the license terms should cover all files in that folder and sufolders. Further details and exceptions shall be indicated in the `README` file within the resource folder and/or in its parent folder.

«PureBASIC Archives» Overall License Terms
------------------------------------------

As for the project in itself — ie: this repo as a «container», its structural organization, and my personal contributions in terms of documentations (`README` markdown and html files) and project-related resources (scripts, templates, stylesheets, ecc) — its to be considered as released into the public domain according to the Unlicense terms (see: [Unlicense.org](http://unlicense.org/)), unless otherwise specified — since it wouldn’t be feasible to add a public-domain license to every single document file, I’ll instead ensure that a licence file will be provided where required (like third party tutorials and documents).

The choice of the Unlicense public-domain terms for the overall project ensures flexibility in contributing and forking, and should prevent licenses conflicts.

Contributing
============

If you’ve found these archives helpful in finding resources for learning and working with PureBASIC, consider helping the project grow by contributing your own resources, or adding links to external resources, writing reviews or tutorials.

Before submitting pull requests, please read the [`CONTRIBUTING.md`](./CONTRIBUTING.md) file.

Ideas, proposals, and corrections can be discussed by opening an Issue:

-   <https://github.com/tajmone/purebasic-archives/issues>

About PureBASIC
===============

PureBASIC is a commercial programming language and IDE published by Fantaisie Software (France):

-   <https://www.purebasic.com/>

> PureBasic is a native 32-bit and 64-bit programming language based on established BASIC rules. The key features of PureBasic are portability (Windows, Linux and MacOS X are currently supported), the production of very fast and highly optimized executables and, of course, the very simple BASIC syntax. PureBasic has been created for the beginner and expert alike. We have put a lot of effort into its realization to produce a fast, reliable system friendly language.
>
> In spite of its beginner-friendly syntax, the possibilities are endless with PureBasic’s advanced features such as pointers, structures, procedures, dynamically linked lists and much more. Experienced coders will have no problem gaining access to any of the legal OS structures or API objects and PureBasic even allows inline ASM.

Interviews With PureBASIC Developers
------------------------------------

Some interviews by André Beer ([PureArea.net](http://www.purearea.net)) with Frédéric Laboureur (aka **@Fred** and «AlphaSND»), founder of Fantaisie Software and main developer of PureBASIC, and with Timo Harter (**@freak**), 2nd main PureBASIC programmer:

-   [2005 Interview with Fred](http://www.purearea.net/pb/english/interview.htm)
-   [2009 Interview with freak](http://www.purearea.net/pb/english/interview_freak.htm)
-   [2012 Interview with Fred](http://www.purearea.net/pb/english/interview_fred_2012.htm)
-   [2015 Interview with Fred and freak](http://www.purearea.net/pb/english/interview_2015.htm)

More Collections on GitHub
==========================

Some links to other GitHub repos acting as containers for PureBASIC code.

FOSS Collections
----------------

> **NOTE**: The statement “`LICENSE file is a [LICENSE-NAME] template`” means that the author chose a license during repo creation, but did not fill-in its fields (author and project name, date, ecc). Even if the author’s intentions are clear, a blank license template might not be an effective license.

-   blendman/[Purebasic](https://github.com/blendman/Purebasic) – “Some purebasic codes, under GPL.”
-   aziascreations/[Random-PureBasic-Projects](https://github.com/aziascreations/Random-PureBasic-Projects) – “A collection of random PureBasic projects”. LICENSE file is a GNU GPL template.
-   IndigoFuzz/[PureBasicLibrary](https://github.com/IndigoFuzz/PureBasicLibrary) – “Purebasic Code Library: The purpose of this library is to provide a useful repository of code for the PureBasic programming language.” LICENSE file is a GNU GPL template.

Non-FOSS Collections
--------------------

In absence of explicit licensing terms, their contents should be considered copyrighted and for viewing purposes only.

-   aistun/[PureBasic-Sources](https://github.com/aistun/PureBasic-Sources) – various PB project by aistun, in French. No license.

PureBasic CodeArchiv (Rebirth)
------------------------------

-   <https://github.com/GPIforGit/PureBasic-CodeArchiv-Rebirth>

This project deserves a special mention. It seems to be a WIP to recreate an updated version of the historical **PureBasic CodeArchiv**, hosted at PureArea.net:

-   <http://www.purearea.net/pb/CodeArchiv/CodeArchiv.html>

**PureBasic CodeArchiv** contains a wealth of resources for PureBASIC version 3 and 4. Its license terms are:

> Design and compilation of the PureBasic CodeArchive is (c) 2003-2007 by Andre Beer and exclusive component of the www.PureArea.net PureBasic support site. You may use the codes published on this site without restrictions for your own projects, however a publication of this code archive on other web pages, CDRom etc., require the express consent of the author. The copyright of the individual codes lies at the respective authors.

Useful Links
============

External links where you can find more PureBASIC resources.

-   <http://rosettacode.org/wiki/PureBasic>

Acknowledgements
================

-   «[@Sicro](https://github.com/SicroAtGIT)» (maintainer of [PureBasic-CodeArchiv-Rebirth](https://github.com/SicroAtGIT/PureBasic-CodeArchiv-Rebirth)) — for his continuos advice and for providing links to many useful resources.
-   «@Marc56us» — for having written code for the [`/syntax-highlighting/guidelines/`](./syntax-highlighting/guidelines/) section.
-   «**Vid**» of TAJGA Team — for “[*TAJGA FASM Tutorial*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/tajga-fasm-tutorial.html)”, and “[*FASM Preprocessor Guide*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/fasm-preprocessor-guide.html)”.
-   Thomas Schulz «[@ts-soft](http://www.purebasic.fr/english/memberlist.php?mode=viewprofile&u=1214)» — for the [**Win Registry Module**](./libs/win-registry/).
-   Stephen Rodriguez «[@srod](http://www.purebasic.fr/english/memberlist.php?mode=viewprofile&u=678)» — for the [**GoScintilla**](./pb-development/purelibs/scintilla/GoScintilla/) library.
-   Jordan Klassen «[@forivall](https://github.com/forivall)» — for releasing [gh-pandoc.css](https://gist.github.com/forivall/7d5a304a8c3c809f0ba96884a7cf9d7e) under MIT when asked reuse permission.
-   «Dräc» — for releasing his [OOP tutorial](http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Pourquoi_en.htm) under CC BY when asked reprint permission.
-   [Henry de Jongh](https://00laboratories.com/about/henry-de-jongh) – for releasing [PBHGEN](https://bitbucket.org/Henry00/pbhgen) under CC BY when asked reuse permission..

Repo History
============

A record of the milestones of this repository history (reverse order).

-   `2017/10/02`
    -   Updated [**Highlight** PureBASIC lang definition](./syntax-highlighting/highlight) (v1.7).
-   `2017/09/30`
    -   Updated [**Highlight** PureBASIC lang definition](./syntax-highlighting/highlight) (v1.6 — fixes some bugs introduced with v1.4-5).
-   `2017/09/27`
    -   Updated [**Highlight** PureBASIC lang definition](./syntax-highlighting/highlight) (v1.4).
-   `2017/09/08`
    -   Fixed a bug in [**GoScintilla**](./pb-development/purelibs/scintilla/GoScintilla/index.html) (now v3.0.1).
-   `2017/05/26`
    -   Added links to [interviews with PureBASIC developers](#interviews-with-purebasic-developers).
-   `2017/05/24`
    -   updated [**pandoc2bbcode**](./tools/pandoc2bbcode/index.html)’s `bbcode_phpbb.lua` to v1.2.
-   `2017/05/12`
    -   Bug-Fix Update to pre-built [**HJLS-PB v9.11.0b**](./syntax-highlighting/highlight.js/index.html) — some PB keywords were accidentally joined together; now fixed.
    -   New PB keywords list in [`/syntax-highlighting/guidelines/`](./syntax-highlighting/guidelines/index.html).
-   `2017/05/11`
    -   Updated [**Highlight** PureBASIC lang definition](./syntax-highlighting/highlight/index.html) (v1.2): Added inline-Assembly support!
-   `2017/04/30`
    -   Updated pre-built [**Highlight.js**](./syntax-highlighting/highlight.js/index.html) to **HJLS-PB v9.11.0** plus an updated PureBASIC lang definition to PB 5.60.
    -   Updated [**Highlight** PureBASIC lang definition](./syntax-highlighting/highlight/index.html) (v1.1) to PB 5.60.
    -   New [`/syntax-highlighting/guidelines/`](./syntax-highlighting/guidelines/index.html) section dedicated to creators and maintainers of PureBASIC language definitions for syntax highlighters and code editors.
-   `2017/01/26`
    -   Reprinted **Vid**’s “[*FASM Preprocessor Guide*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/fasm-preprocessor-guide.html)”
-   `2017/01/25`
    -   Reprinted **Vid**’s “[*TAJGA FASM Tutorial*](https://cdn.rawgit.com/tajmone/purebasic-archives/1351562/asm/fasm/tutorials/tajga-fasm-tutorial.html)” (also [available in CHM format](./asm/fasm/tutorials/)).
    -   Created [Assembly section](./asm/index.html) for [fasm resources](./asm/fasm/index.html).
    -   Created [`/shared/`](./shared/) section for gathering shared resources (CSS, JavaScript, etc.).
    -   Created pandoc [“Tutorial” html5 template](./shared/pandoc/) for building html tutorials from multiple markdown source files.
    -   Added [Sass/Compass project](./shared/sass/) to build CSS stylesheets of [`/shared/`](./shared/) section.
-   `2017/01/17` — Updated pre-built [**Highlight.js**](./syntax-highlighting/highlight.js/) to **HJLS-PB v9.9.0b** (FASM syntax added).
-   `2017/01/14` — Added [**Win Registry Module**](./libs/win-registry/) by Thomas Schulz, a module for handling Windows’ registry read/write and delete operations.
-   `2017/01/02` — Added [**GoScintilla**](./pb-development/purelibs/scintilla/GoScintilla/) by Stephen Rodriguez — updated to work with PB 5.x.
-   `2016/12/20` — Added [**pandoc2bbcode**](./tools/pandoc2bbcode/), a script for converting documents to PureBASIC Forums BBCode from a variety of input formats.
-   `2016/12/18` — Updated pre-built [**Highlight.js**](./syntax-highlighting/highlight.js/) to v9.9.0.
-   `2016/12/06` — Republished Dräc’s French tutorial [*PureBasic et la POO*](./tutorials/oop/drac/fr/POO-Demystifiee.asciidoc)
-   `2016/11/30` — Now GFM (GitHub Flavored Markdown) is the default standard for markdown documents and cleanup operations performed via the repo-maintaiance tools.
-   `2016/11/26`
    -   Added [**PBHGEN v5.42**](./pb-development/pb-ide/tools/pbhgen/) by Henry de Jongh: PB-IDE Tool for auto-generating header files (`*.pbi`).
    -   Started creating the [Wiki](https://github.com/tajmone/purebasic-archives/wiki).
-   `2016/11/24` — [**Highlight.js**](./syntax-highlighting/highlight.js/): pre-built HLJS packages («PureBASIC enhanced/modded releases») are now available in this repo, along with themes, instructions, and examples.
-   `2016/11/18` — Republished Dräc’s tutorial [*PureBasic and OOP*](./tutorials/oop/drac/en/OOP-Demystified.asciidoc) (English version).
-   `2016/10/31` — Added [*Programming 2D Scrolling Games*](./books/2d-games/) PDF book and code examples.
-   `2016/10/27` — **Highlight**: this repo becomes the home of the PureBASIC language definition and color theme files for [**Highlight** syntax highlighter](./syntax-highlighting/highlight/).
-   `2016/10/26` — repository creation date.

