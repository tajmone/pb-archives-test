---
title:    Skylighting Themes Tests
subtitle: Pandoc Syntax Highlighting Themes Preview
---

This purpose of this page is testing how different languages are syntax highlighted by pandoc. Even languages not actually used in PureBASIC archives are tested here, just to see how the default (fallback) theme handles them.

## Default Theme

The default theme for pandoc highlighting is __Base16 Monokai__. This theme will be used for any language for which there isn't a dedicated theme.


!def(medEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## !1

``` { .!2 .numberLines }
!inc(../_codeEx/medium.!3)
```

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!def(longEx)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## !1

``` { .!2 .numberLines }
!inc(../_codeEx/long.!3)
```

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!medEx(YAML)(yaml)(yaml)
!longEx(HTML)(html)(html)
!longEx(Python)(python)(py)
!medEx(GO Lang)(go)(go)


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Go Lang

``` { .go .numberLines }
!inc(../_codeEx/medium.go)
```

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
