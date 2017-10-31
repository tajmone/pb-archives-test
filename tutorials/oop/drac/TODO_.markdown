---
title:    PureBasic and Object-Oriented Programming
subtitle: TODOs List
meta-title: OOP TODOs
...

# Tutorial Links

!AlertNote
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__LOCAL — ORIGINAL__:

0. [TOC][OOP 0] — [Table of Contents][DRAC0]
1. [OOP 1] — [Why OOP in PureBasic ?][DRAC1]
2. [OOP 2] — [Object concepts][DRAC2]
3. [OOP 3] — [First Implementation of the concepts][DRAC3]
4. [OOP 4] — [Interface instruction][DRAC4]
5. [OOP 5] — [Second Implementation of the concepts][DRAC5]
6. [OOP 6] — [Synthesis and notation][DRAC6]
7. [OOP 7] — [PureBasic Class][DRAC7]
8. [OOP 8] — [Conclusion][DRAC8]
9. [OOP 9] — [Appendix][DRAC9]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# TODOs Pending

!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__WIP TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Theme/Template:]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Add YAML var `title-size` for different sizes]
!Task[ ][Add YAML var `subtitle-size` for different sizes]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Create PAGINATOR macro]
!Task[ ][Add a `README.md` file for GH preview]
!Task[ ][Asciidoc Files:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Fix typos listed in [`ASCIIDOC TODO.txt`](./ASCIIDOC TODO.txt)]
  !Task[ ][Find a way to organize adoc EN/FR tutorials]
  !Task[ ][Fix links to source files (FR PB files in different folder)]
  !Task[ ][Fix resources links and Rebuild with AsciidocFX]
  !Task[ ][Add AsciidocFX usage notes in `README.md`]
~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Fix]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# TODOs Completed

!AlertSuccess
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__ACOMPLISHED TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix Tables]
!Task[x][Fix Ordered Lists (`. text`)]
!Task[x][Add metadata (description, keywords, ecc)]
!Task[x][After Splitting to multipart:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][Add Tutorial title to all pages, and chapter title as subtitle]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix Adoc comments (single line)]
!Task[x][Fix Adoc comments (multi line)]
!Task[x][Fix Adoc icons (eg: `icon:warning`) with FA macro]
!Task[x][Fix Headings]
!Task[x][Fix `[big]##` formatting with `FakeH3` macro]
!Task[x][Fix PB Code Blocks with Macro:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][Some blocks had titles (`.title` syntax)! Fix with `Caption` macro]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix PB pseudocode Blocks with Macro:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][Convert `[source,purebasic pseudocode]` to `PureBasic` macro]
  !Task[x][Create `PureBasicEX` macro and fix psedocode blocks]
  !Task[x][Create CSS `pseudocode` class (greyish version of IDE BG)]
  !Task[x][Remove temp Alerts for `Fixme: PB Psuedocode!`]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix lines of tildas longer than 80 cols (Alerts)]
!Task[x][Fix Adoc Alerts:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][Use more tildas to avoid conflicts with nested PB Code!]
  !Task[x][`IMPORTANT`]
  !Task[x][`NOTE`]
  !Task[x][`WARNING`]
  !Task[x][`TIP`]
  !Task[x][`CAUTION`]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Convert Adoc Links to MD links]
!Task[x][Fix links to source files]
!Task[x][Fix Cross-ref links (in single document tutorial):]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][(see previous remark)]
  !Task[x][(see previous note)]
  !Task[x][See the Appendix of the tutorial]
  !Task[x][based on the previous inheritance example]
  !Task[x][(I can’t wait!)]
  !Task[x][(no, now!)]
  !Task[x][methods presented in the Appendix]
  !Task[x][(Show me now!)]
  !Task[x][What?! I don’t remember!]
  !Task[x][feature explained here]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix Cross-ref links again in split tutorial (use ref-style links)]
!Task[x][Fix Cross-ref labels (use `anchor` macro):]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][[`#admonition-on-structure-interface-symmetry`](#admonition-on-structure-interface-symmetry)]
  !Task[x][[`#admonition-constructor-parameters`](#admonition-constructor-parameters)]
  !Task[x][[`#admonition-on-object-being-a-pointer`](#admonition-on-object-being-a-pointer)]
  !Task[x][[`#admonition-about-this-instance`](#admonition-about-this-instance)]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Fix inline code double backticks]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# TODOs Ideas

!Alert
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__IDEAS THAT COULD BE IMPLEMENTED__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Alerts Improvements Ideas:]
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][I could add the words `WARNING`, etc and avoid using Red alert?]
  !Task[ ][Add internal bold captions like "__WARNING:__", "__NOTE:__" etc?]
~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          

NOTE: More ref.links are defined in "_butler.yaml"!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ORIGINAL TUTORIALS LINKS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[DRAC0]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/indexTutorials_en.htm#POO
[DRAC1]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Pourquoi_en.htm
[DRAC2]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_ConceptObjet_en.htm
[DRAC3]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Implementation1_en.htm
[DRAC4]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Interface_en.htm
[DRAC5]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Implementation2_en.htm
[DRAC6]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Synthese_en.htm
[DRAC7]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Conclusion_en.htm
[DRAC8]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Conclusion_en.htm
[DRAC9]: http://drac.site.chez-alice.fr/Tutorials%20Programming%20PureBasic/POO/POO_Annexes_en.htm

