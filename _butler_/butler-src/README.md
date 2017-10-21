Butler Source Code
==================

Butler is a PureBASIC cross-platform console application (currently only tested on Windows) intended for use within a shell like Bash.

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [Compiling Butler](#compiling-butler)

<!-- /toc -->

------------------------------------------------------------------------

Compiling Butler
================

You’ll find in this folder my Windows PB project file ([`butler.pbp`](./butler.pbp)), but you should not use it directly because it’s version controlled (tracked by Git) and would cause spurious/conflicting changes each time you save it. Just copy it and rename it and then have Git ignore it.

I’m not sure how this project files would work on Linux or Mac.

Anyhow, you just need to compile `butler.pb` as a console application, and tell PureBASIC to build the binary file one level up — in Compiler options set:

-   Output executable: `../butler.exe`

… or the equivalent in Linux and Mac. The idea is to build the binary file outside the source directory, because once Butler becomes a general application (ie: not tied to the PureBASIC Archives project only) ready for release, it will be moved in another repository, and this folder will become a Git submodule.
