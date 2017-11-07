; ******************************************************************************
; *                                                                            *
; *                        Create "butler.ini" Template                        *
; *                                                                            *
; ******************************************************************************
; Create a sample "___butler.ini" file, with default settings.
; "create butler.ini file.pb" | 2017/10/27 | PB 5.61

; ==============================================================================
;                                DEFAULT SETTINGS                               
; ==============================================================================
; Assign to these constants the default settings that should go in the template:

#ButlerVersion =    "0.1.8"    ; Strict match!
#PPVersion =        "2.1.5"     ; Strict match!
#PandocVersion =    "2.0.1"    ; Strict match!
#HighlightVersion = "3.40"     ; MinVer match!
  
; ==============================================================================
;                               GENERATE TEMPLATE                               
; ==============================================================================
DestFile$ = "___butler.ini" ; <= So we don't overwrite the exisiting ini file
; ------------------------------------------------------------------------------
;                          Define Keys and Descriptions                         
; ------------------------------------------------------------------------------
DataSection
  ;     +------------------+-------------------+------------------------------------------+
  ;     | Key$             | Val$              | Desc$                                    |
  ;     +------------------+-------------------+------------------------------------------+
  Data.s "ButlerVersion",    #ButlerVersion    , "exact version of Butler required";      |
  Data.s "PPVersion"    ,    #PPVersion        , "exact version of PP required"    ;      |
  Data.s "PandocVersion",    #PandocVersion    , "exact version of Panodc required";      |
  Data.s "HighlightVersion", #HighlightVersion , "minimum version of Highlight required"; |
  ;     +---------------+----------------+------------------------------------------------+
  Data.s "-" ; <= END of Data Marker
  ;   Data.s "", "", "" ;   |
  
EndDataSection
; ------------------------------------------------------------------------------
Separator$ = LSet("", 60, "-")

If CreatePreferences(DestFile$)
  
  While 1
    
    Read.s Key$
    If Key$ = "-" : Break : EndIf
    Read.s Val$
    Read.s Desc$
    PreferenceComment(Separator$)
    PreferenceComment(Key$ + " --- " + Desc$)
    WritePreferenceString(Key$, Val$)
  Wend
  
  MessageRequester("SUCCESS!", "Sample file '"+ DestFile$ +"' created sucessfuly.", 
                   #PB_MessageRequester_Ok | #PB_MessageRequester_Info)

Else
  MessageRequester("ERROR!", "Couldn't create '"+ DestFile$ +"' file.", 
                   #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
EndIf
