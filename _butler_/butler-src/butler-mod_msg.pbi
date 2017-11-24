﻿; ··············································································
; ··············································································
; ······················ Butler Messages Module ( msg:: ) ······················
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_txt.pbi" | PureBASIC 5.61

; Text formatting helper functions

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================


; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule msg
  #EOL$ = txt::#EOL$ ; <= Set OS-appropriate #EOL$, as defined in module txt
  
  ; cntStr(number) Macro => Used to format ordered list strings:
  ; "  1. "
  ; "  2. "
  Macro cntStr(num)
    "  " + Str(num) + ") "
  EndMacro
  
  Declare   PrintTasksList()
  Declare.s ButlerStatus()
  Declare.s ListStatusErrors()
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
    If ( ini::UserOpts & ini::#opt_Verbose )
      tmp$ + " (verbosity mode)"
    EndIf
    PrintN(tmp$ + ":")
    ; ===> Build Task? =============================================================
    If ( ini::UserOpts & ini::#opt_BuildAll ) Or ( ini::UserOpts & ini::#opt_BuildFolder )
      cnt +1
      tmp$ = cntStr(cnt)
      If ( ini::UserOpts & ini::#opt_BuildAll )
        tmp$ + "Build whole project."
      Else
        tmp$ + "Build current folder"
        If ( ini::UserOpts & ini::#opt_Recursive )
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
  ; TODO: ButlerStatus() --- finish implementing!
  Procedure.s ButlerStatus()
    OUT$ = LSet(">>> Butler Status: ", 80, ">") + #EOL$
    
    OUT$ + LSet("", 80, "<") + #EOL$
    
    ProcedureReturn OUT$
  EndProcedure
  
  ; ******************************************************************************
  ; *                             List Status Errors                             *
  ; ******************************************************************************
  Procedure.s ListStatusErrors()
    
    cnt = 0
    ; ------------------------------------------------------------------------------
    ;                            Windows: Is Bash/Shell?                            
    ; ------------------------------------------------------------------------------
    CompilerIf #PB_Compiler_OS = #PB_OS_Windows
      If ini::StatusErr & ini::#SERR_Win_NotShell
        cnt +1
        tmp$ + cntStr(cnt) + "Butler not invoked from Bash/Shell." + #EOL$
      EndIf
    CompilerEndIf
    ; ------------------------------------------------------------------------------
    ;                              Missing Dependencies                             
    ; ------------------------------------------------------------------------------
    ; ~~~~~ PP Not found ~~~~~
    If ini::StatusErr & ini::#SERR_PP_Not_Found
      cnt +1
      tmp$ + cntStr(cnt) + "PP Not found on system." + #EOL$
    EndIf  
    ; ~~~~~ Pandoc Not found ~~~~~
    If ini::StatusErr & ini::#SERR_Pandoc_Not_Found
      cnt +1
      tmp$ + cntStr(cnt) + "Pandoc Not found on system." + #EOL$
    EndIf  
    ; ~~~~~ Highlight Not found ~~~~~
    If ini::StatusErr & ini::#SERR_Highlight_Not_Found
      cnt +1
      tmp$ + cntStr(cnt) + "Highlight Not found on system." + #EOL$
    EndIf  
    ; ------------------------------------------------------------------------------
    ;                                BUTLER_PATH Set?                               
    ; ------------------------------------------------------------------------------
    If ini::StatusErr & ini::#SERR_Missing_BUTLER_PATH
      cnt +1
      tmp$ + cntStr(cnt) + "Env var BUTLER_PATH not set." + #EOL$
    Else
      ; These status errors should be considered only if BUTLER_PATH is set ...
      ; ------------------------------------------------------------------------------
      ;                           Missing "butler.ini" File?                          
      ; ------------------------------------------------------------------------------
      If ini::StatusErr & ini::#SERR_Missing_Ini_File
        cnt +1
        tmp$ + cntStr(cnt) + ~"Missing \"butler.ini\" file." + #EOL$
      Else
        ; These status errors should be considered only if "butler.ini" was found ...
        ; ==============================================================================
        ;                         Errors In "butler.ini" File...                        
        ; ==============================================================================
        ;                            Butler Version Error...                            
        ; ------------------------------------------------------------------------------
        If ini::StatusErr & ini::#SERR_Mismatched_Butler_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"Butler version error: Required v" + ini::Proj\ButlerVersion$ +
                 " | Found v" + ini::Butler\Version$ + "." + #EOL$
        EndIf
        ; ------------------------------------------------------------------------------
        ;                                  PP Errors...                                 
        ; ------------------------------------------------------------------------------
        ; Mutually-exclusive errors...
        If ini::StatusErr & ini::#SERR_Unspecified_PP_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"\"butler.ini\" file: missing \"PPVersion\"." + #EOL$
        ElseIf ini::StatusErr & ini::#SERR_Mismatched_PP_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"PP version error: Required v" + ini::Proj\PPVersion$ +
                 " | Found v" + ini::Env\PPVersion$ + "." + #EOL$
        EndIf
        ; ------------------------------------------------------------------------------
        ;                                Pandoc Errors...                               
        ; ------------------------------------------------------------------------------
        ; Mutually-exclusive errors...
        If ini::StatusErr & ini::#SERR_Unspecified_Pandoc_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"\"butler.ini\" file: missing \"PandocVersion\"." + #EOL$
        ElseIf ini::StatusErr & ini::#SERR_Mismatched_Pandoc_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"Pandoc version error: Required v" + ini::Proj\PandocVersion$ +
                 " | Found v" + ini::Env\PandocVersion$ + #EOL$
        EndIf
        ; ------------------------------------------------------------------------------
        ;                                Highlight Errors...                               
        ; ------------------------------------------------------------------------------
        ; Mutually-exclusive errors...
        If ini::StatusErr & ini::#SERR_Unspecified_Highlight_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"\"butler.ini\" file: missing \"HighlightVersion\"." + #EOL$
        ElseIf ini::StatusErr & ini::#SERR_Mismatched_Highlight_Version
          cnt +1
          tmp$ + cntStr(cnt) + ~"Highlight version error: Required v" + ini::Proj\HighlightVersion$ +
                 " | Found v" + ini::Env\HighlightVersion$ + #EOL$
        EndIf
        ; ...........
      EndIf
    EndIf
    
    
    ProcedureReturn tmp$
    
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