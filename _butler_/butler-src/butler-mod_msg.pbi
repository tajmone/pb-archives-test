; ··············································································
; ··············································································
; ······················ Butler Messages Module ( msg:: ) ······················
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_txt.pbi" | PureBASIC 5.61

; Text formatting helper functions
;
; modules dependencies:
; -- DS::
; -- txt::

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================


; TODO LIST:
; -- InternalErrorAbort() to handle internal failures (RegEx, file opening, etc)
; -- Implement Ansi Colors.

; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule msg
  ; ==============================================================================
  ;                            PUBLIC VARS & CONSTANTS                            
  ; ==============================================================================
  ; ** STATUS ERROR WORK STRING **
  Define StatusErrorReport$
  ; ------------------------------------------------------------------------------
  ; TODO: Make Private these constants and macros!
  #EOL$ = txt::#EOL$    ; <= Set OS-appropriate #EOL$, as defined in module txt
  
  ; DELME: cntStr(num) Macro? Any other procedure might need it?
  ;        It was used by ListStatusErrors(), which is now deleted!
  
  ; cntStr(number) Macro => Used to format ordered list strings:
  ; "  1. "
  ; "  2. "
  Macro cntStr(num)
    "  " + Str(num) + ") "
  EndMacro
  ; ==============================================================================
  ;                         PUBLIC PROCEDURES DECLARATION                         
  ; ==============================================================================
  Declare.s ButlerVersion()
  Declare   PrintButlerVersionFramed()
  Declare   EnlistStatusError(error$)
  Declare   StatusErrorReport()
  Declare   PrintTasksList()
  Declare.s ButlerStatus() ; <- Currently doesn't do anything useful!  
  Declare   PrintHelp()
  Declare   Abort(errMsg.s)
EndDeclareModule

Module msg
  
  
  ; ******************************************************************************
  ; *                                                                            *
  ; *                      BUTLER TEXT MESSAGES PROCEDURES                       *
  ; *                                                                            *
  ;{******************************************************************************
  ; Procedures to handle Butler-specific text messages, either returned as strings
  ; or printed to the console.
  ; ******************************************************************************
  ; *                               Butler Version                               *
  ; ******************************************************************************
  Procedure.s ButlerVersion()
    ProcedureReturn "Butler v" + DS::Butler\Version$ + " (" + DS::#ButlerBitness$ + " bits)"
  EndProcedure
  ; ******************************************************************************
  ; *                        Print Butler Version Framed                         *
  ; ******************************************************************************
  Procedure PrintButlerVersionFramed()
    Print( txt::FrameText( ButlerVersion() ))
  EndProcedure
  ; ******************************************************************************
  ; *                             Print Tasks Lists                              *
  ; ******************************************************************************
  ; Print the list of queued processing tasks
  Procedure PrintTasksList()
    ; NOTE: Still under development (more processing options to come)
    cnt = 0
    ; ··············································································
    ; cntStr() Macro => "  1. ", "  2. ", etc.
    ; ===> Opening Text: ===========================================================
    tmp$ = "Requested tasks"
    If ( DS::UserOpts & DS::#opt_Verbose )
      tmp$ + " (verbosity mode)"
    EndIf
    PrintN(tmp$ + ":")
    ; ===> Build Task? =============================================================
    If ( DS::UserOpts & DS::#opt_BuildAll ) Or ( DS::UserOpts & DS::#opt_BuildFolder )
      cnt +1
      tmp$ = cntStr(cnt)
      If ( DS::UserOpts & DS::#opt_BuildAll )
        tmp$ + "Build whole project."
      Else
        tmp$ + "Build current folder"
        If ( DS::UserOpts & DS::#opt_Recursive )
          tmp$ + " (recursively)"
        EndIf
        tmp$ + "."
      EndIf
      PrintN( tmp$ )
    EndIf
    
  EndProcedure
  ; ******************************************************************************
  ; *                               Butler Status                                *
  ; ******************************************************************************
  ; Currently just a placeholder, doesn't do anything useful at all.
  ; TODO: ButlerStatus() --- finish implementing!
  Procedure.s ButlerStatus()
    OUT$ = LSet(">>> Butler Status: ", 80, ">") + #EOL$
    
    OUT$ + LSet("", 80, "<") + #EOL$
    
    ProcedureReturn OUT$
  EndProcedure
  
  ; ******************************************************************************
  ; *                            Enlist Status Error                             *
  ; ******************************************************************************
  ; Add a status error string to the numbered list of status errors that will be
  ; shown in the final StatusErrorReport()
  Procedure EnlistStatusError(error$)
    
    Shared StatusErrorReport$
    Static cnt = 0 ; Counter for numbered list
    
    ; cntStr(number) Macro => Used to format ordered list strings.
    cnt +1
    StatusErrorReport$ + cntStr(cnt) + error$ + txt::#EOL$
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                            Status Error Report                             *
  ; ******************************************************************************
  Procedure StatusErrorReport()
    ; TODO StatusErrorReport():
    ; -- Output To STDERR instead
    ; -- Add line before list:
    ;    -- if opStatusRequired:
    ;       "Butler can't carry out the requested tasks because..."
    ;    -- else if just --status opt:
    ;       "Butler is not in operative state because..."
    Shared StatusErrorReport$
    
    Print(StatusErrorReport$ + txt::#EOL$)
    
    StatusErrorReport$ = #Null$ ; Dispose and free mem (no longer needed)
    
  EndProcedure
  
  
  ; ******************************************************************************
  ; *                                 Print Help                                 *
  ; ******************************************************************************
  Procedure PrintHelp()
    PrintN( PeekS( ?HelpText, -1, #PB_UTF8 ) )
  EndProcedure
  
  ; ******************************************************************************
  ; *                           Print Error and Abort                            *
  ; ******************************************************************************
  ; FIXME: Abort() proc -- Remove all calls and delete!
  Procedure Abort(errMsg.s)
    ConsoleError("ERROR: "+ errMsg)
    ConsoleError("Aborting all operations ...")
    End 1 ; Exit with Exit Code set to Error (generic)
  EndProcedure
  
  ;}******************************************************************************
  ; *                                                                            *
  ; *                               EMBEDDED TEXT                                *
  ; *                                                                            *
  ; ******************************************************************************
  ; For easier maintainance, long chuncks of text are kept in external files that
  ; are binary-included in labeled DataSections.
  ; NOTE: The binary-included text files must be:
  ; 1) In UTF-8 encoding without BOM.
  ; 2) Use native OS's EOL (CRLF on Win, LF on Linux and Mac) and let Git handle
  ;    line endings conversion through ".gitattributes" settings -- ie:
  ;
  ;       *.txt text
  ;
  ;    For more info read:
  ;       http://adaptivepatchwork.com/2012/03/01/mind-the-end-of-your-line/
  ; 3) Followed by Unicode Null-Termination chars ($00 + $00).
  
  ; TODO: Just check that the .gitattributes settings do apply also to ZIPped
  ;       copies of the repo downloaded from GitHub via the download button.
  ;       They should, but it's worth testing. See:
  ;       https://stackoverflow.com/questions/17347611/downloading-a-zip-from-github-removes-newlines-from-text-files
  
  
  #Null_Termination = $00 + $00
  
  
  DataSection
    
    HelpText:
    IncludeBinary "butler-inc_help-text.txt"
    Data.s   #Null_Termination
    
  EndDataSection 
  
  
  
  
EndModule