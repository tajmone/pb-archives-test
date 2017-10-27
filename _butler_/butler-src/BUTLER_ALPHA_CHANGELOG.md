Butler Alpha Changelog
======================

Temporary changelog file to track Alpha stage developement of Butler app.

-   `v0.1.3` (2017/10/27)
    -   DRY Clean-Up `butler-mod_ini.pbi` module — No longer sets `operativeStatus` to `#False` every time a StatusErr is found  — now `ini::Init()` checks if `StatusErr` is >0 before returning, and returns False/True accordingly.
-   `v0.1.2` (2017/10/27)
    -   ADDED Win OS Shell checks — Under Windows, Butler will check if env var `SHELL` is present (not empty) to make sure that it's being invoked from Git Bash; if not, it will fail `operativeStatus` and refuse to carry out tasks.
-   `v0.1.1` (2017/10/22)
    -   ADDED “`butler-mod_build.pbi`” — All code relating to Build operations has been moved into the `build::` module.
    -   CHANGED `Abort(errMsg.s)` »»  `msg::Abort(errMsg.s)` -- `Abort()` procedure moved from main code into the `msg::` module, so it can be accessed from anywhere.

