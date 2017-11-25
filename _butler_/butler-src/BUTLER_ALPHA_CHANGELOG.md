# Butler Alpha Changelog

Temporary changelog file to track Alpha stage developement of Butler app.

  - `v0.1.18` (2017/11/25)
    
      - `msg::` Reimplement back here `ButlerVersion()` and `PrintButlerVersionFramed()` procedure now that modules interpdendency conflicts are solved.

  - `v0.1.17` (2017/11/25)
    
      - **DATA STORAGE MODULE** (`DS::`)
          - Created new `DS::` module to hold all project and environment data (previously held by `ini::`):
            
              - `DS::Proj\`
              - `DS::Butler\`
              - `DS::Env\`
              - User Options constants (“`#opt_`…”)
              - Status Error constants (“`#SERR_`…”)
            
            This will allow `ini::` and `msg::` to cross-reference each other and solve the interdependency issue (since `msg::` can now access data from `DS::` instead of `ini::`, the `msg::` module can be included before `ini::` module).

  - `v0.1.16` (2017/11/24)
    
      - **STATUS ERROR MESSAGE**
          - Better handling of status error message:
              - **DELETED** `msg::ListStatusErrors()`
              - **ADDED** `ini::EnlistStatusError()` and `ini::StatusErrorReport()` — these 2 procs now handle status errors in place by enlisting them in `ini::StatusErrorReport$` via `msg::ListStatusErrors(error_str$)`. The list of status errors is then displayed via `ini::StatusErrorReport()`

  - `v0.1.15` (2017/11/24)
    
      - **BUTLER’S INFO HEADER**
          - Now handling of printing Butler version and Info Header is handled inside `ini::` module:
              - New `ini::ButlerVerFull$` string to avoid resorting to `msg::` module (solves conflict of module loading order and interdependency).
            <!-- end list -->
              - Checks for `--version` option are now carried out immediately after parsing CLI args, and if this opt is present `ini::ButlerVerFull$` is printed and app quits, without any further useless checks.
              - Butler’s Info Header is printed immediately after parsing CLI args and checking for `--version` option: prints `ini::ButlerVerFull$` string via `txt::FrameText()`, direclty, without need of `msg::` module.
          - `msg::` module:
              - **DELETED** `msg::ButlerVersion()` and `msg::PrintButlerVersionFramed()` procedures.

  - `v0.1.14` (2017/11/24)
    
      - **BINARY-INCLUDE TEXT FILES AS UTF-8** (`msg::` module)
          - Now the `msg::` module embeds text files as UTF-8 (no BOM) instead of UCS2. Bomless UTF-8 txt files are a better choice (more standard); also, the previous UCS2 `*.txt` files got corrupted somewhere along the line, maybe it was due to Git checkout operations and EOL normalization? Not sure, but UTF-8 will make most users happier, and it only required changing a `PeekS` command to `PeekS( ?HelpText, -1, #PB_UTF8 )`.

  - `v0.1.13` (2017/11/24)
    
      - **IGNORE “`.git`” FOLDER** (`build::` module)
          - Now `build::FolderIsBuildEligible()` will ignore “`.git`” folders.

  - `v0.1.12` (2017/11/09)
    
      - **CODE REORGANIZATION** (`ini::` module)
          - New `ini::ValidateDependenciesVersion()` procedure: all dependencies version checks where moved from `ini::ReadSettingsFile()` to here.

  - `v0.1.11` (2017/11/08)
    
      - **CODE OPTIMIZATIONS** (`ini::` module)
          - now uses a single DataStructure to map CLI options (long and short) directly to `ini::UserOpts` flags.
          - Parameters iteration no longer creates a list for deferred options evaluation, but sets the appropriate flags in place.
          - The `EVALUATE USER OPTIONS` part is dropped (it used `Select`/`Case` on a per-option basis). Options evaluation is now done during params iteration.

  - `v0.1.10` (2017/11/08)
    
      - **CODE OPTIMIZATION** (`ini::` module)
          - `ini::` module now uses a single loop to create both options maps (long and short opts) using a common DataSection.

  - `v0.1.9` (2017/11/07)
    
      - PP is invoked with the `-D ROOT=<path to root>` option, which assignes to the `ROOT` symbol the relative path back to the project’s root — just like the `ROOT` variable is already passed to pandoc in order for the template to locate assets files.
        
        > **NOTE**: `!ROOT` is used by “`macros.pp`” to create a markdown list of all imported modules with links to the module files (`!ListMacrosFilesLinks` macro). The `!ROOT` macro will also be useful to project documentation maintainers.

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
