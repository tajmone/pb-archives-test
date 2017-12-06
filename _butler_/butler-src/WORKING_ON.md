# Butler: Currently Working On

Notes about the current TODOs.

1.  Fix Messages System
2.  Check occurences of `#Null$` and see if should be changed to `#Empty$`\!

## Satus Errors

Implement new Status Errors to handle:

  - **Malformed Constraint/Version Strings** — these should occur only with version strings from settings files. App version queries are already filtered by a good RegEx, and unsupported version schemes should result in empty strings. But if I were to decide to implement differentiation bewtween them:
    
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

### Verbosity

- [x] __FIX STDERR DEBUGGING__ — Debug messages were always printed to `STDER`; now I've implemented printing them to `STDOUT` only if `--verbose` opt is true.

### Errors

- [ ] __ABORT__ — Some errors cause Butler to abort (eg: bad CLI args, file operation failures, etc.). I need to implement a good `msg::Abort()` procedure and make sure it's used instead of local STDERR messages and `End`.
- [ ] __INTERNAL ERRORS__ — Butler internal errors (eg: fail to create RegEx, etc) must be handled by a specific `msg::InternalError()` procedure.