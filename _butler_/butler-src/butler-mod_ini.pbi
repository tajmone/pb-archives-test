; ··············································································
; ··············································································
; ························ Butler Initialization Module ························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_ini.pbi" | PureBASIC 5.61

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
  ;                            PUBLIC VARS & CONSTANTS                            
  ; ==============================================================================
  ;                              Butler's Data & Info                             
  ; ------------------------------------------------------------------------------
  Structure butlerinfo
    Version$            ; SemVer 2.0 str of curr Butler rel (str set in Main code).
    Path$               ; As defined in BUTLER_PATH env var.
  EndStructure
  
  Butler.butlerinfo
  
  CompilerIf #PB_Compiler_Processor = #PB_Processor_x86 ; Bitness Str-Constant
    #ButlerBitness$ = "32"
  CompilerElse
    #ButlerBitness$ = "64"
  CompilerEndIf
  ; ------------------------------------------------------------------------------
  ;                            Environment Data & Info                            
  ; ------------------------------------------------------------------------------
  Structure envinfo
    PPVersion$        ; Actual PP Version found in system.
    PandocVersion$    ; Actual Pandoc Version found in system.
    HighlightVersion$ ; Actual Highlight Version found in system.
  EndStructure
  
  Env.envinfo
  ; ------------------------------------------------------------------------------
  ;-                            Project's Data & Info                             
  ; ------------------------------------------------------------------------------
  ; Strcutured vars with data and info on current project and its requirements...
  ; ------------------------------------------------------------------------------ 
  Structure projectinfo
    Root$             ; Absolute path to project's root.
    ButlerVersion$    ; Butler version reuired by project (exact).
    PPVersion$        ; PP version reuired by project (exact).
    PandocVersion$    ; Pandoc version reuired by project (exact).
    HighlightVersion$ ; Highlight min-version reuired by project.
  EndStructure
  
  Proj.projectinfo
  ; ------------------------------------------------------------------------------
  ;-                           User Options Data & Info                           
  ; ------------------------------------------------------------------------------
  Define UserOpts        ; <= Holds the following option flags:
  
  EnumerationBinary
    #opt_NoOpts       ; User didn't provide any args/opts.
    #opt_opStatusReq  ; User opts require operativeStatus to be True.
                      ; === Info Query Options: ======================================
    #opt_Version      ; Print Butler's version
    #opt_Help         ; Print Help
                      ; === Proj Processing Options: =================================
    #opt_BuildFolder  ; Build current folder.
    #opt_BuildAll     ; Build whole project.
    #opt_Recursive    ; Recurse into subfolders.
    #opt_Verbose      ; Verbose mode.
  EndEnumeration
  
  ; ------------------------------------------------------------------------------
  ;-                                Status Errors                                 
  ; ------------------------------------------------------------------------------
  Define StatusErr
  
  EnumerationBinary
    #SERR_Win_NotShell
    #SERR_Missing_BUTLER_PATH
    #SERR_Missing_Ini_File
    #SERR_PP_Not_Found
    #SERR_Pandoc_Not_Found
    #SERR_Highlight_Not_Found
    #SERR_Unspecified_Butler_Version
    #SERR_Unspecified_PP_Version
    #SERR_Unspecified_Pandoc_Version
    #SERR_Unspecified_Highlight_Version
    #SERR_Mismatched_Butler_Version
    #SERR_Mismatched_PP_Version
    #SERR_Mismatched_Pandoc_Version
    #SERR_Mismatched_Highlight_Version
  EndEnumeration
  ; ==============================================================================
  ;                         PUBLIC PROCEDURES DECLARATION                         
  ; ==============================================================================
  Declare Init()
EndDeclareModule

