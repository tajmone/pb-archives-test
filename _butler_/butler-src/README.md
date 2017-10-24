Butler Source Code
==================

Butler is a PureBASIC cross-platform console application (currently only tested on Windows) intended for use within a shell like Bash.

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Compiling Butler](#compiling-butler)
    -   [PB Project Templates](#pb-project-templates)
    -   [Compiling Notes](#compiling-notes)

<!-- /toc -->

------------------------------------------------------------------------

Compiling Butler
================

-   Either copy of one of the provided [project templates](#pb-project-templates), or create your own.
-   Remember that the binary file must compile to the parent folder! (see: [Compiling Notes](#compiling-notes))

PB Project Templates
--------------------

Because PureBASIC changes the project files at each end-of-session, version controlling project files is a nightmare. So I’ve adopted the following solution:

-   `*.pbp` files are gitignored by default (in [`.gitignore`](./.gitignore)).
-   I’ve added some project templates (OS specific) which are excluded from being ignored:
    -   `_proj-template_Butler-Windows.pbp` — Butler’s Windows project template.

Copy and rename the required project template and use it as your project file. Example: copy `_proj-template_Butler-Windows.pbp` to `Butler-Windows.pbp`. Whatever name you choose, it will be gitignored and won’t affect the repository, so can tweak it to your liking.

> **NOTE**: Since PureBASIC also adds some user-specific data in project files, project template files have been stripped of all unnecessary data. All the stripped data will be recreated by PureBASIC when you open your copied project file locally.

Compiling Notes
---------------

If you’re going to create your own project file (or script), these are the required settings:

-   compile `butler.pb` as a console application,
-   tell PureBASIC to build the binary file one level up — in Compiler options set: " Output executable: `../butler.exe`" … or its equivalent in Linux and Mac.

The idea is to build the binary file outside the source directory, because once Butler becomes a general application ready for release (ie: not tied to the PureBASIC Archives project only), it will be moved in another repository, and this folder will become a Git submodule.
