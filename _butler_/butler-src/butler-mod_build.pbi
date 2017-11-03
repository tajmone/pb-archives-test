; ··············································································
; ··············································································
; ···························· Butler Build Module ·····························
; ··············································································
; ····························· by Tristano Ajmone ·····························
; ··············································································
; ··············································································
; "butler-mod_build.pbi" | PureBASIC 5.61

; ==============================================================================
;                                  LICENSE INFO                                 
;{==============================================================================
; Butler CMS, a PP-Pandoc markdown to html documentation builder for GitHub repos.
; Copyright (c) 2017 Tristano Ajmone <tajmone@gmail.com>.
; Released under the MIT License.
; For full details on third party components' licenses terms and credits, see the
; accompaining "LICENSE" file.
;}==============================================================================

; This module manages Butler's build operations.


; ******************************************************************************
; *                                                                            *
; *                         MODULE'S PUBLIC INTERFACE                          *
; *                                                                            *
; ******************************************************************************
DeclareModule build
  ; ==============================================================================
  ;                               CORE USER OPTIONS                               
  ; ==============================================================================
  #PANDOC_TEMPLATE$ = "custom.html5"
  ; ==============================================================================
  ;                           SHARED VARS AND CONSTANTS                           
  ; ==============================================================================
  ; The values of some vars will be defined dynamicly, during processing stage.
  ; ------------------------------------------------------------------------------
  #PP_MACROS_FILE$ = "macros" + FS::#DIR_SEP$ + "macros.pp"
  ;                Relative sub-path constant pointing to the main PP macro file
  ;                that imports all other PP macros-definitions files.
  ;                (located in "_butler/macros/macros.pp")
  ; ------------------------------------------------------------------------------
  Define PP_MACROS_IMPORT$ 
  Define PANDOC_BASE_ARGS$
  ; ------------------------------------------------------------------------------
  PANDOC_VARS$ = ""   ; (Shared) This will hold a dynamically generated string to
                      ; define Pandoc template variables via CLI options.
                      ; ------------------------------------------------------------------------------
  argsPandoc$ = ""    ; (Shared) This will hold the final string of arguments to be
                      ; passed to Pandoc.
  
  ; ==============================================================================
  ;                               PUBLIC PROCEDURES                               
  ; ==============================================================================
  Declare init()
  Declare BuildFolder(dirPath$, recursive = #False)
EndDeclareModule

Module build
  
  IncludeFile "butler-mod_build.pbhgen.pbi"   ; <= PBHGEN-X
  
  ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ;-                         INITIALIZE BUILD OPERATIONS                          
  ;{//////////////////////////////////////////////////////////////////////////////
  ; This block defines constants, variables, environment variables and other
  ; settings common to all build operations.
  Procedure init()
    Shared PP_MACROS_IMPORT$, PANDOC_BASE_ARGS$
    ; ------------------------------------------------------------------------------
    SetEnvironmentVariable("PP_MACROS_PATH", ini::Butler\Path$ + "macros" + FS::#DIR_SEP$)
    ;                       Env var holding full path of PP macros folder, used
    ;                       internally by some PP macros. ("_butler/macros/")
    ; ------------------------------------------------------------------------------
    PP_MACROS_IMPORT$ = "-import=" + ini::Butler\Path$ + #PP_MACROS_FILE$ + " "
    ;                 PP CLI options for importing macros. Passed at each invocation.
    ; ------------------------------------------------------------------------------
    PANDOC_BASE_ARGS$ = "-f markdown -t html5 --template=" + ini::Butler\Path$ + #PANDOC_TEMPLATE$ + " " +
                        "--toc --toc-depth=2 --smart --normalize"
    
    
    ;}------------------------------------------------------------------------------
  EndProcedure
  
  
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
    ;-                    CHECK IF FOLDER HAS "_butler.pp" FILE                     
    ; ------------------------------------------------------------------------------
    Print(~"\"_butler.pp\" FILE: ")
    If FileSize(dirPath$ + "_butler.pp") > 0
      folderPP = #True
      PrintN(~"FOUND!\n")      ; BDG "_butler.pp"
    Else
      PrintN(~"NOT FOUND!\n")  ; BDG "_butler.pp"
    EndIf  
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
        ConvertToHTML(mdFilesL(), folderYAML, folderPP)
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
  
  Procedure ConvertToHTML(MDsourceFile$, folderYAML, folderPP)
    ; MDsourceFile$ = The Markdown file to convert to HTML
    ; folderYAML    = A boolean indicating if current folder has a "_butler.yaml" 
    ;                 settings file (to be appended to source files list).
    
    Shared path2root$
    Shared PP_MACROS_IMPORT$ ; PP Base args (still lacks source filename and "_butler.yaml")
    Shared argsPandoc$       ; Pandoc args  (good to go)
    
    ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    ;-                                   PP SETUP                                   
    ;{//////////////////////////////////////////////////////////////////////////////
    argsPP$ = PP_MACROS_IMPORT$    
    ; NOTE: "_butler.pp" is passed to PP before the MD source file, because it will
    ;        contain macro definition shared by multiple docs (and macros must be
    ;        defined before their actual occurence!).
    If folderPP ; Current folder contains a "_butler.pp" settings file... 
      argsPP$ + "-import=_butler.pp " ; <= add it to PP's command line args.
    EndIf
    
    
    argsPP$ + MDsourceFile$
    
    ; NOTE: "_butler.yaml" file is passed to PP after the MD source file because
    ;       when a YAML var is defined twice pandoc will stick to the 1st definition,
    ;       and we need to allow doc YAML to override definition in "_butler.yaml".
    If folderYAML ; Current folder contains a "_butler.yaml" settings file... 
      argsPP$ + " _butler.yaml " ; <= add it to PP's command line args.
    EndIf
    
    
    If #False ; Don't show. (might keep it for verbose option) #True | #False
      PrintN("argsPP$: "+ argsPP$) ; DBG PP Args
    EndIf
    ;}////// END :: PP SETUP ///////////////////////////////////////////////////////
    
    ; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    ;-                               INVOKE PP/PANDOC                               
    ;{//////////////////////////////////////////////////////////////////////////////
    
    ;   argsPandoc$ + " --wzy" ; DELME: Pandoc Error test (pandoc: unrecognized option `--wzy')
    ;     PrintN("argsPP$: "     + argsPP$)     ; DBG PP Args
    ;     PrintN("argsPandoc$: " + argsPandoc$) ; DBG Pandoc Args
    
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
      msg::Abort("Aborting all operations...")
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
      msg::Abort(~"Unable to write \"" + MDsourceFile$ + ~"\" to disk.")
    EndIf
    ;}////// END :: WRITE HTML FILE TO DISK ////////////////////////////////////////
    
  EndProcedure
  ; <<< END: BUILD OPERATIONS <<<
  
EndModule