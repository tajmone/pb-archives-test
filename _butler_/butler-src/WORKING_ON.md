# Butler: Currently Working On

Notes about the current TODOs.

# Butler INI Module

  - `ini::ReadSettingsFile()`:
      - Remove all the dependencies version checks, and move them into`ini::CheckDependenciesVersion()` procedure (to be created).
      - Cleanup code and make it into a loop using DataSection.
  - `ini::CheckDependenciesVersion()`:
      - Create this new Procedure to handle checking all dependencies versions.
    
      - Implement Version Constraints:
        
          - `^` (Caret Version Range) same MAJOR version
          - `~` (Tilde Version Range) same MINOR version
        
        Independently of the adopted versioning scheme (eg: `v2.50`, or `v2.10.2.35`), all found digit-Identifiers will be used as min-ver baseline for comparison. A `0` value will be asigned to unspecified IDs which are found on actual version returned; ie, if the `.ini` files specifies “`2.3`” for an app, and the installed app return version `2.3.5`, in the constraints check the “`2.3`” will become `2.3.0` — this will allow to work with different schemes; eg: pandoc uses four digit identifiers, Highlight two.
        
        The exception is SemVer (used by PP only), which uses alphanumerical identifiers beyond PATCH — I’d need to implement a specific comparison code for that, or either ignore differences beyond PATCH. But since for PP I'm using only strict version restraints, this should not be a problem right now.
        
        examples:
        
        ``` 
           ^1.2.10   ==   >=   1.2.10  &  < 2.0.0
           ~1.2.10   ==   >=   1.2.10  &  < 1.3.0
             ^3.22   ==   >=     3.22  &  < 4.0.0
             ~3.22   ==   >=     3.22  &  < 3.23
         ^2.8.10.6   ==   >= 2.8.10.6  &  < 3.0.0.0
         ~2.8.10.6   ==   >= 2.8.10.6  &  < 2.9.0.0
        ```
