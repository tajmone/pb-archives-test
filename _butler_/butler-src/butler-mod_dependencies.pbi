; ··············································································
; ··············································································
; ························· Butler Dependencies Module ·························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_dependencies.pbi" | PureBASIC 5.61
;
; modules dependencies:
; -- DS::


; A module for checking that dependencies satisfy specific version ranges.
;
; Currently Supports:
; -- Numerical identifiers (only)
; -- Versions with two or more segments (ie: 1.0; 1.0.0; 1.0.0.0; etc.)
; -- Constraint operators:
;    -- "="  --- Strict:        Lock all segements (default)
;    -- "^"  --- Caret:         Lock MAJOR version
;    -- "~"  --- Tilde:         Lock MAJOR and MINOR version
;    -- "~>" --- Twiddle-Wakka: Lock all segements except rightmost

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
DeclareModule deps
  ; ==============================================================================
  ;                         PUBLIC PROCEDURES DECLARATION                         
  ; ==============================================================================
  Declare.s GetAppVersion(app$, params$)
  Declare   SatisfyVersion(Constraint$, Ver$)
  Declare   FreeMem()
  
EndDeclareModule

Module deps
  ; ==============================================================================
  ;                         PRIVATE PROCEDURES DECLARATION                        
  ; ==============================================================================
  Declare VersionToList(VerStr$, List VersionL.i())
  Declare BuildLocks(ConstrType.i, TotSegments.i, List LocksL())
  Declare BalanceSegments(ConstrType.i, List ConstraintL(), List VersionL(), List LocksL())
  ; ------------------------------------------------------------------------------
  ;                                   Constants                                   
  ; ------------------------------------------------------------------------------
  ; RETURNED VALUES:
  Enumeration -1
    #Version_Invalid ; Unreckognized/malformed Constraint or Version string
    #Version_Failed  ; Version does not satisfy Constraint
    #Version_Passed  ; Version satisfies Constraint
  EndEnumeration
  
  ; CONSTRAINT TYPES
  Enumeration
    #Strict         ; = /"" --- Lock all segements (default)
    #Caret          ; ^     --- Lock MAJ
    #Tilde          ; ~     --- Lock MAJ and MIN
    #TwiddleWakka   ; ~>    --- Lock all segements except rightmost
  EndEnumeration
  
  ; ==============================================================================
  ;-                           RegEx Data & Definitions                           
  ;{==============================================================================  
  ; ------------------------------------------------------------------------------
  ;                           SHARED REGEX ENUMERATIONS                           
  ; ------------------------------------------------------------------------------
  ; RegExs Ids Constants Enumerations must carry on from where previous modules
  ; have left, otherwise they will overwrite existing RegExs (object IDs are not
  ; isolated by modules, they are global!)
  ; ------------------------------------------------------------------------------
  Enumeration DS::RegExsIDs ; <= Enum ID defined in DS:: module
    #RE_GetVerStr           ; Extract Version/SemVer Substring
    #RE_VerValidate         ; Validate Version/Constraint Strings
    #RE_VerParse1           ; Parse Version/Constraint Strings (1st pass)
    #RE_VerParse2           ; Parse Version/Constraint Strings (2nd pass)
  EndEnumeration
  ; Create References for Freeing RegEx in FreeMem():
  #RegExs_First = #RE_GetVerStr
  #RegExs_Last  = #PB_Compiler_EnumerationValue -1
  ; ------------------------------------------------------------------------------
  ;-                            RegEx Building-Blocks                             
  ; ------------------------------------------------------------------------------
  ; Reusable RegEx string-constants ... 
  ; ··············································································
  ; ** Numeric Identifier **
  #RE_NumID$ = "0|[1-9]\d*"
  ;    -- One or more digits, no leading zeros.
  ; ··············································································
  ; ** Alphanumeric Identifier ** [ !!! CURRENTLY UNUSED !!! ]
  #RE_AlphanID$  = "\d*[-a-z][-\da-z]*"
  ;   Allowed chars: digits, Ascii letters, hyphen.
  ;    -- A letter or hyphen followed by zero or more valid chars,
  ;    -- One or more digits followed by at least one letter or hyphen (not digits only).
  ; ··············································································
  ; ** Any Identifier **
  #RE_AnyID$  = "[\da-z\-]+"
  ;   Captures both Numeric- and Alphanumeric-Identifiers. Used for loose extraction 
  ;   or evaluation of SemVer PRERELEASE and BUILD_METADATA segments.
  ;   Allowed chars: digits, Ascii letters, hyphen.
  ;   NOTE: It will also capture malformed segments (eg: "01") because it's loose.
  DataSection
    REGEX_PATTERNS:
    ; ------------------------------------------------------------------------------
    ; RegEx: Extract Version/SemVer Substring from String
    ; ------------------------------------------------------------------------------
    ; #RE_GetVerStr --- This RegEx is flexible: it captures both SemVer 2.0 strings
    ;                   and the more commondigits-only version strings (eg: 1.1.1.1).
    Data.s "(?is)"+                                              ; (set mode: case insensitive + single line)
           "^.*?v?("+                                            ; [...anything...] "v" (optional)
           "(?:" + #RE_NumID$ + ")"+                             ; Num-ID (mandatory) = MAJ
           "(?:\.(?:" + #RE_NumID$ + ")){1,3}"+                  ; .Num-ID (1 mandatory + 2 optional) = .MIN [.PATCH .BUILD]
           "(?:-"  + #RE_AnyID$ + "(?:\." + #RE_AnyID$ + ")*)?"+ ; -PRERELEASE (optional)     = SemVer specific
           "(?:\+" + #RE_AnyID$ + "(?:\." + #RE_AnyID$ + ")*)?"+ ; +BUILD_METADATA (optional) = SemVer specific
           ")"
    ; ------------------------------------------------------------------------------
    ; RegEx: Validate Version/Constraint Strings
    ; ------------------------------------------------------------------------------
    ; #RE_VerValidate --- Verify that a string is a valid Version or Constraint:
    ; -- Constraint operator (only found in Constraint strings)
    ; -- MAJOR version
    ; -- One or more dot-separated segments (numerical only)
    Data.s "^(?:\^|~>|~|=)? *(?:" + #RE_NumID$ + ")(?:\.(?:" + #RE_NumID$ + "))+$"
    ; ------------------------------------------------------------------------------
    ; RegEx: Parse Version Segments & Constraint Operator
    ; ------------------------------------------------------------------------------
    ; Version and Constraint strings are parsed using 2-pass RegEx:
    ; 1) #RE_VerParse1
    Data.s "(\^|~|=|~>)? *(" + #RE_NumID$ + ")(.*)"
    ;    First Pass extracts:
    ;    -- ($1) Constraint operator (only found in Constraint strings)
    ;    -- ($2) MAJOR version
    ;    -- ($3) Remainder of version string
    ; 2) #RE_VerParse2
    Data.s "\.(" + #RE_NumID$ + ")"
    ;    Second Pass extracts:
    ;    -- ($1) All segments (numeric identifiers) from remainder of #RE_VerParse1
  EndDataSection
  ;- Create RegExs ---------------------------------------------------------------
  For i=#RegExs_First To #RegExs_Last ; <= IDs-range won't override RegExs defined elsewhere!
    Read.s RE_Pattern$
    If Not CreateRegularExpression(i, RE_Pattern$)
      ; TODO: CreateRegularExpression() -- Failed
    EndIf
  Next
  ;}******************************************************************************
  ; *                                                                            *
  ; *                             PUBLIC PROCEDURES                              *
  ; *                                                                            *
  ;{******************************************************************************
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
    If MatchRegularExpression(#RE_GetVerStr, RawInfo$)
      If ExamineRegularExpression(#RE_GetVerStr, RawInfo$)
        NextRegularExpressionMatch(#RE_GetVerStr)
        VerStr$ = RegularExpressionGroup(#RE_GetVerStr, 1)
      EndIf
    EndIf
    ProcedureReturn VerStr$
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                              Satisfy Version                               *
  ; ******************************************************************************
  ; Compare Version to Constraint and return:
  ; -- #True  if satisfied,
  ; -- #False if Version is outside Constraint range,
  ; -- '-1'   if either Version- or Constraint-String is not valid/supported. 
  ; ------------------------------------------------------------------------------
  Procedure SatisfyVersion(Constraint$, Ver$)
    
    ; Validate Ver/Constr strings:
    If MatchRegularExpression(#RE_VerValidate, Ver$) = #False Or
       MatchRegularExpression(#RE_VerValidate, Constraint$) = #False
      ProcedureReturn #Version_Invalid
    EndIf
    ; ==============================================================================
    ;                    Convert Version Strings to Numeric Lists                   
    ; ==============================================================================
    NewList ConstraintL()
    NewList VersionL()
    NewList LocksL() ; bool indicating if a segment is locked (constrained)
    
    VersionToList(Ver$, VersionL())
    ConstrType = VersionToList(Constraint$, ConstraintL())
    BuildLocks(ConstrType, ListSize(ConstraintL()), LocksL())
    ; ------------------------------------------------------------------------------
    ; NOTE: Locks are built BEFORE segments-balancing; and therefore apply to the
    ;       Constr.Str passed as parameter. Eg: "~>3.2.1" will lock "3.2" only, even
    ;       if comparison with a Vers.Str "1.2.3.4" (one exta segm.) will cause the
    ;       final Constraint used for calculation to be "~>3.2.1.0" after balancing
    ;       --- but the original locks won't be affected by balancing.
    ;       We expect Constraints to be well-formed and devised with knowledge of the
    ;       segments expected for the dependency at hand. We could have calculated
    ;       locks after balancing, but then the behaviour of the "~>" operator
    ;       would have been confusing and lead to undesired results. It's safer to
    ;       assume to that constraints are meant to be taken literally, even when
    ;       obvious segments shortcuts are taken (eg: "1.2" instead of "1.2.0.0").
    ;       ------------------------------------------------------------------------
    BalanceSegments(ConstrType, ConstraintL(), VersionL(), LocksL())    
    ; ==============================================================================
    ;                                Compare Versions                               
    ; ==============================================================================
    ; Comparison segment by segment, with lock checks.
    FirstElement(VersionL())
    FirstElement(LocksL())
    
    ForEach ConstraintL()
      ConstrSegm  = ConstraintL()
      VersionSegm = VersionL()
      If VersionSegm <> ConstrSegm
        If LocksL()
          ; Constrained segments can't differ!
          ProcedureReturn #Version_Failed
        ElseIf VersionSegm > ConstrSegm
          ; Unconstrained segments can be greater!
          Greater = #True ; Ver is > Constraint
        ElseIf Not Greater
          ; Unconstrained segments can be lower only if a previous one was greater!
          ; Ver is < Constraint
          ProcedureReturn #Version_Failed
        EndIf
      EndIf
      NextElement(VersionL())
      NextElement(LocksL())
    Next
    
    ProcedureReturn #Version_Passed
    
  EndProcedure
  
  ; ******************************************************************************
  ; *                                Free Memory                                 *
  ; ******************************************************************************
  ; Since dependencies checks are usually carried out only when an application
  ; starts up, this procedure allows freeing up some memory after all version
  ; checks are done with.
  Procedure FreeMem()
    
    ; Free Regular Expressions and release their memory
    For i=#RegExs_First To #RegExs_Last
      FreeRegularExpression(i)
    Next
    
  EndProcedure
  ;}******************************************************************************
  ; *                                                                            *
  ; *                             PRIVATE PROCEDURES                             *
  ; *                                                                            *
  ; ******************************************************************************
  Procedure VersionToList(VerStr$, List VersionL.i())
    ; Convert a version string to a List and return the constraint operator type.
    ; Operator type should be disregarded for non Constraint Strings.
    ; ------------------------------------------------------------------------------
    ;                                 1st Pass Parse                                
    ; ------------------------------------------------------------------------------
    If ExamineRegularExpression(#RE_VerParse1, VerStr$)
      If NextRegularExpressionMatch(#RE_VerParse1)
        ConstrOp$ = RegularExpressionGroup(#RE_VerParse1, 1)
        MAJ$ = RegularExpressionGroup(#RE_VerParse1, 2)
        Residue$ = RegularExpressionGroup(#RE_VerParse1, 3)
      Else
        ; ------------------------
        ; Handle RegEx Failures...                           
        ; ------------------------
        ; No match found...
        Debug "NO MATCH FOUND"
      EndIf
    EndIf
    
    AddElement(VersionL())
    VersionL() = Val(MAJ$)
    ; ------------------------------------------------------------------------------
    ;                           Establish Constraint Type                           
    ; ------------------------------------------------------------------------------
    Select ConstrOp$
      Case "^"
        ConstrType = #Caret
      Case "~"
        ConstrType = #Tilde
      Case "~>"
        ConstrType = #TwiddleWakka
      Case "=", #Empty$
        ConstrType = #Strict
    EndSelect
    ; ------------------------------------------------------------------------------
    ;                                 2nd Pass Parse                                
    ; ------------------------------------------------------------------------------
    If ExamineRegularExpression(#RE_VerParse2, Residue$)
      While NextRegularExpressionMatch(#RE_VerParse2)
        
        MATCH$ = RegularExpressionGroup(#RE_VerParse2, 1)        
        If Not AddElement(VersionL())
          MessageRequester("ERROR", "AddElement(VersionL()) failed")
        Else
          VersionL() = Val(MATCH$)
        EndIf
        
      Wend
    EndIf
    
    ProcedureReturn ConstrType
  EndProcedure
  
  Procedure BuildLocks(ConstrType.i, TotSegments.i, List LocksL())
    ; Build a boolean list of locks for each segment.
    ClearList(LocksL())
    
    ; Establish LocksRange (ie: how many segments should be constrained)
    Select ConstrType
      Case #Caret
        LocksRange = 1
      Case #Tilde
        LocksRange = 2
      Case #TwiddleWakka
        LocksRange = TotSegments-1
      Default
        ; #Strict
        LocksRange = TotSegments
    EndSelect
    
    For i= 1 To TotSegments
      AddElement(LocksL())
      If i <= LocksRange
        LocksL() = #True  ; Segment locked
      Else
        LocksL() = #False ; Segment unconstrained
      EndIf      
    Next 
    
  EndProcedure
  
  Procedure BalanceSegments(ConstrType.i, List ConstraintL(), List VersionL(), List LocksL())
    
    ConstrSize = ListSize(ConstraintL())
    VersionSize = ListSize(VersionL())
    
    If ConstrSize = VersionSize
      ; ------------------------------------------------------------------------------
      ;                             Both Have Same Length                             
      ; ------------------------------------------------------------------------------
      ; Do nothing...
      ProcedureReturn    
    ElseIf ConstrSize < VersionSize
      ; ------------------------------------------------------------------------------
      ;                             Constraint is Shorter                             
      ; ------------------------------------------------------------------------------
      ; Determine how to handle locks for added Constraint segments
      If ConstrType = #Strict
        ; Strict constraint imposed locks on all segments
        LocksFiller = #True
      Else
        ; In all other cases, added segments are unconstrained
        LocksFiller = #False
      EndIf
      
      LastElement(ConstraintL())
      LastElement(LocksL())
      
      MissingSegs = VersionSize - ConstrSize
      For i=1 To MissingSegs
        AddElement(ConstraintL())
        ConstraintL() = 0
        AddElement(LocksL())
        LocksL() = LocksFiller
      Next
    Else
      ; ------------------------------------------------------------------------------
      ;                               Version is Shorter                              
      ; ------------------------------------------------------------------------------
      LastElement(VersionL())
      
      MissingSegs = ConstrSize - VersionSize
      For i=1 To MissingSegs
        AddElement(VersionL())
        VersionL() = 0
      Next
    EndIf
    
  EndProcedure
  
EndModule

