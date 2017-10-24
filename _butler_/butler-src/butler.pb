﻿; ··············································································
; ··············································································
; ··································· BUTLER ···································
; ··············································································
; ······················· PP-Pandoc MD to HTML Toolchain ·······················
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler.pb" | PureBASIC 5.61
#MAJOR = 0 : #MINOR = 1 : #PATCH = 1 ; v0.1.1 ( 2017/10/22 | Alpha Preview )

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================

IncludeFile "butler.pbhgen.pbi"    ; <= PBHGEN-X
IncludeFile "mod_fs.pbi"           ; Module "FS"    > File System helpers
IncludeFile "mod_ppp.pbi"          ; Module "PPP"   > PP / Pandoc interfacing
IncludeFile "butler-mod_ini.pbi"   ; Module "ini"   > Project settings
IncludeFile "mod_text-funcs.pbi"   ; Module "txt"   > Text Formatting Utilities
IncludeFile "butler-mod_msg.pbi"   ; Module "msg"   > Butler messages (STDOUT/STDERR)
IncludeFile "butler-mod_build.pbi" ; Module "build" > Butler's build engine




; OPTIMIZATION NOTES: Try to keep first tasks first in order to optimize at best.
;     If a definition or an include block is not needed, post-pone it.
;     Allow the code to slim down and skip what is not required, the toolchain
;     must be optimized to every line of code possibile!

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;                              CURRENTLY WORKING ON                             
;{//////////////////////////////////////////////////////////////////////////////

; Moving cli args parsing to ini:: module!

; MODULES :: Moving stuff into modules so the code is more manageable...
;  -- PPP::Convert() now handles PP/Pandoc conversion (unfinished)

; DONE: Implement the following ignore criteria:
;       -- BUILD:  ignore " _* " folders       (start with underscore) [ DONE! ]
;       -- DEPLOY: ingore " *_ " files/folders (end with underscore)
;       This would allow a simple way to control files and folders.

; TODO: RegEx --- avoid creating and destroying RegEx that are used more than once!
;                 Just define them once where needed.
;}




; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                   INITIALIZE                                  
;{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If Not OpenConsole("Butler")
  msg::Abort("Couldn't open console")
EndIf

ini::Butler\Version$ = Str(#MAJOR) +"."+ Str(#MINOR) +"."+ Str(#PATCH)

; Initialize Butler for current project:
operativeStatus = ini::Init() ; <= operativeStatus indicates if Butler is all set
                              ;    to carry out project processing operations.

ConsoleError("ini::Butler\Path$  = "+ ini::Butler\Path$)    ; DELME Debugging
ConsoleError("ini::Proj\Root$    = "+ ini::Proj\Root$)      ; DELME Debugging


invocationDir$ = GetCurrentDirectory()


; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;                               DEBUGGING INFO...                               
; //////////////////////////////////////////////////////////////////////////////
; DELME: Temporary stuff, remove from final release!
If #False ; Dont' show. (might keep the code for verbose/debug option)
  PrintN(~"invocationDir$:\n   "+ invocationDir$)     ; DBG invocationDir$
  PrintN(~"ini::Butler\\Path$:\n   "+ ini::Butler\Path$)             ; DBG butlerDir$
  PrintN(~"ini::Proj\\Root$:\n   "+ ini::Proj\Root$)                 ; DBG Proj\Root$
EndIf

;} <<< END: INITIALIZE <<<

; ==============================================================================
;-                               EVALUATE OPTIONS                               
; ==============================================================================

; Some Debugging:
ConsoleError(" --- operativeStatus: "+ Str(operativeStatus) ) ; DELME Debug operativeStatus
TESTopStatusRequired = Bool( ini::UserOpts & ini::#opt_opStatusReq )
ConsoleError(" --- opStatusRequire: "+ Str(TESTopStatusRequired)) ; DELME Debug opStatusRequire

; ------------------------------------------------------------------------------
;                            Print Butler Info Header                           
; ------------------------------------------------------------------------------
; Print Butler's Framed Header, only if task isn't "--version"
If Not (( ini::UserOpts & ini::#opt_Version ) And 
        Not ( ini::UserOpts & ini::#opt_opStatusReq ))
  msg::PrintButlerVersionFramed() ; => Butler's Framed Header
EndIf


If ( ini::UserOpts & ini::#opt_NoOpts )
  ; ------------------------------------------------------------------------------
  ;                       Butler Invoked Without Any Options                      
  ; ------------------------------------------------------------------------------
  ; TODO: Implement > Butler Invoked Without Options
  End
EndIf

If Not ( ini::UserOpts & ini::#opt_opStatusReq )
  ; ==============================================================================
  ;                         Non-Project Processing Options                        
  ; ==============================================================================
  ; User options don't involve any processing operations that require Butler's
  ; Operative Status to be true ... 
  ; ------------------------------------------------------------------------------
  If ( ini::UserOpts & ini::#opt_Version )
    ; ------------------------------------------------------------------------------
    ; --version
    ; ------------------------------------------------------------------------------
    Print( msg::ButlerVersion() )
    End
  ElseIf ( ini::UserOpts & ini::#opt_Help )
    ; ------------------------------------------------------------------------------
    ; --help
    ; ------------------------------------------------------------------------------
    msg::PrintHelp()
    End
  EndIf
  
Else
  ; ==============================================================================
  ;                           Project Processing Options                          
  ; ==============================================================================
  ; User options involve project processing operations that require Butler's
  ; Operative Status to be true ... 
  ; ------------------------------------------------------------------------------
  ;                           Print List of Butler Tasks                          
  ; ------------------------------------------------------------------------------
  msg::PrintTasksList()
  If Not operativeStatus
    ; ------------------------------------------------------------------------------
    ;                         Butler Not in Operative Status                        
    ; ------------------------------------------------------------------------------
    ; Some proj processing tasks were requested but Butler's initialization didn't
    ; meet all requirements ...
    ; ------------------------------------------------------------------------------
    ; TODO: Implement > Operative Status Problems
    OUT$ = msg::ButlerStatus()
    PrintN(OUT$)
    
    ERR$ = "!!! ERROR !!! Butler can't carry out any project processing tasks for the following reasons" + txt::#EOL$
    ERR$ + msg::ListStatusErrors()
    ConsoleError( ERR$ ) ; FIXME: Use some msg::Error() procedure instead!
    
    End 1
  EndIf
  If ( ini::UserOpts & ini::#opt_BuildFolder ) Or 
     ( ini::UserOpts & ini::#opt_BuildAll )
    ; ------------------------------------------------------------------------------
    ;                                Build Operations                               
    ; ------------------------------------------------------------------------------
    Goto SECTION_BUILD
  Else
    ; ------------------------------------------------------------------------------
    ;                                Anything Else...                               
    ; ------------------------------------------------------------------------------
    ; FIXME: This is a temporary solution for unimplemented options!
    End
  EndIf
EndIf


;}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;-                               BUILD OPERATIONS                               
;{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SECTION_BUILD: ; This section contains all code relating to building sources:
               ;  -- convert markdown files to html.
               ; ---------------------------------------------------------------

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;                         Determine Build Operation Type                        
;{//////////////////////////////////////////////////////////////////////////////
If ( ini::UserOpts & ini::#opt_BuildAll )
  ; ==============================================================================
  ;                          Build Operation = Build All                          
  ; ==============================================================================
  buildDir$ = ini::Proj\Root$
  PrintN("TASK: Build whole project.")
Else
  ; ==============================================================================
  ;                     Build Operation = Build Current Folder                    
  ; ==============================================================================
  buildDir$ = invocationDir$
  If ( ini::UserOpts & ini::#opt_Recursive )
    PrintN("TASK: Build current folder recursively.")
  Else
    PrintN("TASK: Build current folder.")
  EndIf
  ; Some checks are required for this build operation...
  ; ------------------------------------------------------------------------------
  ; 1. CHECK WE'RE INSIDE PROJECT TREE
  ; ------------------------------------------------------------------------------
  ; Butler binary is assumed to be on system path, so that it can be invoked from
  ; anywhere. When building current folder we must ensure it was invoked within
  ; the project's tree...
  ; ------------------------------------------------------------------------------
  If FindString(buildDir$, ini::Proj\Root$) <> 1 ; curr folder path must contain project path
    msg::Abort("Butler invoked outside the project directory tree.")
  EndIf
  ; ------------------------------------------------------------------------------
  ; 2. CHECK PATH VALIDITY
  ; ------------------------------------------------------------------------------
  ; Check that neither the current folder or any of its ancestors (up to the
  ; project's root) belong to the folders' exclusion list...
  ; ------------------------------------------------------------------------------
  subPath$ = RemoveString(buildDir$, ini::Proj\Root$)
  totSubfolders = CountString(subPath$, FS::#DIR_SEP$)         ; Get num of separators in current subpath
  For i = 1 To totSubfolders
    subFolder$ = StringField(subPath$, i, FS::#DIR_SEP$)
    If Left(subFolder$, 1) = "_"            ; If folder name starts with underscore ...
      msg::Abort(~"Current path is inside an excluded folder (\"" + subFolder$ + ~"\").")
      ; NOTE: If in the future I implement custom settings file for exclusion and
      ;       and execeptions, I'll have to expand this part!
    EndIf
  Next
EndIf
;}////// END :: Determine Build Operation Type /////////////////////////////////

If ( ini::UserOpts & ini::#opt_Verbose ) ; DBG Verbosity Option
  PrintN("(verbose mode)")
EndIf

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;-                         INITIALIZE BUILD MODULE                          
; //////////////////////////////////////////////////////////////////////////////
build::init()


; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;                               BUILD CURR FOLDER                               
; //////////////////////////////////////////////////////////////////////////////
; NOTE: Currently this is carried out always, regardless of params!
;       Once the code is structured I'll implement it conditionally, for now I
;       just need to test it...
; ------------------------------------------------------------------------------
build::BuildFolder(buildDir$, ( ini::UserOpts & ini::#opt_Recursive ) )

; <<< BUILD CURR FOLDER : END

End
; DELME <<< MAIN BODY END



;}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                MISC. PROCEDURES                               
;{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




; ==============================================================================
;                              Split String to List                             
; ==============================================================================
; FIXME: Check if this proc is actually used!!!
; by wilbert
; Posted: Sun Apr 10, 2016 6:26 am
; http://www.purebasic.fr/english/viewtopic.php?f=12&t=65159
; my modded version "by Wilbert - String Split and Join 2 List ( my mod 1 ).pb"
Procedure SplitL(String.s, List StringList.s()) ; REMOVED: , Separator.s = " ")
  
  Protected S.String, *S.Integer = @S ; '*S' punta a 'S' ('S' è di tipo 'string', quindi 'S\s' è un puntatore (int) a una stringa (nativa)
  Protected.i p                       ; REMOVED: , slen
                                      ; REMOVED: slen = Len(Separator)
  ClearList(StringList())             ; Since Lists are passed by Ref, make sure it's empty!
  
  *S\i = @String ; Assegna a cotenuto del puntatore indirizzo di String -- così facendo ora 'S\s' punta a 'String'!
  Repeat
    p = FindString(S\s, FS::#DIR_SEP$) ; `S\s` punta a 'String'
                                       ; NOTE: FindString() returns the position in characters, not in bytes!
    match$ = PeekS(*S\i, p - 1)
    If match$ <> #Null$ ; Only add new List element if a string is found (ie: skip ending "/" or "\" of path)
      AddElement(StringList())
      StringList() = match$
    EndIf
    *S\i + (p * 2)  ; modifica contenuto di 'S\s' slittandone il puntatore
    
    ;     *S\i + (p + slen - 1) << #PB_Compiler_Unicode ; modifica contenuto di 'S\s' slittandone il puntatore
    
    ; Se #PB_Compiler_Unicode è True (1) allora 'pos << 1' = *2
    ; OSSIA: Se è unicode sposta il puntatore del doppio dei numeri di carattere da saltare, perché PB usa internamente Unicode UCS2, e quindi ogni carattere
    ; occupa 2 bytes (anche se è Ascii). Questo per ottimizare le operazioni su stringa. UTF-8 viene usato solo su file!
    ;
    ; Fred ha commentato:
    ;       you should not write code like this: A constant value can change in a future version of PB,
    ;       so even If it works now (because it's 1), it's Not granted To work in the future And could cause hard To find bugs
    ; Ma Wilbert ha ribattuto:
    ;       I assumed in this case it would be okay because it is mentioned in the help file the constant is either 0 or 1.
    ;       Well, in the future we don't have To check For ascii Or unicode since there will be only unicode.
    ; e Fred ha ammesso:
    ;       Actually, you are right, for this case it is OK, my bad. Should be the lack of sleep!
    ;
    ; NOTA: '<<' = Arithmetic shift left. Shifts each bit in the value of the expression on the LHS left
    ; by the number of places given by the value of the expression on the RHS.
    ; Additionally, when the result of this operator is Not used And the LHS contains a variable,
    ; that variable will have its value shifted. It probably helps If you understand binary numbers when you use this operator, although you can use it As If each position you shift by is multiplying by an extra factor of 2.
    
    ;     PrintN( ">> " + S\s ) ; DBG
  Until p = 0
  *S\i = 0
  
EndProcedure

; ==============================================================================
;                              Join List to String                              
; ==============================================================================
; FIXME: Check if this proc is actually used!!!
; by wilbert
; Posted: Sun Apr 10, 2016 6:26 am
; http://www.purebasic.fr/english/viewtopic.php?f=12&t=65159
; my modded version "by Wilbert - String Split and Join 2 List ( my mod 1 ).pb"
Procedure.s JoinL(List StringList.s(), Separator.s = " ")
  
  Protected.i slen, tlen, *buffer
  slen = Len(Separator)
  ForEach StringList()
    tlen + Len(StringList()) + slen
  Next
  tlen - slen
  
  Protected Dim buffer.c(tlen)
  *buffer = @buffer()
  If FirstElement(StringList())
    CopyMemoryString(StringList(), @*buffer)
    While NextElement(StringList())
      CopyMemoryString(Separator)
      CopyMemoryString(StringList())
    Wend
  EndIf
  
  ProcedureReturn PeekS(@buffer())
  
EndProcedure
; <<< END: MISC. PROCEDURES <<<
;}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~