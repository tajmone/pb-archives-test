# Butler: Currently Working On

Notes about the current TODOs.

- Check occurences of `#Null$` and see if should be changed to `#Empty$`!

1. Fix Messages System
2. Implement new Dependencies Module (with constraints)

## Messages System

Redesign Butler's messages system:

- [ ] __VERBOSITY__ --- Currently, debug messages are always printed to `STDER`; implement printing them to `STDOUT` only if `--verbose` opt is true.
- [x] __STATUS ERROR__ -- Drop the current `msg::ListStatusErrors()` procedure and subsitute it with `msg::EnlistStatusError(error$)` that will create a numbered list of status errors, to be printed via  `msg::StatusErrorReport()` after `ini::init()` has finished its job (only if `opStatuRequired` or if `--status` opt was passed).

## Dependencies Version Satisfaction

  - `ini::ReadSettingsFile()`:
    
      - \[**\*\*\**DONE\!*\*\*\***\] `ini::ValidateDependenciesVersion()` — Create procedure and move here all the dependencies version checks from `ini::ReadSettingsFile()`.
      - Cleanup code and make it into a loop using DataSection.

  - `ini::ValidateDependenciesVersion()`:
    
      - Create this new Procedure to handle checking all dependencies versions.

  - `deps::` — Add new “dependencies” module to deal with all version-related tasks:
    
      - Move all query-app-version procedures from `PPP::` and `ini::` modules into this new module.
    
      - Implement Version Constraints:
        
          - `^` (Caret Version Range) same MAJOR version
          - `~` (Tilde Version Range) same MAJOR & MINOR version
        
        Independently of the adopted versioning scheme (eg: `v2.50`, or `v2.10.2.35`), all found digit-Identifiers will be used as min-ver baseline for comparison. A `0` value will be asigned to unspecified IDs which are found on actual version returned; ie, if the `.ini` files specifies “`2.3`” for an app, and the installed app return version `2.3.5`, in the constraints check the “`2.3`” will become `2.3.0` — this will allow to work with different schemes; eg: pandoc uses four digit identifiers, Highlight two.
        
        The exception is SemVer (used by PP only), which uses alphanumerical identifiers beyond PATCH — I’d need to implement a specific comparison code for that, or either ignore differences beyond PATCH. But since for PP I’m using only strict version restraints, this should not be a problem right now.
        
        examples:
        
        ``` 
           ^1.2.10   ==   >=   1.2.10  &  < 2.0.0
           ~1.2.10   ==   >=   1.2.10  &  < 1.3.0
             ^3.22   ==   >=     3.22  &  < 4.0.0
             ~3.22   ==   >=     3.22  &  < 3.23
         ^2.8.10.6   ==   >= 2.8.10.6  &  < 3.0.0.0
         ~2.8.10.6   ==   >= 2.8.10.6  &  < 2.9.0.0
        ```

# Notes

## Version Constraints

### Considerations on Tilde Constraining MAJ+MIN

Usually the tilde constraint works as follows (Node.js, Composer; and Ruby’s `~>`):

> `~` allows the right most version segment to increment above the given value.

For example:

    ~1.2     ==   >=1.2    &   <2.0.0
    ~1.2.3   ==   >=1.2.3  &   <1.3.0

I could either implement it this way, or use it to constraint MAJOR & MINOR version, regardless of how many Ids are provided in the constraint string.

### Butler’s Dependencies Overview

The whole issue revolves around the fact that, currently, the different dependencies have different schemes:

    PP        D.D.D-A+A  ( SemVer )
    pandoc    D.D.D.D
    highlight D.D

  - With Highlight the `~` would either act the same as `^` (in Node.js way) or as a strict constraint (in my fixed MAJOR & MINOR way).

  - With pandoc, my way would not allow to cover the fourth Id.

  - PP uses Semantic Versioning, and the tilde constraint works with special rules:
    
    > `~1.2.3-beta.2 := >=1.2.3-beta.2 <1.3.0`
    > 
    > Note that prereleases in the `1.2.3` version will be allowed, if they are greater than or equal to `beta.2`. So, `1.2.3-beta.4` would be allowed, but `1.2.4-beta.2` would not, because it is a prerelease of a different \[major, minor, patch\] tuple.
    > 
    >   - [node-semver documentation](https://github.com/npm/node-semver#tilde-ranges-123-12-1)

### Twiddle-Wakka Solution

I could solve the problem by also implementing:

  - `~>` (Twiddle-Wakka Range, Ruby style pessimistic operator) allows the right most version segment to increment above the given value.

… this would allow to keep the `~` for MAJ+MIN (fixed), and also have an operator which covers pandoc’s four-identifier scheme.
