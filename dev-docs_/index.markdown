
This folder (and all its subfolders) contain developers documentation for the PureBASIC Archives project --- only available in the source branch.

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__WIP WARNING__ --- This section is still work in progress, most pages are rough sketches, tests, and their contents might not reflect the current state of code/macros changes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Documentation Subsections

Beside this page and some other introductory pages in this folder, the documentation is divided into subsections (subfolders) addressing specific topic:

- [`/html-tests/`](./html-tests/index.html) --- CSS-styling test pages.
- [`/pp-macros/`](./pp-macros/index.html) --- PP macros reference.

# Introduction

The PureBASIC Archives is an aggreagator of various third party resources: source code, binary libraries, scripts, documentation, tutorials, images, and other types of assets. Resources are organized into a meaningful hierarchical folders structure; furthermore, to provide a user friendly navigation experience through the resources, the project is designed like a website.

Every folder (section) has an `index.html` file describing the nature and contents of the section (and its subsections, if any). Some sections might contain further HTML pages (eg: resources documentation, tutorials, etc.) that are part of the project's website (they might also contain some detached HTML documents, which are part of the hosted resources but not of the project's navigation tree and documentation).

HTML index pages and project documents are for end users' benefit; they are created and maintained in the `source` branch by developers and contributors, using markdown formatting which is then converted to HTML by Butler (the flat-file CMS engine/app that powers the PureBASIC Archives behind the scenes).

# Editing The Documentation

To edit the navigation pages and project documents, you'll need to:

1. know how to write in markdown (pandoc's flavour of markdown),
2. learn how to use the custom PP macros created for this project, and
3. gain a general understanding of how Butler operates to build the final HTML documentation.

All these topics are covered in this section (and its subsections).

## Pandoc's Markdown

If you are new to markdown, you should read some introductiory tutorials on basic markdown:

- [www.markdowntutorial.com](https://www.markdowntutorial.com/) (live exercises)
- [www.markdownguide.org](https://www.markdownguide.org/)

Here are some useful cheatsheets links:

- [Jon Schlinkert's Markdown Cheatsheet](https://gist.github.com/jonschlinkert/5854601)
- [Adam Pritchard's Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet)

Pandoc markdown is an extension of markdown, so you can use almost everything you learned from the basic markdown syntax when editing the project's source files.

After you get a good grip with basic markdown, you can start looking at pandoc flavoured markdown, and all the useful syntax extensions that come with it:

- [Pandoc’s markdown guide][pandoc md]

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__NOTE__: I'm planning to add a pandoc markdown writing guide to this section. In the meanwhile, the above links will fill the void and supply the needed references.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## PP Macros

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_UNDER CONSTRUCTION_!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See:

- [`/pp-macros/`](./pp-macros/index.html) --- PP macros reference.


## Butler CMS

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_UNDER CONSTRUCTION_!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[pandoc md]: http://pandoc.org/MANUAL.html#pandocs-markdown "Pandoc’s markdown guide"
