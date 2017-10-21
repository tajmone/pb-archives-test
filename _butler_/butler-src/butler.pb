; ··············································································
; ··············································································
; ··································· BUTLER ···································
; ··············································································
; ······················· PP-Pandoc MD to HTML Toolchain ·······················
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler.pb" | PureBASIC 5.60
#MAJOR = 0 : #MINOR = 1 : #PATCH = 0 ; v0.1.0 ( 2017/08/14 | Pre-alpha )

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================

IncludeFile "butler.pbhgen.pbi"   ; <= PBHGEN-X
IncludeFile "mod_fs.pbi"          ; Module "FS"  > File System helpers
IncludeFile "mod_ppp.pbi"         ; Module "PPP" > PP / Pandoc interfacing
IncludeFile "butler-mod_ini.pbi"  ; Module "ini" > Project settings
IncludeFile "mod_text-funcs.pbi"  ; Module "txt" > Text Formatting Utilities
IncludeFile "butler-mod_msg.pbi"  ; Module "msg" > Butler messages (STDOUT/STDERR)

; ==============================================================================
;                               CORE USER OPTIONS                               
;{==============================================================================
; #PANDOC_TEMPLATE$ = "editorial.html5"
#PANDOC_TEMPLATE$ = "custom.html5"
;}==============================================================================


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
  Abort("Couldn't open console")
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
  PrintN(~"ini::Proj\\Root$:\n   "+ ini::Proj\Root$)                    ; DBG Proj\Root$
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
    Abort("Butler invoked outside the project directory tree.")
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
      Abort(~"Current path is inside an excluded folder (\"" + subFolder$ + ~"\").")
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
;-                         INITIALIZE BUILD OPERATIONS                          
;{//////////////////////////////////////////////////////////////////////////////
; This block defines constants, variables, environment variables and other
; settings common to all build operations.
; TODO: Implement conditional execution so that it's not run for non-building
;       operations!
; ------------------------------------------------------------------------------
SetEnvironmentVariable("PP_MACROS_PATH", ini::Butler\Path$ + "macros" + FS::#DIR_SEP$)
;                       Env var holding full path of PP macros folder, used
;                       internally by some PP macros. ("_butler/macros/")
; ------------------------------------------------------------------------------
#PP_MACROS_FILE$ = "macros" + FS::#DIR_SEP$ + "macros.pp"
;                Relative sub-path constant pointing to the main PP macro file
;                that imports all other PP macros-definitions files.
;                (located in "_butler/macros/macros.pp")
; ------------------------------------------------------------------------------
PP_MACROS_IMPORT$ = "-import=" + ini::Butler\Path$ + #PP_MACROS_FILE$ + " "
;                 PP CLI options for importing macros. Passed at each invocation.
; ------------------------------------------------------------------------------
PANDOC_BASE_ARGS$ = "-f markdown -t html5 --template=" + ini::Butler\Path$ + #PANDOC_TEMPLATE$ + " " +
                    "--toc --toc-depth=2 --smart --normalize"
; ------------------------------------------------------------------------------
PANDOC_VARS$ = ""   ; (Shared) This will hold a dynamically generated string to
                    ; define Pandoc template variables via CLI options.
                    ; ------------------------------------------------------------------------------
argsPandoc$ = ""    ; (Shared) This will hold the final string of arguments to be
                    ; passed to Pandoc.

;}------------------------------------------------------------------------------

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;                               BUILD CURR FOLDER                               
; //////////////////////////////////////////////////////////////////////////////
; NOTE: Currently this is carried out always, regardless of params!
;       Once the code is structured I'll implement it conditionally, for now I
;       just need to test it...
; ------------------------------------------------------------------------------

BuildFolder(buildDir$, ( ini::UserOpts & ini::#opt_Recursive ) )

; <<< BUILD CURR FOLDER : END

End
; DELME <<< MAIN BODY END


; ==============================================================================
;                                  Build Folder                                 
; ==============================================================================

; TODO: Before enlisting a folder I should check if it's empty! (zero size?)
;       Test if DirectoryEntrySize() report folder size!

; TODO: Initialize PANDOC DATA only if there are MD files in Queue! (optimize)

Procedure BuildFolder(dirPath$, recursive = #False)
  
  Shared UserOptions
  Shared PANDOC_BASE_ARGS$, PANDOC_VARS$, argsPandoc$ ; Pandoc related
  
  subPath$ = RemoveString(dirPath$, ini::Proj\Root$)
  
  PrintN("==============================================================================")
  PrintN("BUILDING PROJECT FOLDER: " + FS::#DIR_SEP$ + subPath$)
  PrintN("------------------------------------------------------------------------------")
  SetCurrentDirectory(dirPath$) 
  
  path2root$ = "" ; Relative path back to the project's root (eg: "..\..\")
  
  ; NOTE: I could move 'path2root$' definition back into main body and then
  ;       add it to the "Shared" vars, and reset it at each procedure call.
  ;       This could help if its needed inside some procedures!
  
  ; ------------------------------------------------------------------------------
  ;                 CHECK IF FOLDER HAS "_butler.yaml" DEFAULT FILE                
  ; ------------------------------------------------------------------------------
  Print(~"\"_butler.yaml\" FILE: ")
  If FileSize(dirPath$ + "_butler.yaml") > 0
    folderYAML = #True
    PrintN(~"FOUND!\n")      ; BDG "_butler.yaml"
  Else
    PrintN(~"NOT FOUND!\n")  ; BDG "_butler.yaml"
  EndIf  
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                                  PANDOC SETUP                                 
  ;{//////////////////////////////////////////////////////////////////////////////
  ; These Pandoc settings are calculated on a per-folder basis.
  ;       ie: They remain the same for all markdown files in the same folder.
  ; ------------------------------------------------------------------------------
  ; Calculate number of subfolders (in project subpath) from number of separators
  ; in current subpath:
  totSubfolders = CountString(subPath$, FS::#DIR_SEP$)
  ; ====================
  ; Build path2root$ var
  ; ====================
  For i = 1 To totSubfolders
    path2root$ + "../" ; <= Use "/" as URL path separator
  Next
  ; ==================================
  ;- $ROOT$ — Panodc template variable
  ; ==================================
  ; Required in pandoc html template to locate assets via relative paths...
  If path2root$
    PANDOC_VARS$ = "-V ROOT=" + path2root$
  EndIf
  ; =========================================
  ;- $breadcrumbs$ — Panodc template variable
  ; =========================================
  ; Raw-HTML string with bread-crumbs as oderdered list.
  ;   If totSubfolders ; Define breadcrumbs only if outside root folder ; DELME
  
  ; NOTE: use singles quotes (') instead of dobule (") within html tags!
  crumbLink$ = path2root$ + "index.html" ; relative link to section's index (starts with root/Home folder)
  
 
  ; >>>>>> Define HTML block : START >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  BreadCrumbs$ = ~"\n<ol>"                                             ; <= opening tag
  BreadCrumbs$ + ~"\n\t<li><a href='" + crumbLink$ + "'>Home</a></li>" ; <= link to Home
  For i = 1 To totSubfolders
    crumbName$ = StringField(subPath$, i, FS::#DIR_SEP$)
    ; Strip trailing underscore from Name (if any)
    If Right(crumbName$, 1) = "_"
      crumbName$ = Left(crumbName$, Len(crumbName$)-1)
    EndIf
    ; At each iteration the crumbs relative link will loose a "../" segment:
    crumbLink$ = RemoveString(crumbLink$, "../", #PB_String_CaseSensitive, 1, 1)
    BreadCrumbs$ + ~"\n\t<li><a href='" + crumbLink$ + "'>" + crumbName$ + "</a></li>"
  Next
  BreadCrumbs$ + ~"\n</ol>\n\n"                                        ; <= closing tag
  
  ; <<<<<< Define HTML block : END <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  PANDOC_VARS$ + ~" -V breadcrumbs=\""+ BreadCrumbs$ + ~"\""           ; <= add Pandoc var
  
  ; =====================
  ; Build argsPandoc$ var
  ; =====================
  ; String holding actual pandoc command line arguments
  ; ------------------------------------------------------------------------------
  argsPandoc$ = PANDOC_VARS$ + " " + PANDOC_BASE_ARGS$
  
  If #False ; Don't show. (might keep it for verbose option)
    PrintN("argsPandoc$: "+ argsPandoc$) ; DBG Pandoc Args
  EndIf
  ;}////// END :: PANDOC SETUP ///////////////////////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                          ENLIST MARKDOWN SOURCE FILES                                                  
  ;{//////////////////////////////////////////////////////////////////////////////
  NewList mdFilesL.s()          ; List of MD files to convert.
  NewList mdFilesReportL.s()    ; List of all MD files encountered.
  If ExamineDirectory(0, dirPath$, "*.markdown")
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_File And
         FileIsBuildEligible(DirectoryEntryName(0), mdFilesReportL())
        ; --------------------------------------------------------------------
        ; Entry is MD File and doesn't belong to hard-coded Exclusion list ...
        ; --------------------------------------------------------------------
        AddElement(mdFilesL())
        mdFilesL() = DirectoryEntryName(0)
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  ; TODO: Handle ExamineDirectory() Error!
  mdFilesEligible = ListSize(mdFilesL())
  mdFilesTotal    = ListSize(mdFilesReportL())
  
  ;}////// END :: ENLIST MARKDOWN SOURCE FILES ///////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                               ENLIST SUBFOLDERS                               
  ;{//////////////////////////////////////////////////////////////////////////////
  If recursive
    NewList foldersL.s()        ; List of subfolder to process.
    NewList foldersReportL.s()  ; List of all subfolder encountered.
    If ExamineDirectory(0, dirPath$, "")
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory And
           FolderIsBuildEligible(DirectoryEntryName(0), foldersReportL())
          ; ------------------------------------------------------------------------------
          ; Entry is File and doesn't belong to hard-coded Exclusion list ...
          ; ------------------------------------------------------------------------------
          AddElement(foldersL())
          foldersL() = DirectoryEntryName(0)
        EndIf
      Wend
      FinishDirectory(0)
      foldersEligible = ListSize(foldersL())
      foldersTotal    = ListSize(foldersReportL())
    EndIf
    ; TODO: Handle ExamineDirectory() Error!
  EndIf
  ;}////// END :: ENLIST SUBFOLDERS //////////////////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                             PRINT OUT ENTRIES LIST                            
  ;{//////////////////////////////////////////////////////////////////////////////
  If ( ini::UserOpts & ini::#opt_Verbose )
    PrintN("\\\\\\\ PRINT OUT ENTRIES LIST \\\\\\\")
    ; ------------------------------------------------------------------------------
    ;                             PRINT MD SOURCES LIST                             
    ;{------------------------------------------------------------------------------
    If mdFilesTotal ; If any MD files were found...
      PrintN("MD files found: " + Str(mdFilesTotal) + " (" + Str(mdFilesEligible) + " due for conversion).")
      ForEach mdFilesReportL()
        PrintN(mdFilesReportL())
      Next
    Else
      PrintN("No MD files found!")
    EndIf
    ; Destroy MD Files Report List (no longer needed):
    FreeList(mdFilesReportL())
    ;}------------------------------------------------------------------------------
    ;                             PRINT SUBFOLDERS LIST                             
    ;{------------------------------------------------------------------------------
    If recursive
      If foldersTotal ; If any subfolder were found...
        PrintN("Subfolders found: " + Str(foldersTotal) + " (" + Str(foldersEligible) + " due for processing).")
        ForEach foldersReportL()
          PrintN(foldersReportL())
        Next
      Else
        PrintN("No Subfolders found!")
      EndIf
      ; Destroy Subfolders Report List (no longer needed):
      FreeList(foldersReportL())
    EndIf
    ;}------------------------------------------------------------------------------
    PrintN("/////// PRINT OUT ENTRIES LIST ///////")
  EndIf
  ;}////// END :: PRINT OUT ENTRIES LIST /////////////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                         PROCESS MARKDOWN SOURCE FILES                         
  ;{//////////////////////////////////////////////////////////////////////////////
  If mdFilesEligible ; If there are any items to convert ...
    
    cnt = 1                         ; Files-processing Counter
    cntTot$ = Str(mdFilesEligible)  ; Total MD files to convert
    cntLen  = Len(cntTot$)          ; Number of digits in counter
    PrintN("Converting " + cntTot$ + " markdown files:")
    
    ResetList(mdFilesL())
    ForEach mdFilesL()
      cntCurr$ = RSet(Str(cnt), cntLen, "0")
      PrintN("  " + cntCurr$ + "/" + cntTot$ + " - " + 
             FS::#DIR_SEP$ + subPath$ +mdFilesL()) ; Print file info
                                                   ; 
      ConvertToHTML(mdFilesL(), folderYAML)
      ; =======================================
      cnt + 1 
    Next
  EndIf
  ;}////// END :: PROCESS MARKDOWN SOURCE FILES //////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                               PROCESS SUBFOLDERS                              
  ;{//////////////////////////////////////////////////////////////////////////////
  If recursive And foldersEligible
    ResetList(foldersL())
    ForEach foldersL()
      destFolder$ = dirPath$ + foldersL() + FS::#DIR_SEP$
      BuildFolder(destFolder$, #True)
    Next  
  EndIf
  ;}////// END :: PROCESS SUBFOLDERS /////////////////////////////////////////////
  
EndProcedure ; <<< BuildFolder() <<<

; ==============================================================================
; DELME:                            File Is Valid Source?                             
; ==============================================================================
; Check if MD file is valid conversion candidate
; ------------------------------------------------------------------------------
Procedure FileIsBuildEligible(fileName$, List mdFilesReportL.s())
  
  AddElement(mdFilesReportL())
  If Left(fileName$, 1) = "_"
    mdFilesReportL() = ~"  - IGNORE: \""+ fileName$ +~"\""
    ProcedureReturn #False
  Else
    mdFilesReportL() = ~"  + ENLIST: \""+ fileName$ +~"\""
    ProcedureReturn #True
  EndIf
  
EndProcedure

; ==============================================================================
;                            Folder Is Valid Source?                            
; ==============================================================================
; Check if folder is eligible processing candidate
; ------------------------------------------------------------------------------
Procedure FolderIsBuildEligible(folderName$, List foldersReportL.s())
  
  If folderName$ = "." Or folderName$ = ".."    ; ======={ "." or ".." }========
                                                ; Mark as Excluded without reporting...
    ProcedureReturn #False
  ElseIf Left(folderName$, 1) = "_"             ; ==={ name begins with "_" }===
                                                ; Mark as Excluded and report...
    AddElement(foldersReportL())
    foldersReportL() = ~"  - IGNORE: \""+ folderName$ +~"\""
    ProcedureReturn #False
  Else
    ; ========================={ Folder Isn't Excluded }========================
    ; Mark as Eligible and report...
    AddElement(foldersReportL())
    foldersReportL() = ~"  + ENLIST: \""+ folderName$ +~"\""
    ProcedureReturn #True
  EndIf
  
EndProcedure
; ==============================================================================
;                                Convert to HTML                                
; ==============================================================================

Procedure ConvertToHTML(MDsourceFile$, folderYAML)
  ; MDsourceFile$ = The Markdown file to convert to HTML
  ; folderYAML    = A boolean indicating if current folder has a "_butler.yaml" 
  ;                 settings file (to be appended to source files list).
  
  Shared path2root$
  Shared PP_MACROS_IMPORT$ ; PP Base args (still lacks source filename and "_butler.yaml")
  Shared argsPandoc$       ; Pandoc args  (good to go)
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                                    PP SETUP                                   
  ;{//////////////////////////////////////////////////////////////////////////////
  argsPP$ = PP_MACROS_IMPORT$ + MDsourceFile$
  
  If folderYAML ; Current folder contains a "_butler.yaml" settings file... 
    argsPP$ + " _butler.yaml" ; <= add it to PP's command line args.
  EndIf
  
  If #False ; Don't show. (might keep it for verbose option)
    PrintN("argsPP$: "+ argsPP$) ; DBG PP Args
  EndIf
  ;}////// END :: PP SETUP ///////////////////////////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;-                               INVOKE PP/PANDOC                               
  ;{//////////////////////////////////////////////////////////////////////////////
  
  ;   argsPandoc$ + " --wzy" ; DELME: Pandoc Error test (pandoc: unrecognized option `--wzy')
  
  If Not PPP::Convert(argsPP$, argsPandoc$)
    ; ==============================================================================
    ;                          PP/Pandoc Reported an Error                          
    ; ==============================================================================
    ; FIXME: Errors Text must be formatted better and handled by Text module!
    ; FIXME: Errors should be send to STDERR!
    ErrFile$ = GetCurrentDirectory() + MDsourceFile$
    ErrCnt = 1
    PrintN( LSet("", 80, "*") )
    PrintN("!!! ERROR !!! While trying to convert the following file:")
    PrintN( #Null$ )
    PrintN( ErrFile$ )
    PrintN( #Null$ )
    PrintN("Butler encountered the following problems:")
    ;     PrintN( LSet("", 80, "~") )
    ; TODO: Handle PP or Pandoc invocation error!
    ; ------------------------------------------------------------------------------
    ;                                List PPP Errors                                
    ; ------------------------------------------------------------------------------
    If PPP::PPRunErr
      PrintN(" " + Str(ErrCnt) + ") PP invocation failed")
      ErrCnt +1
    EndIf
    ; ··············································································
    If PPP::PandocRunErr
      PrintN(" " + Str(ErrCnt) + ") Pandoc invocation failed")
      ErrCnt +1
    EndIf   
    ; ··············································································
    If PPP::PPExCode ; PP Exit Code indicates Error ...
      PrintN(" " + Str(ErrCnt) + ") PP exited with status code: "+ Str(PPP::PPExCode) )
      ErrCnt +1
    EndIf
    ; ··············································································
    If PPP::PPErr$ <> "" And Not PPP::PPExCode ; PP Warning ...
      PrintN(" " + Str(ErrCnt) + ") PP reported a warning" )
      ErrCnt +1
    EndIf
    ; ··············································································
    If PPP::PandocExCode ; Pandoc Exit Code indicates Error ...
      PrintN(" " + Str(ErrCnt) + ") Pandoc exited with status code: "+ Str(PPP::PandocExCode) )
      ErrCnt +1
    EndIf
    ; ··············································································
    If PPP::PandocErr$ <> "" And Not PPP::PandocExCode ; Pandoc Warning ...
      PrintN(" " + Str(ErrCnt) + ") Pandoc reported a warning" )
      ErrCnt +1
    EndIf
    ; ------------------------------------------------------------------------------
    ;                         Print Captured STDERR Messages                        
    ; ------------------------------------------------------------------------------
    If PPP::PPErr$ <> ""
      PrintN( #Null$ )
      PrintN("PP STDERR Message:")
      PrintN( txt::QuoteText(PPP::PPErr$) )
    EndIf
    ; ··············································································
    If PPP::PandocErr$ <> ""
      PrintN("Pandoc STDERR Message:")
      PrintN( txt::QuoteText(PPP::PandocErr$) )
    EndIf
    ; ------------------------------------------------------------------------------
    PrintN( LSet("", 80, "*") )
    Abort("Aborting all operations...")
  EndIf 
  
  
  
  PPPout$ = PPP::DocHTML$ ; <= UTF-8 String!
  
  ;   PrintN("Output Pandoc (Len = " + Str(Len(PPPout$)) + ~"):\n"+  PPPout$) ; DBG PPP HTML Result ; DELME
  
  ; TODO: Remove STDOUT debugging
  ; TODO: Implement clean console output about data being processed
  
  ;}////// END :: INVOKE PP/PANDOC ///////////////////////////////////////////////
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                            DEBUG PP/PANDOC RESULTS                            
  ; //////////////////////////////////////////////////////////////////////////////
  ;     MessageRequester("Output Pandoc", PPPout$) ; DBG MsgReq HTML Result
  ;     MessageRequester("PPErr$", "PP Exit Code: " + Str(PPExCode) + #LF$ + "PP Errors:" + #LF$ + PPErr$) 
  ;     MessageRequester("PandocErr$", "Pandoc Exit Code: " + Str(PandocExCode) + #LF$ + "PP Errors:" + #LF$ + PandocErr$)
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;                            WRITE HTML FILE TO DISK                            
  ;{//////////////////////////////////////////////////////////////////////////////
  HTMLfileName$ = GetFilePart(MDsourceFile$, #PB_FileSystem_NoExtension) + ".html"
  
  If CreateFile(0, HTMLfileName$, #PB_UTF8)
    WriteString(0, PPPout$)
    CloseFile(0)
  Else
    Abort(~"Unable to write \"" + MDsourceFile$ + ~"\" to disk.")
  EndIf
  ;}////// END :: WRITE HTML FILE TO DISK ////////////////////////////////////////
  
EndProcedure
; <<< END: BUILD OPERATIONS <<<


;}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                MISC. PROCEDURES                               
;{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; ==============================================================================
;                             Print Error and Abort                             
; ==============================================================================
; FIXME: Abort() proc -- Remove all calls and delete!
Procedure Abort(errMsg.s)
  ConsoleError("ERROR: "+ errMsg)
  ConsoleError("Aborting all operations ...")
  End 1 ; Exit with Exit Code set to Error (generic)
EndProcedure


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
