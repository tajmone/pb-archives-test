﻿;/////////////////////////////////////////////////////////////////////////////////
;***Go-Scintilla 2***
;*===================
;*
;*©nxSoftWare (www.nxSoftware.com) 2010.
;*======================================
;*    
;*  Call-tips demo program.
;/////////////////////////////////////////////////////////////////////////////////


IncludePath "../../"
XIncludeFile "GoScintilla.pbi"


;Initialise the Scintilla library for Windows.
  CompilerIf  #PB_Compiler_OS = #PB_OS_Windows 
    InitScintilla()
  CompilerEndIf

If OpenWindow(0, 100, 200, 740, 600, "GoScintilla demo!", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_ScreenCentered)
  RemoveKeyboardShortcut(0, #PB_Shortcut_Tab) ;Required for the tab key to function correctly when the Scintilla control has the focus.
  ;Create our Scintilla control. Note that we do not specify a callback; this is optional for GoScintilla.
    GOSCI_Create(1, 10, 10, 720, 580, 0, #GOSCI_AUTOSIZELINENUMBERSMARGIN)

  ;Set the padding added to the width of the line-number margin.
    GOSCI_SetAttribute(1, #GOSCI_LINENUMBERAUTOSIZEPADDING, 10)

  ;Set folding symbols margin width.
    GOSCI_SetMarginWidth(1, #GOSCI_MARGINFOLDINGSYMBOLS, 24)

  ;Set the back color of the line containing the caret.
    GOSCI_SetColor(1, #GOSCI_CARETLINEBACKCOLOR, $B4FFFF)

  ;Set font.
    GOSCI_SetFont(1, "Courier New", 10)

  ;Set tabs. Here we use a 'hard' tab in which a tab character is physically inserted. Set the 3rd (optional) parameter to 1 to use soft-tabs.
    GOSCI_SetTabs(1, 2)

  ;Set styles for our syntax highlighting.
  ;=======================================
    ;First define some constants to identify our various styles.
    ;You can name these as we wish.
      Enumeration
        #STYLES_COMMANDS = 1
        #STYLES_COMMENTS
        #STYLES_LITERALSTRINGS
        #STYLES_NUMBERS
        #STYLES_CONSTANTS
        #STYLES_FUNCTIONS
      EndEnumeration

    ;Set individual styles for commands.
      GOSCI_SetStyleFont(1, #STYLES_COMMANDS, "", -1, #PB_Font_Bold)
      GOSCI_SetStyleColors(1, #STYLES_COMMANDS, $800000)  ;We have omitted the optional back color.

    ;Set individual styles for comments.
      GOSCI_SetStyleFont(1, #STYLES_COMMENTS, "", -1, #PB_Font_Italic)
      GOSCI_SetStyleColors(1, #STYLES_COMMENTS, $006400)  ;We have omitted the optional back color.

    ;Set individual styles for literal strings.
      GOSCI_SetStyleColors(1, #STYLES_LITERALSTRINGS, #Gray)  ;We have omitted the optional back color.

    ;Set individual styles for numbers.
      GOSCI_SetStyleColors(1, #STYLES_NUMBERS, #Red)  ;We have omitted the optional back color.

    ;Set individual styles for constants.
      GOSCI_SetStyleColors(1, #STYLES_CONSTANTS, $2193DE)  ;We have omitted the optional back color.

    ;Set individual styles for functions.
      GOSCI_SetStyleColors(1, #STYLES_FUNCTIONS, #Blue)  ;We have omitted the optional back color.

  ;Additional lexer options.
  ;=========================
    ;We must set the lexer separators BEFORE adding call-tipped keywords.
      GOSCI_SetLexerOption(1, #GOSCI_LEXEROPTION_SEPARATORSYMBOLS, @"=+-*/%[],.#") ;You would use GOSCI_AddKeywords() to set a style for some of these if required.
    GOSCI_SetLexerOption(1, #GOSCI_LEXEROPTION_NUMBERSSTYLEINDEX, #STYLES_NUMBERS)

  ;Set keywords for our syntax highlighting and call-tips.
  ;=======================================================
    ;First some commands (no call-tips). For this we simply use the old GOSCI_AddKeywords() function.
      GOSCI_AddKeywords(1, "Debug End If ElseIf Else EndIf For To Next Step Protected ProcedureReturn", #STYLES_COMMANDS, #GOSCI_ADDTOCODECOMPLETION)

    ;Now some functions with call-tips. For this we must use the GOSCI_AddKeywordsEx() (new for GoScintilla 2.0) function.
    ;We have placed the keywords/call-tips in a data section for convenience.
      Read.i numKeywords
      Dim keywords$(numKeywords-1)
      Dim callTips$(numKeywords-1)
      For i = 0 To numKeywords-1
        Read.s keywords$(i)
        Read.s callTips$(i)
      Next
      ;Note the " " used for our open call-tip separators. This means that any symbol (even space characters) will cause the call-tip
      ;to be displayed. Our accompanying close call-tip separator will also be marked as a global terminal symbol.
        GOSCI_AddKeywordsEx(1, numKeywords, keywords$(), calltips$(), " ",  ":", #STYLES_FUNCTIONS)
    ;We now mark : as a global terminal call-tip separator. This means that, for example, in Print "hello", print "mate" : 
    ;the : symbol cancels all preceeding call-tips (as : effectively denotes a new line).
      GOSCI_AddGlobalCalltipSeparators(1, ":", "", #GOSCI_TERMINALCALLTIP)

  ;Delimiters.
  ;===========
    ;Now set up a ; symbol to denote a comment. Note the use of #GOSCI_DELIMITTOENDOFLINE.
    ;Note also that this symbol will act as an additional separator.
      GOSCI_AddDelimiter(1, ";", "", #GOSCI_DELIMITTOENDOFLINE, #STYLES_COMMENTS)
    ;Now set up quotes to denote literal strings.
      GOSCI_AddDelimiter(1, Chr(34), Chr(34), #GOSCI_DELIMITBETWEEN, #STYLES_LITERALSTRINGS)
    ;Now set up a # symbol to denote a constant. Note the use of #GOSCI_LEFTDELIMITWITHOUTWHITESPACE.
      GOSCI_AddDelimiter(1, "#", "", #GOSCI_LEFTDELIMITWITHOUTWHITESPACE, #STYLES_CONSTANTS)
    ;Now set up a ( symbol to denote a function. Note the use of #GOSCI_RIGHTDELIMITWITHWHITESPACE.
      GOSCI_AddDelimiter(1, "(", "", #GOSCI_RIGHTDELIMITWITHWHITESPACE, #STYLES_FUNCTIONS)
    ;We arrange for a ) symbol to match the coloring of the ( symbol. This needs adding as a separator (below).
      GOSCI_AddDelimiter(1, ")", "", 0, #STYLES_FUNCTIONS)

  ;Folding keywords.
  ;=================
      GOSCI_AddKeywords(1, "Procedure Macro", #STYLES_COMMANDS, #GOSCI_OPENFOLDKEYWORD)
      GOSCI_AddKeywords(1, "EndProcedure EndMacro", #STYLES_COMMANDS, #GOSCI_CLOSEFOLDKEYWORD)

  ;Set call-tips.
  ;===============
  ;This lexer state is not set by default.
    GOSCI_SetLexerState(1, #GOSCI_LEXERSTATE_ENABLESYNTAXSTYLING|#GOSCI_LEXERSTATE_ENABLECODEFOLDING|#GOSCI_LEXERSTATE_ENABLECALLTIPS)

  ;Set some initial text.
  ;======================
    text$ = "; GoScintilla 2.0." + #CRLF$
    text$ + "; With thanks to Peyman Mehrabi." + #CRLF$ + #CRLF$
    text$ + "; Try out the new nested call-tips! Go ahead, type some PB code!" + #CRLF$
    text$ + "; (NB - only Print arg1 [,arg2 [,arg3 [...]]]] support call-tips in this demo!)" + #CRLF$ + #CRLF$
    text$ + "; In this demo, Print is marked as having 'any symbol' as it's open call-tip separator." + #CRLF$
    text$ + "; This means that any symbol will cause the call-tip to be shown." + #CRLF$ + #CRLF$
    text$ + "; The accompanying close call-tip separator ':' is marked as a global terminal" + #CRLF$
    text$ + "; call-tip separator. This means that a : symbol will cancel all preceeding" + #CRLF$
    text$ + "; call-tips regardless of how many call-tips are currently nested." + #CRLF$ + #CRLF$

    GOSCI_SetText(1, text$)

  Repeat
    eventID = WaitWindowEvent()
    Select eventID
      Case #PB_Event_Gadget
        Select EventGadget()
        EndSelect
    EndSelect
  Until eventID = #PB_Event_CloseWindow 

  ;Free the Scintilla gadget.
  ;This needs explicitly calling in order to free resources used by GoScintilla.
    GOSCI_Free(1)
EndIf


DataSection
  ;Some keywords with call-tips using () and "" separators.
    Data.i 1
    Data.s "Print", "Print arg1 [,arg2 [,arg3 [...]]]]" + #LF$ + "Displays a list of comma separated arguments in text form."
EndDataSection

; IDE Options = PureBasic 4.61 Beta 1 (Windows - x86)
; CursorPosition = 12
; EnableUnicode
; EnableThread
; EnableXP
; Executable = t.exe