Module ini
  IncludeFile "butler-mod_ini.pbhgen.pbi" ; <= PBHGEN-X
  
  ; ==============================================================================
  ;                         PRIVATE PROCEDURES DECLARATION                        
  ; ==============================================================================
  Declare   ParseCLIArgs(numParams)
  Declare   ReadSettingsFile()
  Declare.s GetHighlightVersion()
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
    
    Shared Butler, Env
    Shared Proj
    Shared UserOpts, StatusErr
    ; ------------------------------------------------------------------------------
    ;-                           Windows: Is Bash/Shell?                            
    ; ------------------------------------------------------------------------------
    ; If OS is Win, make sure Butler is invoked from Bash (Git Bash).
    ; This is done by checking for the presence of the SHELL env var.     
    ; ------------------------------------------------------------------------------
    CompilerIf #PB_Compiler_OS = #PB_OS_Windows
      If GetEnvironmentVariable("SHELL") = #Null$
        StatusErr | #SERR_Win_NotShell
      EndIf
    CompilerEndIf
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;                          PARSE COMMAND LINE ARGUMENTS?                         
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    numParams = CountProgramParameters()
    If numParams
      ParseCLIArgs(numParams)
    Else
      ; Butler invoked without any arguments...
      UserOpts | #opt_NoOpts
    EndIf
    
    ; ------------------------------------------------------------------------------
    ;                   Get Butler's Path from BUTLER_PATH Env Var                  
    ;{------------------------------------------------------------------------------
    Butler\Path$ = GetEnvironmentVariable("BUTLER_PATH")
    If Butler\Path$ = #Null$
      ;       ConsoleError("BUTLER_PATH env var not found!!!")  ; DELME -- BUTLER_PATH env var not found
      StatusErr | #SERR_Missing_BUTLER_PATH
    Else
      ; If BUTLER_PATH en var was found ...
      ; ------------------------------- Sanitize Path --------------------------------
      ; Fix path separators (slashes) according to OS and also ensures that path ends
      ; with path separator (if not present) ...
      ; TODO: Also check that path doesn't contain invalid chars (spaces, etc.)
      Butler\Path$ = FS::SanitizeDirPath(Butler\Path$)
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
      HL_DATADIR$ = Butler\Path$ + "highlight-data" + FS::#DIR_SEP$
      SetEnvironmentVariable("HIGHLIGHT_DATADIR", HL_DATADIR$)
      ; DEBUG IT:
      PrintN("~ HIGHLIGHT_DATADIR: " + GetEnvironmentVariable("HIGHLIGHT_DATADIR")) ; DBG
      
      ; ------------------------------------------------------------------------------
      ;-                 Check "butler.ini" (Proj. Preferences File)                  
      ; ------------------------------------------------------------------------------
      If FileSize(Butler\Path$ + "butler.ini") > 0
        ReadSettingsFile()
      Else
        StatusErr | #SERR_Missing_Ini_File
      EndIf 
      ; ------------------------------------------------------------------------------
      ;-                         Dependencies: Check Versions                         
      ; ------------------------------------------------------------------------------
      ValidateDependenciesVersion()
    EndIf 
    
    
    
    ;}------------------------------------------------------------------------------
    ;                         Establish Project's Root Path                         
    ; ------------------------------------------------------------------------------
    ; The project root is one levl up from Butler's folder...
    ; ------------------------------------------------------------------------------
    tot = CountString(Butler\Path$, FS::#DIR_SEP$)
    For i = 1 To tot - 1
      ; Build path string omitting last folder (ie: "/_butler_/")
      Proj\Root$ + StringField(Butler\Path$, i, FS::#DIR_SEP$) + FS::#DIR_SEP$
    Next
    ; ==============================================================================
    ;-                           Return Operative Status                            
    ; ==============================================================================
    If StatusErr
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
    
    Shared UserOpts
    
    Enumeration RegExs
      #RE_OptsShort
    EndEnumeration
    
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
      Data.w                        #opt_Version
      Data.s "--help",      "h" ; - Print Help
      Data.w                        #opt_Help
      ; === Proj Processing Options: =====================
      Data.s "--build",     "b" ; - Build current folder
      Data.w                        #opt_BuildFolder | #opt_opStatusReq
      Data.s "--build-all", "B" ; - Build whole project.
      Data.w                        #opt_BuildAll | #opt_Recursive | #opt_opStatusReq
      Data.s "--recursive", "r" ; - Recurse into subfolders
      Data.w                        #opt_Recursive
      Data.s "--verbose",   "V" ; - Verbosity ON
      Data.w                        #opt_Verbose
      
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
          UserOpts | OptsLongM(currParam)
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
                UserOpts | OptsShortM(currOpt$)
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
    
    ConsoleError("<<<<< ini::ParseCLIArgs() <<<<<")
  EndProcedure
  ; ******************************************************************************
  ; *                             Read Settings File                             *
  ; ******************************************************************************
  Procedure ReadSettingsFile()
    ConsoleError(">>>>>> ini::ReadSettingsFile() >> ENTER") ; DELME Debugging
    
    Shared Butler, Proj
    
    If Not OpenPreferences(Butler\Path$ + "butler.ini")
      ; FIXME: Can't open "butler.ini" Error report
      ConsoleError(~"ERROR: Couldn't open \"butler.ini\" file!")
      ProcedureReturn #False ; <= operativeStatus = False
    EndIf
    ; ------------------------------------------------------------------------------
    ;                            Required Butler Version                            
    ; ------------------------------------------------------------------------------
    Proj\ButlerVersion$ = ReadPreferenceString("ButlerVersion", #Empty$)
    
    ; ------------------------------------------------------------------------------
    ;                              Required PP Version                              
    ; ------------------------------------------------------------------------------
    Proj\PPVersion$ = ReadPreferenceString("PPVersion", #Empty$)
    
    ; ------------------------------------------------------------------------------
    ;                            Required Pandoc Version                            
    ; ------------------------------------------------------------------------------
    Proj\PandocVersion$ = ReadPreferenceString("PandocVersion", #Empty$)
    
    ; ------------------------------------------------------------------------------
    ;-                          Required Highlight Version                          
    ; ------------------------------------------------------------------------------
    ; Highlight version has syntax `MAJ.MIN` (eg: v3.40)
    Proj\HighlightVersion$ = ReadPreferenceString("HighlightVersion", #Empty$)
    
    ; ------------------------------------------------------------------------------    
    ConsoleError("<<<<<< ini::ReadSettingsFile() >> LEAVE") ; DELME Debugging
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                       Validate Dependencies Version                        *
  ; ******************************************************************************
  Procedure ValidateDependenciesVersion()
    Shared Butler, Proj, Env
    Shared StatusErr
    ; TODO: Not all deps will be mandatory in the final version of Butler.
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
    ;       Or I could just add Java and R (and Python?) as optional dependencies.
      
    
    ; ==============================================================================
    ;-                          Get Dependencies Versions                           
    ;{==============================================================================
    ; TODO: Change this part:
    ; -- use new deps::GetAppVersion(app$, params$)
    ; -- create a loop that reads from a DataSection app$ and params$
    ; -- don't set any status errors (#SERR_) at this point, but let the version
    ;    checks part handle it.
    
    ; ------------------------------------------------------------------------------
    ;- Get PP/Pandoc Version
    ; ------------------------------------------------------------------------------
    Env\PPVersion$ =     PPP::GetPPVersion()
    Env\PandocVersion$ = PPP::GetPandocVersion()
    ; ===> Check if PP was found: ==================================================
    If Env\PPVersion$ = #Empty$
      StatusErr | #SERR_PP_Not_Found
    EndIf
    ; ===> Check if Pandoc was found: ==============================================
    If Env\PandocVersion$ = #Empty$
      StatusErr | #SERR_Pandoc_Not_Found
    EndIf
    ; ------------------------------------------------------------------------------
    ;- Get Highlight Version
    ; ------------------------------------------------------------------------------
    Env\HighlightVersion$ = GetHighlightVersion()
    ; ===> Check if Highlight was found: ===========================================
    If Env\HighlightVersion$ = #Empty$
      StatusErr | #SERR_Highlight_Not_Found
    EndIf
    ;}==============================================================================
    ;-                         Check Dependencies Versions                          
    ; ==============================================================================
    ; TODO: This must become a loop with DataSection containing:
    ;       -- App Name Str (for Status/Error report)
    ;       -- Req.Ver Str + Found Ver Str
    ;       -- MANDATORY Bool indicating if dep is optional or not
    ;       -- STRICT Bool indicating strict string comparison instead of deps::CompareVersion()
    ;       -- #SERR_[dep]_Not_Found flags to set if Status Error is due
    ;       -- #SERR_Unspecified_[dep]_Version flags to set if Status Error is due
    ;       -- #SERR_Mismatched_[dep]_Version flags to set if Status Error is due
    ;       The loops should then check:
    ;       1) If the user specified a Req.Ver Str:
    ;          YES -- then check Found Ver Str:
    ;                 -- If Found Ver Str is #Empty, set a `#SERR_[dep]_Not_Found` flag
    ;                 -- If not empty, carry out version checks:
    ;                    -- If STRICT, just compare strings
    ;                    -- else, call deps::CompareVersion(Found Ver$, Req.Ver$)
    ;                    -- if version mismatches, set `#SERR_Mismatched_[dep]_Version`
    ;          NOT -- If dep has MANDATORY:
    ;                 -- set `#SERR_Unspecified_[dep]_Version`
    ;                 -- If Found Ver Str is #Empty, set a `#SERR_[dep]_Not_Found` flag
    ;       2) Add STATUS report entry (if Verobse/Status) --- right now, just
    ;          print it on STDERR, until I implement the STATUS option (which shall
    ;          be implicitly set by VERBOSITY)
    ;
    ; NOTE: In the future Status Error report entries could be added here, instead
    ;       of of main body code
    ;
    ; NOTE: Mandatory deps should always raise a `#SERR_[dep]_Not_Found` when not
    ;       present in the system
    ; ------------------------------------------------------------------------------
    ; Check Butler Version (strict)
    ; ------------------------------------------------------------------------------
    If Proj\ButlerVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_Butler_Version
      ConsoleError("!!! ButlerVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Proj\ButlerVersion$ <> Butler\Version$
      StatusErr | #SERR_Mismatched_Butler_Version
      ConsoleError("!!! ButlerVersion$ <> Butler\Version$: " + 
                   Proj\ButlerVersion$ + " <> " + Butler\Version$ ) ; DELME Debugging
    Else                                                            ; DELME Debugging
      ConsoleError("!!! ButlerVersion$ == Butler\Version$ !!!")     ; DELME Debugging
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check PP Version (strict)
    ; ------------------------------------------------------------------------------
    If Proj\PPVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_PP_Version
      ConsoleError("!!! PPVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Not ( StatusErr & #SERR_PP_Not_Found )
      If Proj\PPVersion$ <> Env\PPVersion$
        StatusErr | #SERR_Mismatched_PP_Version
        ConsoleError("!!! PPVersion$ <> Env\PPVersion$: " + Proj\PPVersion$ + " <> " + Env\PPVersion$ ) ; DELME Debugging
      Else                                                                                              ; DELME Debugging
        ConsoleError("!!! PPVersion$ == Env\PPVersion$ !!!")                                            ; DELME Debugging
      EndIf
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check Pandoc Version (strict)
    ; ------------------------------------------------------------------------------
    If Proj\PandocVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_Pandoc_Version
      ConsoleError("!!! PandocVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Not ( StatusErr & #SERR_Pandoc_Not_Found )
      If Proj\PandocVersion$ <> Env\PandocVersion$
        StatusErr | #SERR_Mismatched_Pandoc_Version
        ConsoleError("!!! PandocVersion$ <> Env\PandocVersion$: " + Proj\PandocVersion$ + " <> " + Env\PandocVersion$ ) ; DELME Debugging
      Else                                                                                                              ; DELME Debugging
        ConsoleError("!!! PandocVersion$ == Env\PandocVersion$ !!!")                                                    ; DELME Debugging
      EndIf
    EndIf
    ; ------------------------------------------------------------------------------
    ; Check Highlight Version (min ver constraint)
    ; ------------------------------------------------------------------------------
    If Proj\HighlightVersion$ = #Empty$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_Highlight_Version
      ConsoleError("!!! HighlightVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Not ( StatusErr & #SERR_Highlight_Not_Found )
      ; =====================================
      ; Minimum Version Constraint Comparison
      ; =====================================
      ; Check that found HL ver is >= required version (but same MAJ):
      ; -- MAJOR version must but the same
      ; -- MINOR version found must be >= req.ver
      If Not CreateRegularExpression(0, "(\d+)\.(\d+)")
        ; FIXME: Butler Internal Error (use custom msg:: proc)
        ConsoleError("BUTLER INTERNAL ERROR -- ini::ReadSettingsFile() RegEx creation failed!") 
        End 1
      EndIf 
      ; ------------------------------------------------------------------------------
      ; Get HL Found Ver MAJ & MIN Vals                            
      ; ------------------------------------------------------------------------------
      If MatchRegularExpression(0, Env\HighlightVersion$)
        If ExamineRegularExpression(0, Env\HighlightVersion$)
          NextRegularExpressionMatch(0)
          HLFound_MAJ = Val( RegularExpressionGroup(0, 1) )
          HLFound_MIN = Val( RegularExpressionGroup(0, 2) )
        EndIf
      EndIf
      ; ------------------------------------------------------------------------------
      ; Get HL Required Ver MAJ & MIN Vals                            
      ; ------------------------------------------------------------------------------
      If MatchRegularExpression(0, proj\HighlightVersion$)
        If ExamineRegularExpression(0, proj\HighlightVersion$)
          NextRegularExpressionMatch(0)
          HLReq_MAJ = Val( RegularExpressionGroup(0, 1) )
          HLReq_MIN = Val( RegularExpressionGroup(0, 2) )
        EndIf
      EndIf
      ; ------------------------------------------------------------------------------
      ConsoleError("~> Highlight Found MAJ = "+ Str(HLFound_MAJ) +" | MIN = "+ Str(HLFound_MIN)) ; DELME HL-Ver Debugging
      ConsoleError("~> Highlight Req.  MAJ = "+ Str(HLReq_MAJ)   +" | MIN = "+ Str(HLReq_MIN))   ; DELME HL-Ver Debugging
      
      ; ------------------------------------------------------------------------------
      FreeRegularExpression(0)
      
      If HLFound_MAJ <> HLReq_MAJ Or HLFound_MIN < HLReq_MIN
        StatusErr | #SERR_Mismatched_Highlight_Version
        ConsoleError("!!! HighlightVersion$ <> Env\HighlightVersion$: " + Proj\HighlightVersion$ + " <> " + Env\HighlightVersion$ ) ; DELME Debugging
      Else                                                                                                                          ; DELME Debugging
        If HLReq_MIN = HLFound_MIN 
          ConsoleError("!!! HighlightVersion$ == Env\HighlightVersion$ !!!")                                                          ; DELME Debugging
        Else
          ConsoleError("!!! HighlightVersion$ <  Env\HighlightVersion$ !!!")                                                          ; DELME Debugging
        EndIf
      EndIf
    EndIf   
    
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                           Get Highlight Version                            *
  ; ******************************************************************************
  Procedure.s GetHighlightVersion()
    ; We reuse mod PPP's PPP::GetAppVersion() procedure!
    ProcedureReturn PPP::GetAppVersion("highlight", "--version")
  EndProcedure
  
  
EndModule