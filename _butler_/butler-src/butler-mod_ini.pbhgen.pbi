; ==============================================================================
;- "butler-mod_ini.pbi" header file.
; Autogenerated by PBHGENX -> https://github.com/tajmone/pb-xtools
; ------------------------------------------------------------------------------
; WARNING: This file is automatically recreated with each save of its main file.
; Any manual changes to this file will be permanently lost!
; ==============================================================================

CompilerIf #PB_Compiler_Module = ""
CompilerEndIf
CompilerIf #PB_Compiler_Module = "ini"
Declare Init()
Declare ParseCLIArgs(numParams)
Declare ReadSettingsFile()
Declare ValidateDependenciesVersion()
Declare.s GetHighlightVersion()
CompilerEndIf
CompilerIf #PB_Compiler_Module = ""
CompilerEndIf