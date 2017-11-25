; ··············································································
; ··············································································
; ························ File System Module ( FS:: ) ·························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "mod_fs.pbi" | PureBASIC 5.61

; Some helper procedures and constants for cross-platform handling of paths.
;
; modules dependencies: none.

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
;}==============================================================================

; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule FS
  ; ==============================================================================
  ;                            Cross-Platform Settings                            
  ; ==============================================================================
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    ; ================================== Windows ===================================
    #DIR_SEP$ = "\"
    #DIR_SEP_WRONG$ = "/"
  CompilerElse
    ; ============================== Linux and macOS ===============================
    #DIR_SEP$ = "/"
    #DIR_SEP_WRONG$ = "\"
  CompilerEndIf
  ; ==============================================================================
  ;                               Public Procedures                               
  ; ==============================================================================
  Declare.s SanitizeDirPath(PathStr$)
  Declare.s SanitizeFilePath(PathStr$)
  Declare.s SanitizeFilePath(PathStr$)
EndDeclareModule

Module FS
  
  IncludeFile "mod_fs.pbhgen.pbi" ; <= PBHGEN-X
  
  ; ******************************************************************************
  ; *                          Sanitize Directory Path                           *
  ; ******************************************************************************
  ; Fix path slashes according to OS and ensure string ends with a slash.
  Procedure.s SanitizeDirPath(PathStr$)
    
    ; First, normalize path separators...
    ReplaceString(PathStr$, #DIR_SEP_WRONG$, #DIR_SEP$, #PB_String_InPlace)
    
    ; Now make sure the string ends with a path separator...
    If Right(PathStr$, 1) <> #DIR_SEP$
      PathStr$ + #DIR_SEP$
    EndIf
    
    ProcedureReturn PathStr$
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                             Sanitize File Path                             *
  ; ******************************************************************************
  ; Fix path slashes according to OS.
  Procedure.s SanitizeFilePath(PathStr$)
    
    ; Normalize path separators...
    ReplaceString(PathStr$, #DIR_SEP_WRONG$, #DIR_SEP$, #PB_String_InPlace)   
    
    ProcedureReturn PathStr$
    
  EndProcedure
  
EndModule