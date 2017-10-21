Butler CMS
==========

Butler is flat file content management system that builds HTML documentation from markdown source files via PP, Pandoc and Highlight.

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Requirements](#requirements)
    -   [Windows Bash](#windows-bash)
    -   [Pandoc](#pandoc)
-   [PP](#pp)
    -   [Highlight](#highlight)
-   [Usage](#usage)
    -   [Initializing Butler](#initializing-butler)

<!-- /toc -->

------------------------------------------------------------------------

Requirements
============

In order to compile Butler, you’ll need PureBASIC 5.61 — for more info, see:

-   [`/butler-src/README.md`](./butler-src/README.md)

In order to use Butler, you’ll need a \*nix shell and the following applications:

-   [Pandoc](#pandoc)
-   [PP](#pp)
-   [Highlight](#highlight)

You can install pandoc and Highlight system wide, or you can place their standalone binaries either in some folder on the system path, or directly in this folder. PP is a single binary application, and you’re strongly adviced to place the binary release matching the project’s requirements directly in this folder.

The PureBASIC Archives project enforces some constraints on the version requirements for these apps through the [`butler.ini`](./butler.ini) settings file. The version constraints for PP and pandoc are strict (exact version matching), while for Highlight the constraints are for a minimum version requirement.

The reason why I impose strict version constraints on PP and pandoc is because we must ensure identical output from all users. PP is a fast growing application, and future releases might introduce unexpected changes macros behaviors. Pandoc is about to undergo a major update with the upcoming v2.0, so I’d rather play on the safe line for now.

After new releases of these apps are thoroughly tested, their versions settings in the `butler.ini` file will be updated accordingly (and Butler will refuse to build until you update these apps to the new required version). Embracing the latest version of each of those apps is not strictly needed for the PureBASIC Archives project, unless they introduce new features useful to the project.

Windows Bash
------------

On Windows you’ll need to invoke Butler from within Git Bash — since Butler is an app targetting mainly Git repositories (particularly, GitHub repos, and the GitHub Pages service), and since it’s currently being developed as part of a GitHub project (The PureBASIC Archives), Windows users are expected to have already installed on their system Git for Windows, which also installs Git Bash ([mintty](http://mintty.github.io/)):

-   [git-for-windows.github.io](https://git-for-windows.github.io/)

The reason why Butler is currently restricted to work in Shell/Bash is beacuse of the PP macros it uses: for cross-platfrom compatibility, as well as easier maintainance, many macros rely on sh/bash scripts and commands execution.

> **NOTE**: Technically speaking, Butler could work also inside Windows CMD — and indeed, in its early stages I was developing it that way; but I soon realized that PP macros work better in a shell environment than in MS CMD, so I started to focus only on Bash usage.
>
> I haven’t yet made up my mind as to whether the final version of Butler will also support CMD or not. If focusing on Bash usage will turn out to allow easier maintainance and developement, I’ll drop the whole idead of supporting CMD usage; if not, I might allow it via some optional `butler.ini` file (disabled by default). But I’d like to ear users voice on this — some people might use Butler outside of Git projects, in a Windows only environment.

Pandoc
------

-   [pandoc.org](https://pandoc.org/) — pandoc website.
-   [github.com/jgm/pandoc](https://github.com/jgm/pandoc) — pandoc source code.
-   [pandoc binaries download page](https://github.com/jgm/pandoc/releases/latest).

Pandoc for Windows is available as an installer. The project’s version constraints for pandoc are strict (exact version match); so if you have installed system wide a pandoc version different from the one required by the PureBASIC Archives settings, you’ll need to extract from the installer of the required version the following binary executables:

-   `pandoc.exe`
-   `pandoc-citeproc.exe`

… and place them in this folder. To extract these files, just open the pandoc installer with [7-Zip](http://www.7-zip.org/) (or some other archiver).

PP
==

-   [cdsoft.fr/pp](http://cdsoft.fr/pp/) — PP homepage.
-   [github.com/CDSoft/pp](https://github.com/CDSoft/pp) — PP source code.
-   [PP binaries download page](http://cdsoft.fr/pp/download.html) (x64 builds only).

Highlight
---------

-   [andre-simon.de](http://www.andre-simon.de/doku/highlight/en/highlight.php) — Highlight homepage.
-   [github.com/andre-simon/highligh](https://github.com/andre-simon/highlight) — Highlight source code.
-   [Highlight binaries download page](http://www.andre-simon.de/zip/download.php).
-   [Highlight documentation Wiki](http://www.andre-simon.de/dokuwiki/doku.php).

The adviced way to integrate Highlight in this project is to install the latest version system wide, and ensure that the command line binaries (not Highlight GUI) are on the system path. Since the project’s version constraints are for a minimal version, keeping Highlight always up to date shouldn’t break any backward compatibility.

Usage
=====

From with your shell/Bash, type `butler -h` to get help information.

Initializing Butler
-------------------

Before using Butler you need to execute the `init-butler.sh` shell script found in this folder via:

``` bash
source init-butler.sh
```

.. or via the briefer dot synonim (“`.`”), if your shell supports it:

``` bash
. init-butler.sh
```

This script will add this folder’s path at the beginning of the `PATH` env var for the current terminal session (thus making Butler and all other binary dependencies of this folder available from anywhere). It also sets to the same path the `BUTLER_PATH` env var, which is required for other reasons.
