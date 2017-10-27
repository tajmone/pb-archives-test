﻿; ··············································································
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

; TODO: Add Check and Var for Win Bash (ie: if currently in Bash or CMD)

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

IncludeFile "butler-mod_ini.pbhgen.pbi" ; <= PBHGEN-X

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
    PPVersion$     ; Version of actual PP found.
    PandocVersion$ ; Version of actual Pandoc found.
  EndStructure
  
  Env.envinfo
  ; ------------------------------------------------------------------------------
  ;-                            Project's Data & Info                             
  ; ------------------------------------------------------------------------------
  ; Strcutured vars with data and info on current project and its requirements...
  ; ------------------------------------------------------------------------------ 
  Structure projectinfo
    Root$             ; Absolute path to project's root.
    ButlerVersion$    ; Butler version reuired by project.
    PPVersion$        ; PP version reuired by project.
    PandocVersion$    ; Pandoc version reuired by project.
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
    #SERR_Missing_BUTLER_PATH
    #SERR_Missing_Ini_File
    #SERR_PP_Not_Found
    #SERR_Pandoc_Not_Found
    #SERR_Unspecified_Butler_Version
    #SERR_Unspecified_PP_Version
    #SERR_Unspecified_Pandoc_Version
    #SERR_Mismatched_Butler_Version
    #SERR_Mismatched_PP_Version
    #SERR_Mismatched_Pandoc_Version
  EndEnumeration
  ; ==============================================================================
  ;                         PUBLIC PROCEDURES DECLARATION                         
  ; ==============================================================================
  Declare Init()
EndDeclareModule

