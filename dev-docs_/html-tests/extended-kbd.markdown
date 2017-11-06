---
title: <code>&lt;kbd&gt;</code> Extended Tests
---

!define(kbdSubPar)(
To copy selection in clipboard use !kbd(Ctrl)(C); and then to paste it use !kbd(Ctrl)(V). You can always undo with !kbd(Ctrl)(Z)!
)


!define(kbdPar)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!kbdSubPar

Longer keystrokes: !kbd(Alt)(Shift)(F1)

Let's test some colors with `<mark>` ---
`!raw(!mark)`:      !mark[      !kbd(Ctrl)(Shift)(F12)];
`!raw(!markRed)`:   !markRed[   !kbd(Alt)(Shift)(F4)];
`!raw(!markGreen)`: !markGreen[ !kbd(Ctrl)(Alt)(Tab)];
`!raw(!markBlue)`:  !markBlue[  !kbd(Ctrl)(Alt)(&#x2192;)];

Keystrokes styles:

- normal:      !kbd(Ctrl)(Z)
- bold::     __!kbd(Alt)(Shift)(F1)__
- italic:     _!kbd(Alt)(Shift)(F1)_
- strikeout: ~~!kbd(Alt)(Shift)(F1)~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Within Paragraphs

!kbdPar

-------------------------------------------------------------------------------

# Within Blockquote

> !kbdSubPar
> 
> > !kbdSubPar

-------------------------------------------------------------------------------

# Within Headings

!GenHeadings(!kbd(Alt)(Shift)(F1))

-------------------------------------------------------------------------------

# Within Alerts

!GenAlerts(!kbdPar)
