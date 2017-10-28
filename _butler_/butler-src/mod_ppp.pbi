; ··············································································
; ··············································································
; ························· PP Pandoc Module ( PPP:: ) ·························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "mod_ppp.pbi" | PureBASIC 5.61

; A module to convert files via PP and pandoc external tools.

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
;}==============================================================================

; PPP::Convert(*PPPOut.String, argsPP.s, argsPandoc.s)
; -- *PPPOut.String : pointer to the str in main code that will hold results
; -- argsPP : PP's cli args
; -- argsPandoc : Pandoc's cli args

; TODO: Decide how and where to store PP/Pandoc Warning/Errors
; TODO: Decide how to implement failure to invoke PP or Pandoc

; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule PPP
  ; ==============================================================================
  ;                            PUBLIC VARS & CONSTANTS                            
  ; ==============================================================================
  Define PPRunErr
  Define PPExCode
  Define PPErr$
  
  Define PandocRunErr
  Define PandocExCode
  Define PandocErr$
  
  Define DocHTML$ ; The PP>Pandoc converted HTML doc
  
  ; ==============================================================================
  ;                               PUBLIC PROCEDURES                               
  ; ==============================================================================
  Declare   Convert(argsPP$, argsPandoc$)
  Declare.s GetAppVersion(app$, params$)
  Declare.s GetPPVersion()
  Declare.s GetPandocVersion()
EndDeclareModule