Module ini
  ; ==============================================================================
  ;                         PRIVATE PROCEDURES DECLARATION                        
  ; ==============================================================================
  Declare ParseCLIArgs(numParams)
  Declare ReadSettingsFile()
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
    ConsoleError("******************************************************************************"); DELME Debugging
    ConsoleError("ini::Init() >> ENTER")                                                          ; DELME Debugging
    
    operativeStatus = #True ; Assume true until some problems are found!
    
    Shared Butler, Env
    Shared Proj
    Shared UserOpts, StatusErr
    
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;                          PARSE COMMAND LINE ARGUMENTS?                         
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    numParams = CountProgramParameters()
    If numParams
      ParseCLIArgs(numParams)
    Else
      ; ==============================================================================
      ;                           NO PARAMETERS WERE PASSED                           
      ; ==============================================================================
      UserOpts | #opt_NoOpts
      ;       ConsoleError("ini::Init() > No params found...") ; DELME Debugging NO ARGS
    EndIf
    ; ------------------------------------------------------------------------------
    ;-                            Get PP/Pandoc Version                             
    ; ------------------------------------------------------------------------------
    ; TODO: Implement PP/Pandoc not found Error!
    Env\PPVersion$ = PPP::GetPPVersion()
    Env\PandocVersion$ = PPP::GetPandocVersion()
    ; TODO: Implement PP/Pandoc Not Found Err Flag!
    ; ===> Check if PP was found: ==================================================
    If Env\PPVersion$ = #Null$
      PrintN("$$$ PP NOT FOUND!! $$$") ; DELME Debug PPVersion$
      StatusErr | #SERR_PP_Not_Found
      operativeStatus = #False
    Else
      PrintN("$$$ PP Version found: '"+ Env\PPVersion$ +"' $$$") ; DELME Debug PPVersion$
    EndIf
    ; ===> Check if Pandoc was found: ==============================================
    If Env\PandocVersion$ = #Null$
      PrintN("$$$ Pandoc NOT FOUND!! $$$") ; DELME Debug PPVersion$
      StatusErr | #SERR_Pandoc_Not_Found
      operativeStatus = #False
    Else
      PrintN("$$$ Pandoc Version found: '"+ Env\PandocVersion$ +"' $$$") ; DELME Debug PandocVersion$
    EndIf
    
    ; ------------------------------------------------------------------------------
    ;                   Get Butler's Path from BUTLER_PATH Env Var                  
    ;{------------------------------------------------------------------------------
    Butler\Path$ = GetEnvironmentVariable("BUTLER_PATH")
    If Butler\Path$ = #Null$
      ;       ConsoleError("BUTLER_PATH env var not found!!!")  ; DELME -- BUTLER_PATH env var not found
      StatusErr | #SERR_Missing_BUTLER_PATH
      operativeStatus = #False
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
      ; NOTE: Currently Highlight (3.39) for Windows doesn't support the HIGHLIGHT_DATADIR override.
      ;       Untill implemented, we'll set the HL_LANGS env var and in the macros use
      ;       the `--config-file=<file>` option instead. See issue #24: 
      ;       -- https://github.com/andre-simon/highlight/issues/24
      HL_DATADIR$ = Butler\Path$ + "highlight-langs" + FS::#DIR_SEP$
      
      SetEnvironmentVariable("HL_LANGS", HL_DATADIR$)
      ;       SetEnvironmentVariable("HIGHLIGHT_DATADIR", Butler\Path$ + "highlight-data" + FS::#DIR_SEP$) ; <= For future use!
      ; DEBUG IT:
      HL_DATADIR$ = GetEnvironmentVariable("HL_LANGS")
      PrintN("~ HL_LANGS: " + HL_DATADIR$) ; DBG
      
      ; ------------------------------------------------------------------------------
      ;                  Check "butler.ini" (Proj. Preferences File)                  
      ; ------------------------------------------------------------------------------
      ; Check if a "butler.ini" file is present in Butler's folder
      PrintN("INI FILE > " + Butler\Path$ + "butler.ini") ; DELME
      If FileSize(Butler\Path$ + "butler.ini") > 0
        PrintN("!!! Butler.ini found !!!") ; DELME
        operativeStatus & ReadSettingsFile() ; <= Result is ANDed with operativeStatus
      Else
        ; TODO: Implement Missing "butler.ini" Error !
        StatusErr | #SERR_Missing_Ini_File
        operativeStatus = #False
        PrintN("!!! Butler.ini NOT found !!!") ; DELME
      EndIf 
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
    ; ------------------------------------------------------------------------------
    
    
    
    
    ConsoleError("ini::Init() << LEAVE")
    ConsoleError("******************************************************************************")
    ProcedureReturn operativeStatus
    
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
    ConsoleError(">>>>> ini::ParseCLIArgs() >>>>>")
    
    Shared UserOpts
    
    Enumeration RegExs
      #RE_OptsShort
    EndEnumeration
    
    If Not CreateRegularExpression(#RE_OptsShort, "-([a-zA-Z]+)$") ; <= RegEx str should contain only valid short-options chars (case sensitive)
      ConsoleError("Couldn't create RegEx: #RE_OptsShort")         ; FIXME: Convert to Abort()!!!
      End 1
    EndIf
    
    ; ==============================================================================
    ;-                                 Options Maps                                 
    ;{==============================================================================
    ; Opts-Contants and maps for short and long opts; used to create a list of all
    ; options found... Not
    
    Enumeration             ; >>>>>>>>>>>>>>>>>> Valid User Opts >>>>>>>>>>>>>>>>>>>
                            ; === Info Query Options: ==============================
      #optsmap_Version      ; - Print Butler's version
      #optsmap_Help         ; - Print Help
                            ; === Proj Processing Options: =========================
      #optsmap_BuildFolder  ; - Build current folder.
      #optsmap_BuildAll     ; - Build whole project.
      #optsmap_Recursive    ; - Recurse into subfolders.
      #optsmap_Verbose      ; - Verbosity ON.
    EndEnumeration          ; <<<<<<<<<<<<<<<<<< Valid User Opts <<<<<<<<<<<<<<<<<<<
    
    optsTot = #PB_Compiler_EnumerationValue
    
    DataSection             ; >>>>>>>>>>>>>>>>>> Long Opts Strings >>>>>>>>>>>>>>>>>
      LongOptsData:         ; === Info Query Options: ==============================
      Data.s "--version"    ; Butler's version
      Data.s "--help"       ; Print Help
                            ; === Proj Processing Options: =========================
      Data.s "--build"      ; build folder
      Data.s "--build-all"  ; build all
      Data.s "--recursive"  ; recursive
      Data.s "--verbose"    ; verbose
    EndDataSection          ; <<<<<<<<<<<<<<<<<< Long Opts Strings <<<<<<<<<<<<<<<<<
    
    ; =========================== Create Short Opts Map ============================
    ; Create the map entry by entry, because some options don't have a short version
    ; equivalent...
    NewMap ShortOptsM.a()   ; >>>>>>>>>>>>>>>>>> Short Opts Chars >>>>>>>>>>>>>>>>>>
    
    ;                                        === Info Query Options: ===============
    ShortOptsM("v") = #optsmap_Version     ; Butler's version
    ShortOptsM("h") = #optsmap_Help        ; Print Help
                                           ; === Proj Processing Options: ==========
    ShortOptsM("b") = #optsmap_BuildFolder ; build folder
    ShortOptsM("B") = #optsmap_BuildAll    ; build all
    ShortOptsM("r") = #optsmap_Recursive   ; recursive
    ShortOptsM("V") = #optsmap_Verbose     ; verbose    
    
    ; ============================ Build Long Opts Map =============================
    ; Create the map via a loop, because every option has a long representation...
    NewMap LongOptsM.a()
    Restore LongOptsData
    For i = 1 To optsTot
      Read.s Key$
      LongOptsM(Key$) = i-1
    Next i  
    
    ;}////// END :: Options Maps ///////////////////////////////////////////////////
    
    ; ==============================================================================
    ;                             ITERATE THROUGH PARAMS                            
    ;{==============================================================================
    ; Iterate through all params and build a list of the encountered options, and a
    ; a list of the encountered unknown params...
    ; ------------------------------------------------------------------------------
    NewList optsL()     ; <= Temp List to store all opts found.
    NewList optsBadL.s(); <= Temp List to store all unknown opts and params found.
    For param = 1 To numParams
      currParam.s = ProgramParameter()
      If Left(currParam, 2) = "--"
        ; ------------------------------------------------------------------------------
        ;                              PARAM IS LONG OPTION                             
        ; ------------------------------------------------------------------------------       
        If FindMapElement(LongOptsM(), LCase(currParam)) ; <= Lower-Case comparison!
          AddElement(optsL())
          optsL() = LongOptsM(currParam)
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
              If FindMapElement(ShortOptsM(), currOpt$)
                AddElement(optsL())
                optsL() = ShortOptsM(currOpt$)
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
    ;}------------------------------------------------------------------------------
    
    ; DELME ====== Debug Options List (int values) ======
    ;     ConsoleError( LSet("", 80, "-") + ~"\nOptions List:" )
    ;     ForEach optsL()
    ;       ConsoleError(" - " + Str( optsL() ))
    ;     Next
    ;     
    ; ==============================================================================
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
    
    ; ==============================================================================
    ;-                            EVALUATE USER OPTIONS                             
    ; ==============================================================================
    ; Sift through the list of user options and set Butler Tasks accordingly...
    ; ------------------------------------------------------------------------------
    ConsoleError( LSet("", 80, "-") + ~"\nEvaluating Options List:" ) ; DELME
    ForEach optsL()
      Select optsL()
          ; FIXME: EVALUATE USER OPTIONS  -- Remove Debug output!
          ; ------------------------------------------------------------------------------
          ;                               Info Query Options                              
          ; ------------------------------------------------------------------------------
        Case #optsmap_Version                          ; ====> Print Butler's version <==============
          UserOpts | #opt_Version
          ConsoleError(" -- Print Butler's Version") ; DBG Eval User Opts
        Case #optsmap_Help                           ; ====> Print Help <==============
          UserOpts | #opt_Help
          ConsoleError(" -- Print Help") ; DBG Eval User Opts
          
          ; ------------------------------------------------------------------------------
          ;                            Proj Processing Options                            
          ; ------------------------------------------------------------------------------
        Case #optsmap_BuildFolder             ; ====> Build current folder <==============
          UserOpts | #opt_opStatusReq         ; This opt requires operativeStatus
          UserOpts | #opt_BuildFolder
          ConsoleError(" -- Build current folder"); DBG Eval User Opts
        Case #optsmap_BuildAll                    ; ====> Build whole project  <==============
          UserOpts | #opt_opStatusReq             ; This opt requires operativeStatus
          UserOpts | #opt_BuildAll
          UserOpts | #opt_Recursive
          ConsoleError(" -- Build whole project"); DBG Eval User Opts
        Case #optsmap_Recursive                  ; ====> Recursive Mode       <==============
          UserOpts | #opt_Recursive
          ConsoleError(" -- Recursive Mode")  ; DBG Eval User Opts
        Case #optsmap_Verbose                 ; ====> Verbosity Mode       <==============
          UserOpts | #opt_Verbose
          ConsoleError(" -- Verbosity Mode")  ; DBG Eval User Opts
      EndSelect
    Next
    
    ConsoleError("<<<<< ini::ParseCLIArgs() <<<<<")
  EndProcedure
  ; ******************************************************************************
  ; *                             Read Settings File                             *
  ; ******************************************************************************
  Procedure ReadSettingsFile()
    ConsoleError(">>>>>> ini::ReadSettingsFile() >> ENTER") ; DELME Debugging
    
    ; TODO: IMPORTANT!!! Find a way to set operativeStatus = #False in case of
    ;       errors!!! ie: operativeStatus is a var local to Init(), so I either
    ;       make it global, or use a ProcedureReturn here to set its value!
    
    ; This local operativeStatus will be returned to the calling procedure, so it
    ; can be ANDed with its counterpart:
    operativeStatus = #True ; Assume true until some problems are found!
    
    
    Shared Butler, Proj, Env
    Shared StatusErr
    
    If Not OpenPreferences(Butler\Path$ + "butler.ini")
      ; FIXME: Can't open "butler.ini" Error report
      ConsoleError(~"ERROR: Couldn't open \"butler.ini\" file!")
      ProcedureReturn #False ; <= operativeStatus = #False
    EndIf
    ; ------------------------------------------------------------------------------
    ;                            Required Butler Version                            
    ; ------------------------------------------------------------------------------
    Proj\ButlerVersion$ = ReadPreferenceString("ButlerVersion", #Null$)
    
    If Proj\ButlerVersion$ = #Null$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_Butler_Version
      operativeStatus = #False
      ConsoleError("!!! ButlerVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Proj\ButlerVersion$ <> Butler\Version$
      StatusErr | #SERR_Mismatched_Butler_Version
      operativeStatus = #False
      ConsoleError("!!! ButlerVersion$ <> Butler\Version$: " + 
                   Proj\ButlerVersion$ + " <> " + Butler\Version$ ) ; DELME Debugging
    Else                                                            ; DELME Debugging
      ConsoleError("!!! ButlerVersion$ == Butler\Version$ !!!")     ; DELME Debugging
    EndIf
    ; ------------------------------------------------------------------------------
    ;                              Required PP Version                              
    ; ------------------------------------------------------------------------------
    Proj\PPVersion$ = ReadPreferenceString("PPVersion", #Null$)
    
    If Proj\PPVersion$ = #Null$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_PP_Version
      operativeStatus = #False
      ConsoleError("!!! PPVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Not ( StatusErr & #SERR_PP_Not_Found )
      If Proj\PPVersion$ <> Env\PPVersion$
        StatusErr | #SERR_Mismatched_PP_Version
        operativeStatus = #False
        ConsoleError("!!! PPVersion$ <> Env\PPVersion$: " + Proj\PPVersion$ + " <> " + Env\PPVersion$ ) ; DELME Debugging
      Else                                                                                              ; DELME Debugging
        ConsoleError("!!! PPVersion$ == Env\PPVersion$ !!!")                                            ; DELME Debugging
      EndIf
    EndIf
    ; ------------------------------------------------------------------------------
    ;                            Required Pandoc Version                            
    ; ------------------------------------------------------------------------------
    Proj\PandocVersion$ = ReadPreferenceString("PandocVersion", #Null$)
    
    If Proj\PandocVersion$ = #Null$
      ; Either the Key is not present or it has empty value...
      StatusErr | #SERR_Unspecified_Pandoc_Version
      operativeStatus = #False
      ConsoleError("!!! PandocVersion$ not set in butler.ini !!!") ; DELME Debugging
    EndIf
    
    If Not ( StatusErr & #SERR_Pandoc_Not_Found )
      If Proj\PandocVersion$ <> Env\PandocVersion$
        StatusErr | #SERR_Mismatched_Pandoc_Version
        operativeStatus = #False
        ConsoleError("!!! PandocVersion$ <> Env\PandocVersion$: " + Proj\PandocVersion$ + " <> " + Env\PandocVersion$ ) ; DELME Debugging
      Else                                                                                                              ; DELME Debugging
        ConsoleError("!!! PandocVersion$ == Env\PandocVersion$ !!!")                                                    ; DELME Debugging
      EndIf
    EndIf
    
    
    
    ConsoleError("<<<<<< ini::ReadSettingsFile() >> LEAVE") ; DELME Debugging
    
    ProcedureReturn operativeStatus
    
  EndProcedure
  
EndModule