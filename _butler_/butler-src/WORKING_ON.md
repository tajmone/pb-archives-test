# Butler: Currently Working On

Notes about the current TODOs.

1.  Fix Messages System
2.  Check occurences of `#Null$` and see if should be changed to `#Empty$`\!

## Satus Errors

Implement new Status Errors to handle:

  - **Malformed Constraint/Version Strings** — these should occur only with version strings from settings files. App version queries are already filtered by a good RegEx, and unsupported version schemes should result in empty strings. But I decide to implement differentiation bewtween them:
    
    Currently, `deps::SatisfyVersion()` reports a `-1` if either ConstraintVer or Version strings are malformed/unsupported. I could have the former return `-1`, and the latter subtract `-2` to returned value. This would allow to catch which one of the two (or both) are malformed. The checks woul then have to be:
    
    ``` 
    Case -1
      Malformed Constraint
    Case -2
      Malformed Version
    Case -3
      Both Malformed
    ```

## Messages System

Redesign Butler’s messages system:

  - **VERBOSITY** — Currently, debug messages are always printed to `STDER`; implement printing them to `STDOUT` only if `--verbose` opt is true.
