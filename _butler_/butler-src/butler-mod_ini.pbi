; ··············································································
; ··············································································
; ························ Butler Initialization Module ························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_ini.pbi" | PureBASIC 5.61

; modules dependencies:
; -- DS::
; -- FS::
; -- msg::
; -- PPP::

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================

; This module manages Butler's project settings from/to file and memory.

; TODO: Move Here checking if CurrFolder is within Butler Path!!

; TODO: IMPLEMENT Checking if "butler.ini" file exists (in Butler's Path):
;   -- If not, propose to create "butler.ini" from template? Maybe interactive,
;      asking users questions to fill it (proj name, use curr PP/Pandoc v, etc)
;   -- If I use an embedded template, beware of possible NewLine chars differences
;      amongst Win and Linux/Mac (CRLF vs LF). Must check how PB handles them.
; TODO: IMPLEMENT Parsing "butler.ini":
;   -- Compare PP/Pandoc .ini versions to actual apps ver:
;      -- If no .ini specs found, or versions differ, propose altering .ini vals
;         to those of the version of PP/Pandoc present on system.


; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule ini
  ; ==============================================================================
  ;                         PUBLIC PROCEDURES DECLARATION                         
  ; ==============================================================================
  Declare Init()
  
EndDeclareModule

Module ini
  IncludeFile "butler-mod_ini.pbhgen.pbi" ; <= PBHGEN-X
  
  ; ==============================================================================
  ;                           SHARED REGEX ENUMERATIONS                           
  ; ==============================================================================
  ; RegExs Ids Constants Enumerations must carry on from where previous modules
  ; have left, otherwise they will overwrite existing RegExs (object IDs are not
  ; isolated by modules, they are global!)
  ; ------------------------------------------------------------------------------
  Enumeration DS::RegExsIDs               ; <= Enum ID defined in DS:: module
    #RE_OptsShort
  EndEnumeration 
  ; ==============================================================================
  ;                                     MACROS                                    
  ; ==============================================================================
  ; cntStr(number) Macro => Used to format ordered list strings:
  ; "  1) "
  ; "  2) "
  Macro cntStr(num)
    "  " + Str(num) + ") "
  EndMacro
  ; ==============================================================================
  ;                         PRIVATE PROCEDURES DECLARATION                        
  ; ==============================================================================
  Declare   ParseCLIArgs(numParams)
  Declare   ReadSettingsFile()
  Declare   GetDependenciesVersion()
  ; ******************************************************************************
  ; *                                                                            *
  ; *                             PUBLIC PROCEDURES                              *
  ; *                                                                            *
  ; ******************************************************************************
  ; ******************************************************************************
  ; *                             Initialize Butler                              *
  ; ******************************************************************************
  ; Initialize Butler and return its operativeStatus (true/false).
  Procedure Init()
    ; ------------------------------------------------------------------------------
    ;-                           Windows: Is Bash/Shell?                            
    ; ------------------------------------------------------------------------------
    ; If OS is Win, make sure Butler is invoked from Bash (Git Bash).
    ; This is done by checking for the presence of the SHELL env var.     
    ; ------------------------------------------------------------------------------
    CompilerIf #PB_Compiler_OS = #PB_OS_Windows
      If GetEnvironmentVariable("SHELL") = #Null$
        DS::StatusErr | DS::#SERR_Win_NotShell
        msg::EnlistStatusError("Butler not invoked from Bash/Shell.")
      EndIf
    CompilerEndIf
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;                          PARSE COMMAND LINE ARGUMENTS?                         
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    numParams = CountProgramParameters()
    If numParams
      ParseCLIArgs(numParams)
      ; ------------------------------------------------------------------------------
      ;                      "--version"? Print Version and Quit                      
      ; ------------------------------------------------------------------------------
      ; The "--version" option has precedence over all other opts: just print Butler's
      ; version number (unframed) and quit (no other checks need to be done).
      ; ------------------------------------------------------------------------------
      If ( DS::UserOpts & DS::#opt_Version )
        ; FIXME: Procedure should prematurely return to Main code, and let it handle
        ;        the "--version" opt check and print version. The current solution is
        ;        more code-efficient, but having Main control all user opts is better
        ;        in terms of code maintainance (same operations centralized in same place)
        Print( msg::ButlerVersion() )
        End 0 ; <= Exit Code -> Success (even if invoked from CMD)
      EndIf
    Else
      ; Butler invoked without any arguments...
      DS::UserOpts | DS::#opt_NoOpts
    EndIf
    ; ------------------------------------------------------------------------------
    ;                             Set Verbosity Shortcut                            
    ; ------------------------------------------------------------------------------
    ; To avoid writing "If ( DS::userOpts & DS::#opt_Verbose )" => "If DS::Verbose"
    DS::Verbose = Bool( DS::UserOpts & DS::#opt_Verbose )
    ; ------------------------------------------------------------------------------
    ;                            Print Butler Info Header                           
    ; ------------------------------------------------------------------------------
    ; Since the "--version" option has already been dealt with, we're now sure that
    ; the Info Header should be printed to the console...
    msg::PrintButlerVersionFramed()
    
    ; ------------------------------------------------------------------------------
    ;                   Get Butler's Path from BUTLER_PATH Env Var                  
    ;{------------------------------------------------------------------------------
    DS::Butler\Path$ = GetEnvironmentVariable("BUTLER_PATH")
    If DS::Butler\Path$ = #Null$
      ;       ConsoleError("BUTLER_PATH env var not found!!!")  ; DELME -- BUTLER_PATH env var not found
      DS::StatusErr | DS::#SERR_Missing_BUTLER_PATH
      msg::EnlistStatusError("Missing $BUTLER_PATH environment variable.")
    Else
      ; If BUTLER_PATH en var was found ...
      ; ------------------------------- Sanitize Path --------------------------------
      ; Fix path separators (slashes) according to OS and also ensures that path ends
      ; with path separator (if not present) ...
      ; TODO: Also check that path doesn't contain invalid chars (spaces, etc.)
      DS::Butler\Path$ = FS::SanitizeDirPath(DS::Butler\Path$)
      ; ------------------------------------------------------------------------------
      ;-                           Define HIGHLIGHT_DATADIR                           
      ; ------------------------------------------------------------------------------
      ; The env var HIGHLIGHT_DATADIR overrides Highlight's default path for "langDefs"
      ; and "themes" definitions folders.
      ; NOTE: With Highlight 3.40 still doesn't work, but now the `--data-dir` option 
      ;       works, which is much better then the `--config-file` option used before.
      ;       So I've now changed the macros to use --data-dir=$HIGHLIGHT_DATADIR
      ; NOTE: On Windows supported only with Highlight >= 3.40. See issue #24: 
      ;       -- https://github.com/andre-simon/highlight/issues/24
      HL_DATADIR$ = DS::Butler\Path$ + "highlight-data" + FS::#DIR_SEP$
      SetEnvironmentVariable("HIGHLIGHT_DATADIR", HL_DATADIR$)
      ; DEBUG IT:
      PrintN("~ HIGHLIGHT_DATADIR: " + GetEnvironmentVariable("HIGHLIGHT_DATADIR")) ; DBG
      
      ; TODO HIGHLIGHT_DATADIR:
      ; -- HIGHLIGHT_DATADIR should only be set If the folder is found!
      ; -- Because of differences in behaviour between Win and Mac/Linux, I should consider
      ;    using a different env-var name, and rely only on the `--data-dir` option!
      ;    Or maybe use a CLI defined PP symbol, instead of an env-var.
      ; ------------------------------------------------------------------------------
      ;-                 Check "butler.ini" (Proj. Preferences File)                  
      ; ------------------------------------------------------------------------------
      If FileSize(DS::Butler\Path$ + "butler.ini") > 0
        If ReadSettingsFile()
          ; If succesfully opened/read "butler.ini"...
          ; --------------------------------------------------------------------------
          ;-                      Dependencies: Check Versions                         
          ; --------------------------------------------------------------------------
          GetDependenciesVersion()
          ValidateDependenciesVersion()
        EndIf
      Else
        DS::StatusErr | DS::#SERR_Missing_Ini_File
        msg::EnlistStatusError(~"Missing \"butler.ini\" file.")
      EndIf 
    EndIf 
    
    
    
    ;}------------------------------------------------------------------------------
    ;                         Establish Project's Root Path                         
    ; ------------------------------------------------------------------------------
    ; The project root is one levl up from Butler's folder...
    ; ------------------------------------------------------------------------------
    tot = CountString(DS::Butler\Path$, FS::#DIR_SEP$)
    For i = 1 To tot - 1
      ; Build path string omitting last folder (ie: "/_butler_/")
      DS::Proj\Root$ + StringField(DS::Butler\Path$, i, FS::#DIR_SEP$) + FS::#DIR_SEP$
    Next
    ; ==============================================================================
    ;-                           Return Operative Status                            
    ; ==============================================================================
    If DS::StatusErr
      ProcedureReturn #False ; operativeStatus = False
    Else
      ProcedureReturn #True  ; operativeStatus = True
    EndIf
    
  EndProcedure
  ; ******************************************************************************
  ; *                                                                            *
  ; *                             PRIVATE PROCEDURES                             *
  ; *                                                                            *
  ; ******************************************************************************
  
  ; ******************************************************************************
  ; *                        Parse Command Line Arguments                        *
  ; ******************************************************************************
  Procedure ParseCLIArgs(numParams)
    
    ;- Create OptsShort RegEx
    ;  ======================
    ; NOTE: The OptsShort RegEx must capture all Ascii letters range [a-zA-Z] so
    ;       that the options parser can pinpoint the bad short opts (ie: if only
    ;       valid option letters where put in the RegEx, the presence of a single
    ;       invalid short opt would disqualify the entire "-" chars sequence!)
    If Not CreateRegularExpression(#RE_OptsShort, "-([a-zA-Z]+)$")
      ConsoleError("Couldn't create RegEx: #RE_OptsShort")         ; FIXME: Convert to Abort()!!!
      End 1                                                        ; FIXME: Implement some special Error Report Proc for Internal failures!
    EndIf
    
    ; ==============================================================================
    ;-                               CLI Options Maps                               
    ;{==============================================================================
    ; Map command line options (long and short versions) to UserOpts flags values.
    ; The Maps are used when iterating through params.
    
    ; NOTE: Flags are stored in Word type (".w", 2 bytes length on all architectures)
    
    DataSection      ; >>>>>>>>>>>>>>>>>> Options Maps Data >>>>>>>>>
      
      ; The Data of this Section has the following structure for each CLI option:
      ; [.s] Option:  Long version, Short version
      ; [.w] Flags:   UserOpts flags which are set by the option
      OptsData:             
      ; ======= Info Query Options: ==========================
      Data.s "--version",   "v" ; - Print Butler's version
      Data.w                        DS::#opt_Version
      Data.s "--help",      "h" ; - Print Help
      Data.w                        DS::#opt_Help
      ; === Proj Processing Options: =====================
      Data.s "--build",     "b" ; - Build current folder
      Data.w                        DS::#opt_BuildFolder | DS::#opt_opStatusReq
      Data.s "--build-all", "B" ; - Build whole project.
      Data.w                        DS::#opt_BuildAll | DS::#opt_Recursive | DS::#opt_opStatusReq
      Data.s "--recursive", "r" ; - Recurse into subfolders
      Data.w                        DS::#opt_Recursive
      Data.s "--verbose",   "V" ; - Verbosity ON
      Data.w                        DS::#opt_Verbose
      
      Data.s #Empty$ ; <= Signal End of Data!
      
    EndDataSection   ; <<<<<<<<<<<<<<<<<< Opts Strings <<<<<<<<<<<<<<<<<<
    
    ; ============================ Build CLI Opts Maps =============================
    ; Create the maps via a loop
    NewMap OptsLongM.a()  ; Map long  opts strs to UserOpts flags
    NewMap OptsShortM.a() ; Map short opts chrs to UserOpts flags
    Restore OptsData
    While #True
      Read.s OptsLongKey$
      If OptsLongKey$ = #Empty$ : Break : EndIf
      Read.s OptsShortKey$
      Read.w OptsFlags
      ; Long Options Map (every option has a long representation)
      OptsLongM(OptsLongKey$) = OptsFlags
      ; Short Options Map (some option don't have a short representation)
      If OptsShortKey$
        OptsShortM(OptsShortKey$) = OptsFlags
      EndIf
    Wend 
    
    ;}////// END :: Options Maps ///////////////////////////////////////////////////
    
    ; ==============================================================================
    ;                             ITERATE THROUGH PARAMS                            
    ;{==============================================================================
    ; Iterate through all params and build a list of the encountered options, and a
    ; a list of the encountered unknown params...
    ; ------------------------------------------------------------------------------
    NewList optsBadL.s(); <= Temp List to store all unknown opts and params found.
    For param = 1 To numParams
      currParam.s = ProgramParameter()
      If Left(currParam, 2) = "--"
        ; ------------------------------------------------------------------------------
        ;                              PARAM IS LONG OPTION                             
        ; ------------------------------------------------------------------------------       
        If FindMapElement(OptsLongM(), LCase(currParam)) ; <= Lower-Case comparison!
          DS::UserOpts | OptsLongM(currParam)
        Else
          AddElement(optsBadL())
          optsBadL() = currParam
        EndIf
        
      ElseIf MatchRegularExpression(#RE_OptsShort, currParam)
        ; ------------------------------------------------------------------------------
        ;                          PARAM IS A SHORTHAND OPTION                          
        ; ------------------------------------------------------------------------------
        If ExamineRegularExpression(#RE_OptsShort, currParam)
          ; TODO: Remove RegEx? I could just parse all chars without validating
          While NextRegularExpressionMatch(#RE_OptsShort)            
            ; Curr parameter contains shorthand option(s)...
            OptsShort$ = RegularExpressionGroup(#RE_OptsShort, 1)
            ; Explode opts strings and parse them....
            For i = 1 To Len(OptsShort$)
              
              currOpt$ = Mid(OptsShort$, i, 1)
              ; Check if char maps to a short opt
              If FindMapElement(OptsShortM(), currOpt$)
                DS::UserOpts | OptsShortM(currOpt$)
              Else
                AddElement(optsBadL())
                optsBadL() = "-" + currOpt$
              EndIf
              
            Next
          Wend
        EndIf
      Else
        ; ------------------------------------------------------------------------------
        ;                                 PARAM UNKNOWN                                 
        ; ------------------------------------------------------------------------------
        AddElement(optsBadL())
        optsBadL() = currParam
      EndIf
    Next    
    ;}==============================================================================
    ;                               PARAMS/OPTS ERRORS                              
    ; ==============================================================================
    ; If any malformed/invalid options were found, report and abort all operations..
    ; ------------------------------------------------------------------------------
    If ListSize(optsBadL())
      ConsoleError("!!! ERROR !!! The following command line options are invalid:") ; FIXME: Err Msg
      ForEach optsBadL()
        ConsoleError("  " + optsBadL() )
      Next
      ; TODO: Abort() ???
      End 1
    EndIf
    
  EndProcedure
  ; ******************************************************************************
  ; *                             Read Settings File                             *
  ; ******************************************************************************
  ; Returns #False if failed reading settings file
  Procedure ReadSettingsFile()
    
    If Not OpenPreferences(DS::Butler\Path$ + "butler.ini")

      ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ;                !!!   FAILED TO OPEN "butler.ini" FILE   !!!
      ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      If DS::Verbose
        PrintN(~"- Unable to open settings file \"butler.ini\"!")
      EndIf
      DS::StatusErr | DS::#SERR_CantOpen_Ini_File
      msg::EnlistStatusError(~"Unable to open \"butler.ini\" file.")
      ; ====> Set all dependencies status to #False:
      DS::ButlerStatus = #False
      DS::PPStatus = #False
      DS::PandocStatus = #False
      DS::HighlightStatus = #False
      ProcedureReturn #False ; <= Failed opening "butler.ini"
      
    ElseIf DS::Verbose ; ================================================> Verbosity
      PrintN(~"- Parsing settings file \"butler.ini\":")
    EndIf
    
    ; TODO: Macro for ReadSettingsFile()
    ;       All these checks could use a Macro to slim down code maintainence
    
    #unspecified_msg$ = "unspecified"
    ; ------------------------------------------------------------------------------
    ; Required Butler Version                            
    ; ------------------------------------------------------------------------------
    DS::Proj\ButlerVersion$ = ReadPreferenceString("ButlerVersion", #Empty$)
    
    If DS::Proj\ButlerVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      DS::StatusErr | DS::#SERR_Unspecified_Butler_Version
      msg::EnlistStatusError(~"\"butler.ini\" file: missing \"ButlerVersion\".")
      DS::ButlerStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN("  - ButlerVersion: " + #unspecified_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN(~"  - ButlerVersion: \"" + DS::Proj\ButlerVersion$ + ~"\"")
    EndIf
    ; ------------------------------------------------------------------------------
    ; Required PP Version                              
    ; ------------------------------------------------------------------------------
    DS::Proj\PPVersion$ = ReadPreferenceString("PPVersion", #Empty$)
    
    If DS::Proj\PPVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      DS::StatusErr | DS::#SERR_Unspecified_PP_Version
      msg::EnlistStatusError(~"\"butler.ini\" file: missing \"PPVersion\".")
      DS::PPStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN(~"  - PPVersion: " + #unspecified_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN(~"  - PPVersion: \"" + DS::Proj\PPVersion$ + ~"\"")
    EndIf
    ; ------------------------------------------------------------------------------
    ; Required Pandoc Version                            
    ; ------------------------------------------------------------------------------
    DS::Proj\PandocVersion$ = ReadPreferenceString("PandocVersion", #Empty$)
    
    If DS::Proj\PandocVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      DS::StatusErr | DS::#SERR_Unspecified_Pandoc_Version
      msg::EnlistStatusError(~"\"butler.ini\" file: missing \"PandocVersion\".")
      DS::PandocStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN(~"  - PandocVersion: " + #unspecified_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN(~"  - PandocVersion: \"" + DS::Proj\PandocVersion$ + ~"\"")
    EndIf
    ; ------------------------------------------------------------------------------
    ; Required Highlight Version                          
    ; ------------------------------------------------------------------------------
    ; Highlight version has syntax `MAJ.MIN` (eg: v3.40)
    DS::Proj\HighlightVersion$ = ReadPreferenceString("HighlightVersion", #Empty$)
    
    If DS::Proj\HighlightVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      DS::StatusErr | DS::#SERR_Unspecified_Highlight_Version
      msg::EnlistStatusError(~"\"butler.ini\" file: missing \"HighlightVersion\".")
      DS::HighlightStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN(~"  - HighlightVersion: " + #unspecified_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN(~"  - HighlightVersion: \"" + DS::Proj\HighlightVersion$ + ~"\"")
    EndIf
    ; ------------------------------------------------------------------------------
    
    ProcedureReturn #True ; <= Successfully opened "butler.ini"
  EndProcedure
  
  ; ******************************************************************************
  ; *                          Get Dependencies Version                          *
  ; ******************************************************************************
  Procedure GetDependenciesVersion()
    
    #not_found_msg$ = "not found on system"
    
    If DS::Verbose ; ====================================================> Verbosity
      PrintN("- Querying dependencies version:")
    EndIf
    
    ; ------------------------------------------------------------------------------
    ;- Get PP Version
    ; ------------------------------------------------------------------------------
    DS::Env\PPVersion$ =     deps::GetAppVersion("pp", "-v")
    
    ; ===> Check if PP was found: ==================================================
    If DS::Env\PPVersion$ = #Empty$
      DS::StatusErr | DS::#SERR_PP_Not_Found
      msg::EnlistStatusError("PP " + #not_found_msg$)
      DS::PPStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN("  - PP: " + #not_found_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN("  - PP: " + DS::Env\PPVersion$)
    EndIf
    ; ------------------------------------------------------------------------------
    ;- Get Pandoc Version
    ; ------------------------------------------------------------------------------
    DS::Env\PandocVersion$ = deps::GetAppVersion("pandoc", "--version")

    ; ===> Check if Pandoc was found: ==============================================
    If DS::Env\PandocVersion$ = #Empty$
      DS::StatusErr | DS::#SERR_Pandoc_Not_Found
      msg::EnlistStatusError("Pandoc " + #not_found_msg$)
      DS::PandocStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN("  - Pandoc: " + #not_found_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN("  - Pandoc: " + DS::Env\PandocVersion$)
    EndIf
    ; ------------------------------------------------------------------------------
    ;- Get Highlight Version
    ; ------------------------------------------------------------------------------
    DS::Env\HighlightVersion$ = deps::GetAppVersion("highlight", "--version")    
    
    ; ===> Check if Highlight was found: ===========================================
    If DS::Env\HighlightVersion$ = #Empty$
      DS::StatusErr | DS::#SERR_Highlight_Not_Found
      msg::EnlistStatusError("Highlight " + #not_found_msg$)
      DS::HighlightStatus = #False
      If DS::Verbose ; ====================================================> Verbosity
        PrintN("  - Highlight: " + #not_found_msg$)
      EndIf
    ElseIf DS::Verbose ; ====================================================> Verbosity
      PrintN("  - Highlight: " + DS::Env\HighlightVersion$)
    EndIf
  EndProcedure
  
  ; ******************************************************************************
  ; *                       Validate Dependencies Version                        *
  ; ******************************************************************************
  Procedure ValidateDependenciesVersion()
    
    If DS::Verbose ; ====================================================> Verbosity
      PrintN("- Validating project dependencies:")
    EndIf
    
    ;{ TODO: Implement Optional Dependencies
    ;
    ;       Not all deps will be mandatory in the final version of Butler.
    ;       Some external tools will be optionally supported. The only mandatory
    ;       tool is Pandoc. Even PP is not strictly required, but to make PP optional
    ;       I need to change the code that invokes PP/pandoc to behave differently if
    ;       PP were to be optional (for now I'll leave PP as mandatory). Also, if
    ;       PP became optional, all other deps will become meaningless since they could
    ;       not interface with Pandoc --- but I still think that some people might
    ;       want to use Butler with pandoc only, for simpler documentation projects,
    ;       especially if pandoc's syntax highlighter is enough for them.
    ;
    ;       In the final version of Butler, all these external tools will be optional:
    ;       -- Highlight
    ;       -- GraphViz
    ;       -- Asymptote (for asy images)
    ;       -- R (for Rplot)
    ;
    ;       Right now, I could implment Highlight as an optional dependencies.
    ;       But I need to change the code so that a #SERR_ is only set if the user
    ;       specified a required version.
    ;       Currently, if any dep is not found in the sys env, a #SERR_ is set (eg:
    ;       #SERR_Highlight_Not_Found).
    ;       
    ;       NOTE: ditaa and PlantUML are embedded in PP, but require Java to be installed
    ;       so maybe I need butler to check if the right version of Java is present?
    ;       Should I always check for Java version, or should I add a .ini preference
    ;       to specify that the project uses diita/PlantUML?
    ;
    ;}       Or I could just add Java and R (and Python?) as optional dependencies.
    
    ; TODO: Macro for ValidateDependenciesVersion()
    ;       All these checks could use 2 Macros to slim down code maintainence:
    ;       -- one for strict checks
    ;       -- another for constrained checks
    
    #cant_check_msg$ = "impossible to check"
    ; ------------------------------------------------------------------------------
    ; Check Butler Version (strict)
    ; ------------------------------------------------------------------------------
    If DS::ButlerStatus
      If DS::Proj\ButlerVersion$ <> DS::Butler\Version$
        CheckRes$ = "FAILED"
        DS::StatusErr | DS::#SERR_Mismatched_Butler_Version
        msg::EnlistStatusError(~"Butler version error -- Required: " + DS::Proj\ButlerVersion$ +
                               " | Found: " + DS::Butler\Version$ + ".")
      Else
        CheckRes$ = "PASSED"
      EndIf
      If DS::Verbose ; ==================================================> Verbosity
        PrintN("  - Butler (strict): "+ CheckRes$ )
      EndIf
    ElseIf DS::Verbose ; =====================================> Verbosity Skip Check
      PrintN("  - Butler (strict): "+ #cant_check_msg$ )
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check PP Version (strict)
    ; ------------------------------------------------------------------------------
    If DS::PPStatus
      If DS::Proj\PPVersion$ <> DS::Env\PPVersion$
        CheckRes$ = "FAILED"
        DS::StatusErr | DS::#SERR_Mismatched_PP_Version
        msg::EnlistStatusError(~"PP version error -- Required: " + DS::Proj\PPVersion$ +
                               " | Found: " + DS::Env\PPVersion$ + ".")
      Else
        CheckRes$ = "PASSED"
      EndIf
      If DS::Verbose ; ==================================================> Verbosity
        PrintN("  - PP (strict): "+ CheckRes$ )
      EndIf
    ElseIf DS::Verbose ; =====================================> Verbosity Skip Check
      PrintN("  - PP (strict): "+ #cant_check_msg$ )
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check Pandoc Version (constraints)
    ; ------------------------------------------------------------------------------
    If DS::PandocStatus
      Select deps::SatisfyVersion( DS::Proj\PandocVersion$, DS::Env\PandocVersion$ )
        Case 1
          CheckRes$ = "PASSED"
        Case 0
          CheckRes$ = "FAILED"
          DS::StatusErr | DS::#SERR_Mismatched_Pandoc_Version
          msg::EnlistStatusError(~"Pandoc version error -- Required: " + DS::Proj\PandocVersion$ +
                                 " | Found: " + DS::Env\PandocVersion$ + ".")
        Case -1
          CheckRes$ = "FAILED (malformed version string)"
          ; TODO: Implement Malformed Ver Str Err
          DS::StatusErr | DS::#SERR_Mismatched_Pandoc_Version
          msg::EnlistStatusError(~"Pandoc malformed version string error -- Required: " + DS::Proj\PandocVersion$ +
                                 " | Found: " + DS::Env\PandocVersion$ + ".")
      EndSelect
      If DS::Verbose ; ================================================> Verbosity
        PrintN("  - panodc: "+ CheckRes$ )
      EndIf
    ElseIf DS::Verbose ; ===================================> Verbosity Skip Check
      PrintN("  - panodc: "+ #cant_check_msg$ )
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check Highlight Version (constraints)
    ; ------------------------------------------------------------------------------
    CheckRes$ = "FAILED" ; Version Check Result: Defaults to FAILED  
    If DS::HighlightStatus
      Select deps::SatisfyVersion( DS::Proj\HighlightVersion$, DS::Env\HighlightVersion$ )
        Case 1
          CheckRes$ = "PASSED"
        Case 0
          CheckRes$ = "FAILED"
          DS::StatusErr | DS::#SERR_Mismatched_Highlight_Version
          msg::EnlistStatusError(~"Highlight version error -- Required: " + DS::Proj\HighlightVersion$ +
                                 " | Found: " + DS::Env\HighlightVersion$ + ".")
        Case -1
          CheckRes$ = "FAILED (malformed version string)"
          ; TODO: Implement Malformed Ver Str Err
          DS::StatusErr | DS::#SERR_Mismatched_Pandoc_Version
          msg::EnlistStatusError(~"Highlight malformed version string error -- Required: " + DS::Proj\HighlightVersion$ +
                                 " | Found: " + DS::Env\HighlightVersion$ + ".")
      EndSelect
      If DS::Verbose ; ====================================================> Verbosity
        PrintN("  - Highlight: "+ CheckRes$ )
      EndIf
    ElseIf DS::Verbose ; ===================================> Verbosity Skip Check
      PrintN("  - Highlight: "+ #cant_check_msg$ )
    EndIf
    
  EndProcedure
  
EndModule