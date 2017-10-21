---
title: Alerts Test
---

!import(RUN-TESTS.pp)

# Alerts PP-Macros Test

This is a run test of the __Alerts__ pp-macros set.

## Files List

- macros files:
    + [`Alerts.pp`](../macros/Alerts.pp) — macros definition module.
    + [`Alerts.css`](../macros/Alerts.css) — CSS style for Alerts elements.
- extra files:
    + [`github.css`](./github.css) — basic document CSS styling.

## Macros list

!raw{
-   `!Alert(CONTENTS)` — Default alert (blue)
-   `!AlertNote(CONTENTS)` — Plain alert (grey)
-   `!AlertError(CONTENTS)` — Error alert (red)
-   `!AlertWarn(CONTENTS)` — Warning alert (yellow)
-   `!AlertSuccess(CONTENTS)` — Success alert (green)
}



## Default Alert

!def(TEST)(!Alert(__Default__ — Lorem ipsum dolor sit amet, pri cu libris dicunt.))

!RUNTEST

## Warning Alert

!def(TEST)(!AlertWarn(__Warning__ — Lorem ipsum dolor sit amet, pri cu libris dicunt.))

!RUNTEST

## Error Alert

!def(TEST)(!AlertError(__Error__ — Lorem ipsum dolor sit amet, pri cu libris dicunt.))

!RUNTEST

## Success Alert

!def(TEST)(!AlertSuccess(__Success__ — Lorem ipsum dolor sit amet, pri cu libris dicunt.))

!RUNTEST

## Note Alert

!def(TEST)(!AlertNote(__Note__ — Lorem ipsum dolor sit amet, pri cu libris dicunt.))

!RUNTEST


# Test Icons Colors

Some icons are available, their color matches the Alerts color scheme:

!def(IconsAll)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These are the currently supported icons:

- `warning`: !fa(warning)
- `exclamation-circle`: !fa(exclamation-circle)
- `github`: !fa(github)
- `bitbucket`: !fa(bitbucket)
- `windows`: !fa(windows)
- `linux`: !fa(linux)
- `apple`: !fa(apple)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!fa(exclamation-circle) --- The `exclamation-circle` icon has a color matching the Alert palette.

!IconsAll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertError
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!fa(warning) --- The `warning` icon has a color matching the AlertError palette.

!IconsAll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!IconsAll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!IconsAll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!IconsAll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
