; ··············································································
; ··············································································
; ························ Butler's Data Storage Module ························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_data-store.pbi" | PureBASIC 5.61

; Stores commonly shared project and environment Data.

; modules dependencies: none.

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
DeclareModule DS
  ; ==============================================================================
  ;                        CROSS-MODULE REGEX ENUMERATIONS                        
  ; ==============================================================================
  ; (RegExs IDs are "global" and module independent)
  ; Declare a common RegEx Enumeration Identifier to keep track of the RegExs ID
  ; across modules, otherwise Enums will start over from 0 and overwrite existing
  ; RegExs! Other modules' Enums will take on from here by:
  ;
  ;     Enumeration DS::RegExsIDs
  ;
  ; This Enum block it's empty because here we only need to set the Enum Id.
  ; ------------------------------------------------------------------------------
  ; NOTE: This Enumeration has to be public! The rest of the modules' RegEx Enums
  ;       don't have to, they can be private to their module...
  ; ------------------------------------------------------------------------------
  Enumeration RegExsIDs
  EndEnumeration
  ; ==============================================================================
  ;                            PUBLIC VARS & CONSTANTS                            
  ; ==============================================================================
  Verbose = #False ; Shortcut for "( DS::userOpts & DS::#opt_Verbose )"
  
  ; ------------------------------------------------------------------------------
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
    #SERR_CantOpen_Ini_File
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
EndDeclareModule

Module DS
  
EndModule