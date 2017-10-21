---
title:    Licenses Resources
# subtitle: SUBTITLE
# baseliner: true
...

This folder contains resources for software and software-related licenses.


!define(   PBLicensesVer   )(5.61)
!comment(  PBLicensesVer   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Set the "!PBLicensesVer" macro to the PureBASIC version from which the license files were taken. All references in the current documented will be updated accordingly.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Licenses for PureBASIC Applications
===================================

PureBASIC developers have to include a licenses file with their released software because the PureBASIC compiler includes third party components in the final binaries.

PureBASIC documentation includes ready-to-use license texts:

1. a [__common licenses__ text][PB Apps License], for inclusion with all created applications;
2. and additional [licenses text for apps that make use of the __3D engine__][PB Apps 3D License];
3. the [__PCRE license__ text][PCRE License] for apps that use the __RegularExpression library__.

So, the first one has to be *always* included with your apps, the other ones only if your app uses these libraries.


PureBASIC !PBLicensesVer License Files
--------------------------------------

For your commodity, you'll find here a copy of all the various licenses files (plaintext format), ready to be included into your project:

-   [`PureBASIC_Applications_Licenses.txt`](PureBASIC_Applications_Licenses.txt) !fa(exclamation-circle)
-   [`PureBASIC_Applications_Licenses_3D-Engine.txt`](PureBASIC_Applications_Licenses_3D-Engine.txt)
-   [`PCRE_Library_License.txt`][PCRE License]


!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!fa(exclamation-circle) In the `PureBASIC_Applications_Licenses.txt` file I've fixed a mispelled author name: "Kornel Lesinski" instead of "Kornel LesiÅ„ski" ("NeuQuant" component, line 600):

    Rewritten by Kornel LesiÅ„ski (2009)

(See [PB Forum bug report](http://www.purebasic.fr/english/viewtopic.php?f=37&t=69429))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**WARNING**: These files contain the licenses as found on PureBASIC online documentation at the time of PureBASIC version !PBLicensesVer. The licenses therein contained are unliekly to change, but the introduction of new components in future versions of PureBASIC might introduce new licenses. If you are using a different version of PB, get the right licenses text from PureBASIC’s Help guide.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The license files for the current/latest PureBASIC release can be viewed in the [online documentation at www.purebasic.com](http://www.purebasic.com/documentation/index.html):

- [Licenses for PureBASIC applications (without using 3D engine)][www PB Apps License]
- [Licenses for the 3D engine integrated with PureBASIC][www PB Apps 3D License]
- [License for the PCRE library][www PCRE License]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!comment(  =========== LOCAL LICENSE FILES LINKS ===========  )

[PB Apps License]: ./PureBASIC_Applications_Licenses.txt "Licenses for PureBASIC applications (without using 3D engine)"

[PB Apps 3D License]: ./PureBASIC_Applications_Licenses_3D-Engine.txt "Licenses for the 3D engine integrated with PureBASIC"

[PCRE License]: ./PCRE_Library_License.txt "License for the PCRE library (used by PureBASIC's RegularExpression library)"

!comment(  =========== ONLINE DOCUMENTATION LINKS ===========  )

[www PB Apps License]: http://www.purebasic.com/documentation/reference/license_application.html "Licenses for PureBASIC applications (without using 3D engine)"

[www PB Apps 3D License]: http://www.purebasic.com/documentation/reference/license_engine3d.html "Licenses for the 3D engine integrated with PureBASIC"

[www PCRE License]: http://www.purebasic.com/documentation/mainguide/pcre.html "License for the PCRE library (used by PureBASIC's RegularExpression library)"