Module PPP
  ; ==============================================================================
  ;                            PRIVATE VARS & CONSTANTS                           
  ; ==============================================================================
  #Success = 1
  #Failure = 0
  ; ------------------------------------------------------------------------------
  ;                            Cross-Platform Settings                            
  ; ------------------------------------------------------------------------------
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
  ; ******************************************************************************
  ; *                               PPP::Convert()                               *
  ; ******************************************************************************
  Procedure Convert(argsPP$, argsPandoc$)    
    ;     PrintN(">>>>>>>>>> PPP::Convert() >>>>>>>>>>")  ; DELME
    
    Shared PPRunErr,     PPExCode,     PPErr$
    Shared PandocRunErr, PandocExCode, PandocErr$
    
    Shared DocHTML$
    
    ; TODO: Move these to PPP::Reset() proc
    PPRunErr = #False
    PandocRunErr = #False
    PPErr$ = ""
    PandocErr$ = ""
    DocHTML$ = ""
    
    ; ------------------------------------------------------------------------------
    ;                                   Invoke PP                                   
    ; ------------------------------------------------------------------------------
    PP     = RunProgram("pp",     argsPP$,     "", #PB_Program_Open | #PB_Program_Read | #PB_Program_Error | #PB_Program_UTF8)
    Pandoc = RunProgram("pandoc", argsPandoc$, "", #PB_Program_Open | #PB_Program_Read | #PB_Program_Error | #PB_Program_UTF8 | #PB_Program_Write)
    ;     PrintN("argsPP$: "     + argsPP$)     ; DBG PP Args
    ;     PrintN("argsPandoc$: " + argsPandoc$) ; DBG Pandoc Args
    If Not PP Or Not Pandoc
      ; ------------------------------------------------------------------------------
      ;                               Somethig Wrong...                               
      ; ------------------------------------------------------------------------------
      If Not PP
        PrintN("PPP::Convert(): PP couldn't be started...") ; DELME
        PPRunErr = #True
      EndIf
      If Not Pandoc
        PrintN("PPP::Convert(): Pandoc couldn't be started...") ; DELME
        PandocRunErr = #True
      EndIf
      ProcedureReturn #Failure
    EndIf 
    
    
    While ProgramRunning(PP) Or ProgramRunning(Pandoc)
      
      ; ------------------------------------------------------------------------------
      ; Redirect PP's STDOUT to Pandoc's STDIN
      ; ------------------------------------------------------------------------------
      If AvailableProgramOutput(PP)
        WriteProgramStringN(Pandoc, ReadProgramString(PP))
        ; NOTE: The line above will add an EOL according to OS defaults, and pandoc
        ;       will handle it accordingly.
      EndIf
      ; ------------------------------------------------------------------------------
      ; Capture Pandoc's STDOUT
      ; ------------------------------------------------------------------------------
      If AvailableProgramOutput(Pandoc)
        DocHTML$ + ReadProgramString(Pandoc) + #EOL$
        ; NOTE: HTML docs must have native End-of-Line sequence/char. Git will handle
        ;       proper conversion at checkout via .gitattributes settings.
      EndIf
      ; ------------------------------------------------------------------------------
      ; Capture PP's STDERR
      ; ------------------------------------------------------------------------------
      err$ = ReadProgramError(PP)
      If err$
        If PPErr$ <> "" ; Add Line-Feed if not empty...
          PPErr$ + #LF$
        EndIf
        PPErr$ + err$
      EndIf
      ; ------------------------------------------------------------------------------
      ; Capture Pandoc's STDERR
      ; ------------------------------------------------------------------------------
      err$ = ReadProgramError(Pandoc)
      If err$
        If PandocErr$ <> "" ; Add Line-Feed if not empty...
          PandocErr$ + #LF$
        EndIf
        PandocErr$ + err$
      EndIf
      ; ------------------------------------------------------------------------------
      ; Check if PP Ended
      ; ------------------------------------------------------------------------------
      If Not ProgramRunning(PP)
        WriteProgramData(Pandoc, #PB_Program_Eof, 0) ; Send EOF notice to Pandoc
      EndIf
      
    Wend
    
    PPExCode     = ProgramExitCode(PP)
    PandocExCode = ProgramExitCode(Pandoc)
    ; TODO: Implement handling PP/Pandoc Exit Code with Error or Warning!
    ; TODO: Remove STDOUT debugging
    ; TODO: Implement clean console output about data being processed
    
    CloseProgram(Pandoc) ; Close the connection to the program
    CloseProgram(PP)     ; Close the connection to the program
    
    ;     PrintN("<<<<<<<<<< PPP::Convert() <<<<<<<<<<") ; DELME
    
    
    If PPExCode Or PandocExCode Or      ; <= Errors
       PandocErr$ <> "" Or PPErr$ <> "" ; <= Warnings
      ProcedureReturn #Failure
    Else
      ProcedureReturn #Success
    EndIf
    
  EndProcedure
  ; ******************************************************************************
  ; *                      Query External App Version Info                       *
  ; ******************************************************************************
  Procedure.s GetAppVersion(app$, params$)
    
    TargetApp = RunProgram(app$, params$, "", #PB_Program_Hide | #PB_Program_Open |
                                              #PB_Program_Read | #PB_Program_UTF8 )
    If Not TargetApp
      ; TODO: GetAppVersion() -- implement handling RunProgram Error!
      ProcedureReturn
    EndIf
    ; ------------------------------------------------------------------------------
    ;                              Version/SemVer RegEx                             
    ; ------------------------------------------------------------------------------
    ; This RegEx is flexible: it captures both SemVer 2.0 strings and the more common
    ; digits-only version strings (eg: 1.1.1.1).
    Rex$ = "(?is)"+                              ; (set mode: case insensitive + single line)
           "^.*?v?("+                            ; [...anything...] "v" (optional)
           "(?:0|[1-9]\d*)"+                     ; Num-ID (mandatory) = MAJ
           "(?:\.(?:0|[1-9]\d*)){1,3}"+          ; .Num-ID (1 mandatory + 2 optional) = .MIN [.PATCH .BUILD]
           "(?:-[\da-z\-]+(?:\.[\da-z\-]+)*)?"+  ; -PRERELEASE (optional)     = SemVer specific
           "(?:\+[\da-z\-]+(?:\.[\da-z\-]+)*)?"+ ; +BUILD_METADATA (optional) = SemVer specific
           ")"
    If Not CreateRegularExpression(0, Rex$)
      ; FIXME: Butler Internal Error (use custom msg:: proc)
      ConsoleError("BUTLER INTERNAL ERROR -- PPP::GetAppVersion() RegEx creation failed!") 
      End 1
    EndIf
    ; ------------------------------------------------------------------------------
    ;                         Get Raw Info from External App                        
    ; ------------------------------------------------------------------------------
    While ProgramRunning(TargetApp)
      If AvailableProgramOutput(TargetApp)
        RawInfo$ + ReadProgramString(TargetApp) + #LF$
      EndIf
    Wend
    CloseProgram(TargetApp)
    ; ------------------------------------------------------------------------------
    ;                             Extract Version String                            
    ; ------------------------------------------------------------------------------
    If MatchRegularExpression(0, RawInfo$)
      If ExamineRegularExpression(0, RawInfo$)
        NextRegularExpressionMatch(0)
        VerStr$ = RegularExpressionGroup(0, 1)
      EndIf
    EndIf
    FreeRegularExpression(0)
    
    ProcedureReturn VerStr$
    
  EndProcedure
  ; ******************************************************************************
  ; *                               Get PP Version                               *
  ; ******************************************************************************
  Procedure.s GetPPVersion()
    ProcedureReturn GetAppVersion("pp", "-v")
  EndProcedure
  ; ******************************************************************************
  ; *                             Get Pandoc Version                             *
  ; ******************************************************************************
  Procedure.s GetPandocVersion()
    ProcedureReturn GetAppVersion("pandoc", "--version")
  EndProcedure
  
EndModule


