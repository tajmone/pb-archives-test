# Butler Alpha Changelog

Temporary changelog file to track Alpha stage developement of Butler app.

  - `v0.1.8` (2017/11/03)
    
      - Default pandoc template is now “`pandoc.html5`” (before was “`custom.html5`”)

  - `v0.1.7` (2017/11/03)
    
      - Use Pandoc v2.0.1 — Updated Butler to work with new Pandoc v2.0.1:
          - Change pandoc invocation options: `-f markdown+smart` (drop `--normalize --smart`)

  - `v0.1.6` (2017/11/03)
    
      - Now Butler looks for a “`_butler.pp`” file in each folder: if present, it is added to PP invocation (as `-import`) *before* the markdown source document (unlike “`_butler.yaml`”, which is added *after* the MD source file).
        
        This allows to define folder-wide PP macros, available to all docs.
        
        The reason this feature was added was because even though macros could be defined inside “`_butler.yaml`”, in order to allow vars defined in YAML of source docs to override those in “`_butler.yaml`”, the latter had to be loaded *after* the source doc — because pandoc will ignore variables defined more than once (only 1st def is retained). Since folder-wide macros need to be defined *before* their actual occurence in a doc (PP is a single-pass parser), I needed a folder-wide common file that could be loaded before the MD source file.

  - `v0.1.5` (2017/10/28)
    
      - Now Highlight.pp uses the `--data-dir=$HIGHLIGHT_DATADIR` option to find custom langdefs overrides folder-wide. No longer uses the `--config-file` opt to override each langdef individually.
      - Langdefs moved to `/_butler_/highlight-data/langDefs/` folder.
      - Highlight.pp v0.2
      - Requires Highlight \>= 3.40.

  - `v0.1.4` (2017/10/28)
    
      - Add Highlight Version checks (minimum version, but same MAJOR range).

  - `v0.1.3` (2017/10/27)
    
      - DRY Clean-Up `butler-mod_ini.pbi` module — No longer sets `operativeStatus` to `#False` every time a StatusErr is found — now `ini::Init()` checks if `StatusErr` is \>0 before returning, and returns False/True accordingly.

  - `v0.1.2` (2017/10/27)
    
      - ADDED Win OS Shell checks — Under Windows, Butler will check if env var `SHELL` is present (not empty) to make sure that it’s being invoked from Git Bash; if not, it will fail `operativeStatus` and refuse to carry out tasks.

  - `v0.1.1` (2017/10/22)
    
      - ADDED “`butler-mod_build.pbi`” — All code relating to Build operations has been moved into the `build::` module.
      - CHANGED `Abort(errMsg.s)` »» `msg::Abort(errMsg.s)` – `Abort()` procedure moved from main code into the `msg::` module, so it can be accessed from anywhere.
