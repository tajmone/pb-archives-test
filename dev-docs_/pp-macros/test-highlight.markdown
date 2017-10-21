---
title: "Highlight Tests"
# css: PureBASIC.css
---

!define(PBExample)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; PureBASIC Example
argsPP$ = PP_MACROS_IMPORT$ + MDsourceFile$

If folderYAML ; Current folder contains a "_butler.yaml" settings file... 
  argsPP$ + " _butler.yaml" ; <= add it to PP's command line args.
EndIf

If #False ; Don't show. (might keep it for verbose option)
  PrintN("argsPP$: "+ argsPP$) ; DBG PP Args
EndIf
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Highlight Macros



## `!raw{!Highlight}` Macro

Using the `!raw{!Highlight}` macro:

```
!raw{!Highlight(purebasic)()()}
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
!PBExample!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
```

!Highlight(purebasic)()()(!PBExample)




## `!raw{!HighlightSmall}` Macro

Using the `!raw{!HighlightSmall}` macro:

```
!raw{!HighlightSmall(purebasic)()()}
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
!PBExample!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
```

!HighlightSmall(purebasic)()()(!PBExample)



## `!raw{!HighlightFile}` Macro

Using the `!raw{!HighlightFile}` macro:

```
!raw{!HighlightFile(example.py)(python)()()}
```

!HighlightFile(example.py)(python)()()




## `!raw{!HighlightFileSmall}` Macro

Using the `!raw{!HighlightFileSmall}` macro:

```
!raw{!HighlightFileSmall(example.py)(python)()()}
```

!HighlightFileSmall(example.py)(python)()()








# PB Macros

## `!raw{!PureBasic}` Macro

Using the `!raw{!PureBasic}` macro:

```
!raw{!PureBasic}
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
!PBExample!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
```

!PureBasic(!PBExample)

## `!raw{!PureBasicSmall}` Macro

Using the `!raw{!PureBasicSmall}` macro:

```
!raw{!PureBasicSmall}
!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
!PBExample!raw{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
```

!PureBasicSmall(!PBExample)

-------------

