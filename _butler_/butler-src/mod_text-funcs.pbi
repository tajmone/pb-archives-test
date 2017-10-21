; ··············································································
; ··············································································
; ······················ Text Functions Module ( txt:: ) ·······················
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "mod_text-funcs.pbi" | PureBASIC 5.60

; A module for formatting text strings.

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
DeclareModule txt
  
  Declare.s FixLineEndings(StrToFix$)
  Declare.s FrameText(text$)
   Declare.s QuoteText(text$)
 
  
  ; ==============================================================================
  ;                            Cross-Platform Settings                            
  ; ==============================================================================
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    ; ================================= Windows OS ===============================
    #EOL$ = #CRLF$ ; Line ending is CR+LF sequence.
                  ; NOTE: Bash for Windows can handle correctly CR+LF line ends!
    #EOL_WRONG$ = #LF$
  CompilerElse
    ; ================================ Linux/macOS ===============================
    #EOL$ = #LF$   ; Line ending is LF char.
    #EOL_WRONG$ = #CRLF$
  CompilerEndIf
  
EndDeclareModule

Module txt
  ; ******************************************************************************
  ; *                                                                            *
  ; *                         TEXT FORMATTING PROCEDURES                         *
  ; *                                                                            *
  ; ******************************************************************************
  ; Procedures to handle formatting of text --- eg: wrap, center, etc. 
  ; ******************************************************************************
  ; *                              Fix Line Endings                              *
  ; ******************************************************************************
  ; Fix newline chars (CRLF/LF) according to OS.
  Procedure.s FixLineEndings(StrToFix$)
    FixedStr$ = ReplaceString(StrToFix$, #EOL_WRONG$, #EOL$)
    ProcedureReturn FixedStr$
  EndProcedure
  ; ******************************************************************************
  ; *                                 Frame Text                                 *
  ; ******************************************************************************
  Procedure.s FrameText(text$)
    txtLen = Len(text$)
    lenDiff = 78 - txtLen
    padL = lenDiff/2
    padR = lenDiff/2 + Mod(lenDiff, 2)
    
    borderH$ = LSet("+", 79, "-") + "+"
    
    out$ = borderH$ + #EOL$
    out$ + "|" + Space(padL) + text$ + Space(padR) + "|" + #EOL$
    out$ + borderH$ + #EOL$
    
    ProcedureReturn out$
  EndProcedure
  ; ******************************************************************************
  ; *                                 Quote Text                                 *
  ; ******************************************************************************
  ; Convert string to quoted text by adding " | " at the beginning of each line.
  Procedure.s QuoteText(text$)
    
    text$ = FixLineEndings(text$)
    
    text$ = " | " + ReplaceString(text$, #EOL$, #EOL$ + " | ")
    
    ProcedureReturn text$
    
  EndProcedure
  
EndModule
