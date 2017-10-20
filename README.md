“The PureBASIC Archives” Revamped (Alpha Testing)
=================================================

This is a temporary repository for Alpha-stage testing of the upcoming new version of The PureBASIC Archives project. When the new version will be ready for publishing, it will overwrite the original project and this testing repo will be deleted:

-   <https://github.com/tajmone/purebasic-archives>

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [About The Upcoming Changes](#about-the-upcoming-changes)
-   [A Glimpse of Things to Come](#a-glimpse-of-things-to-come)
-   [Cloning Guidelines](#cloning-guidelines)

<!-- /toc -->

------------------------------------------------------------------------

About The Upcoming Changes
==========================

Up to now, the PureBASIC Archives has been a Git repository with all its documentation in markdown format, intended for either viewing in GitHub website or locally in an editor supporting markdown preview.

The new version of the PureBASIC Archives includes a custom CMS (Butler, written in PureBASIC) that will build the new markdown sources into a fully browsable HTML5 documentation. The HTML documentation will also be viewable online as a website via [GitHub Pages](https://pages.github.com/), as well as offline in your local copy of the project.

To achieve this, the new project will be split in two separate main branches:

1.  The “**source branch**” (`source`, and all its branches), where the CMS app resides, with all the markdown source files. The CMS app will build here the HTML pages from the markdown sources.
2.  The “**deploy branch**” (`master`), where the relevant files are deployed for the end users — ie: only the HTML pages, without their markdown sources, the CMS app, or other developers files not intended for the end users.

The repository will be set to [serve GitHub Pages directly from the `master` branch](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/#enabling-github-pages-to-publish-your-site-from-master-or-gh-pages) (instead of `gh-pages`). This will allow the world to see and browse the PureBASIC Archives on the World Wide Web, without having to clone the project locally.

A Glimpse of Things to Come
===========================

Currently, the project hasn’t reached the catual website deployment stage. But you can preview a few WIP pages (almost ready) directly from the `source` via [**GitHub & BitBucket HTML Preview**](http://htmlpreview.github.io/) web-service:

-   [TAJGA FASM Tutorial](http://htmlpreview.github.io/?https://github.com/tajmone/pb-archives-test/blob/source/asm/fasm/tutorials/tajga-fasm-tutorial.html)
-   [RegularExpression PureLibrary (PCRE)](http://htmlpreview.github.io/?https://github.com/tajmone/pb-archives-test/blob/source/pb-development/purelibs/regex/index.html)

Cloning Guidelines
==================

If you’re curious about the project, why not clone it locally and play around with it?

This repo has two separate branches (ie: orphan branches):

-   [`source`](https://github.com/tajmone/pb-archives-test/tree/source) — where the development takes place.
-   [`master`](https://github.com/tajmone/pb-archives-test) — where the build project is deployed.

Since the contents of the two branches differ slightly, you should clone these branches in different folders to avoid pollution of `master` branch by ignored files from the `source` branch (ie: files created by compilation of source code, or other type of files generated during the development process).

Assuming the common parent folder is named “`PB-Archives-Alpha`”:

-   “`PB-Archives-Alpha/master/`”: the root contents of `master` branch
-   “`PB-Archives-Alpha/source/`”: the root contents of `source` branch

The names and relative positions of these two folders is crucial for the build and deploy process. **DON’T NAME YOUR LOCAL FOLDERS DIFFERENTLY!**

The `source` orphan branch will have other dev branches; the `master` branch will not.

> **NOTE**: If you’re just curious to try it out, you can simply clone the whole project, checkout the `source` branch and play with it (the `master` branch is not currently being used for deployment).
