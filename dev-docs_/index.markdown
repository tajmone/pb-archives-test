
This folder (and all its subfolders) contain developers documentation for the PureBASIC Archives project --- only available in the source branch.

:::::: Warning :::::::::::::::::::::::::::::
__WIP WARNING__ --- This section is still work in progress, most pages are rough sketches, tests, and their contents might not reflect the current state of code/macros changes.
::::::::::::::::::::::::::::::::::::::::::::

# Editing The Documentation

To edit the navigation pages and project documents, you'll need to:

1. know [how to write in markdown][writing] (pandoc's flavour of markdown),
2. learn [how to use the custom PP macros][pp-macros] created for this project, and
3. gain a general understanding of how Butler operates to build the final HTML documentation.

All these topics are covered in this section (and its subsections).

# Documentation Subsections

Beside this page and some other introductory pages in this folder, the documentation is divided into subsections (subfolders) addressing specific topic:

- [`/writing/`][writing] --- Guide on how to write contents.
- [`/pp-macros/`][pp-macros] --- PP macros reference.
- [`/html-tests/`][html-tests] --- CSS-styling test pages.

# Introduction

The PureBASIC Archives is an aggregator of various third party resources: source code, binary libraries, scripts, documentation, tutorials, images, and other types of assets. Resources are organized into a meaningful hierarchical folders structure; furthermore, to provide a user friendly navigation experience through the resources, the project is designed like a website.

Every folder (section) has an `index.html` file describing the nature and contents of the section (and its subsections, if any). Some sections might contain further HTML pages (eg: resources documentation, tutorials, etc.) that are part of the project's website (they might also contain some detached HTML documents, which are part of the hosted resources but not of the project's navigation tree and documentation).

HTML index pages and project documents are for end users' benefit; they are created and maintained in the `source` branch by developers and contributors, using markdown formatting which is then converted to HTML by Butler (the flat-file CMS engine/app that powers the PureBASIC Archives behind the scenes).


## PP Macros

:::::: Warning :::::::::::::::::::::::::::::
_UNDER CONSTRUCTION_!
::::::::::::::::::::::::::::::::::::::::::::

See:

- [`/pp-macros/`](./pp-macros/index.html) --- PP macros reference.


## Butler CMS

:::::: Warning :::::::::::::::::::::::::::::
_UNDER CONSTRUCTION_!
::::::::::::::::::::::::::::::::::::::::::::






!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

