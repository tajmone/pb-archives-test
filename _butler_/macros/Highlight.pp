!comment(   "Highlight" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Highlight.pp" v0.4 (2017-12-07) Alpha

A set of macros for integrating André Simon's Highlight (syntax highlighter)
in pandoc documents:

-- http://www.andre-simon.de/

------------------------------------------------------------------------------
MACROS LIST:

Highlight:
-- !Highlight
-- !HighlightLN
-- !HighlightSmall
-- !HighlightFile
-- !HighlightFileSmall
PureBASIC:
-- !PureBasic
-- !PureBasicLN
-- !PureBasicSmall
-- !PureBasicEX
-- !PureBasicFile
Fasm:
-- !Fasm
-- !FasmLN
-- !FasmSmall
-- !FasmFile

INTERNAL MACROS:
-- !_TitlePB
-- !_TitleFasm
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: Win Bash + Linux + macOS
REQUIREMENTS:
  -- Highlight cli tool must be available on system PATH.
  -- HIGHLIGHT_DATADIR env var must point to custom Highight data folder (to
     allow overriding Highlight's default langdefs, themes, and plugins with
     custom versions of the same files, or to simply add new langs, themes and
     plugins locally).
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(
******************************************************************************
*                                                                            *
*                              INTERNAL MACROS                               *
*                                                                            *
******************************************************************************
These macros are for internal use only.
)

!comment(   _TitlePB & _TitleFasm  )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: The default text for the title attribute of <code> & <pre> tags,
            for PureBASIC and Fasm code blocks.
``````````````````````````````````````````````````````````````````````````````
!define(   _TitlePB     )(PureBASIC source code)
!define(   _TitleFasm   )(Flat Assembler (Fasm) source code)
!comment `````````````````````````````````` ``````````````````````````````````



!comment(
******************************************************************************
*                                                                            *
*                           HIGHLIGHT INTERFACING                            *
*                                                                            *
******************************************************************************
)





!comment(   Highlight   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Syntax highlight the source code within the 4th parameter using
    Highlight external tool. The code language must be defined in 1st param.
    Optionally:
    -- 2nd parameter can contain extra Highlight invocation options.
    -- 3rd parameter can define an extra class for <pre> & <code> tags.
    -- 4th parameter can define text for title attribute of <code> & <pre> tags.
USAGE:

    !Highlight(LANG)([EXTRA HIGHLIGHT OPTIONS])([PRE/CODE CLASS])([TITLE ATTR. TEXT])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

NOTES: To disable Shell expansion of the sourcecode block (and errors when
       it contains backtick characters), the "EOF" delimiter string in the
       redirection operator is placed within single quotes:

           cat <<'EOF' |

       (see "Here Documents" for more info)
``````````````````````````````````````````````````````````````````````````````
!define(   Highlight   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<pre class="!ifdef(3)(!1 !3)(!1)"!ifdef[4]~~~ title="!4"~~~><code class="!ifdef(3)(!1 !3)(!1)"!ifdef[4]~~~ title="!4"~~~>!sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<'EOF' | highlight -f -S !1 --no-trailing-nl --validate-input --data-dir=$HIGHLIGHT_DATADIR !2
!5
EOF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</code></pre>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   HighlightLN   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the !Highlight macro, but add line number to the code.
USAGE:

    !HighlightLN(LANG)([START NUM])([WIDTH])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------
NOTE: Highlight options for line-numbering:
  -l, --line-numbers               print line numbers in output file
  -m, --line-number-start=<cnt>    start line numbering with cnt (assumes -l)
  -j, --line-number-length=<num>   line number width incl. left padding (default: 5)
      --wrap-no-numbers            omit line numbers of wrapped lines (assumes -l)
``````````````````````````````````````````````````````````````````````````````
!define(   HighlightLN   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(!1)(
-l !ifdef[2][-m !2] !ifdef[3][-j !3]
)()()(!4)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   HighlightSmall   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the !Highlight macro, but uses a smaller font size for the
    source code (<code class="small">).
USAGE:

    !HighlightSmall(LANG)([EXTRA HIGHLIGHT OPTIONS])([CODE CLASS])([TITLE ATTR. TEXT])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~
``````````````````````````````````````````````````````````````````````````````
!define(   HighlightSmall   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(!1)(!2)(small !3)(!4)(!5)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   HighlightFile   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Syntax highlight the source code file passed in 1st parameter using
    Highlight external tool. The code language must be defined in the 2nd param.
    Optionally:
    -- 3rd parameter can contain extra Highlight invocation options.
    -- 4th parameter can define an extra class for <code> tag.
    -- 5th parameter can define text for title attribute of <code> & <pre> tags.
USAGE:

    !Highlight(FILE)(LANG)[(EXTRA HIGHLIGHT OPTIONS)(CODE CLASS)(TITLE ATTR. TEXT)]

``````````````````````````````````````````````````````````````````````````````
!define(   HighlightFile   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<pre class="!ifdef(4)(!2 !4)(!2)"!ifdef[5]~~~ title="!5"~~~><code class="!ifdef(4)(!2 !4)(!2)"!ifdef[5]~~~ title="!5"~~~>!exec
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
highlight -f -S !2 --no-trailing-nl --validate-input --data-dir=$HIGHLIGHT_DATADIR !3 -i !1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</code></pre>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   HighlightFileSmall   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the !HighlightFile macro, but uses a smaller font size for the
    source code (<code class="small">).
USAGE:

    !Highlight(FILE)(LANG)[(EXTRA HIGHLIGHT OPTIONS)(CODE CLASS)(TITLE ATTR. TEXT)]

``````````````````````````````````````````````````````````````````````````````
!define(   HighlightFileSmall   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!HighlightFile(!1)(!2)(!3)(small !4)(!5)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment(
******************************************************************************
*                                                                            *
*                            PUREBASIC SHORTCUTS                             *
*                                                                            *
******************************************************************************
)


!comment(   PureBasic   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand macro to invoke Highlight for PureBASIC code blocks.

USAGE:

    !PureBasic
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   PureBasic   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(purebasic)()()(!_TitlePB)(!1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   PureBasicLN   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the HighlightLN macro (Highlight + Line Numbers), but for
            PureBASIC code blocks.

USAGE:

    !PureBasicLN([START NUM])([WIDTH])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   PureBasicLN   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(purebasic)(
-l !ifdef[1][-m !1] !ifdef[2][-j !2]
)()(!_TitlePB)(!3)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   PureBasicSmall   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand like !PureBasic macro but uses !HighlightSmall instead.

USAGE:

    !PureBasicSmall
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   PureBasicSmall   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!HighlightSmall(purebasic)()()(!_TitlePB)(!1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   PureBasicEX   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand like !PureBasic macro but accpets more parameters.

USAGE:

    !PureBasicEX([EXTRA HIGHLIGHT OPTIONS])([CODE CLASS])([TITLE ATTR. TEXT])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   PureBasicEX   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(purebasic)(!1)(!2)(!ifne[!3][][!3][!_TitlePB])(!4)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   PureBasicFile   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand to !HighlightFile, with PureBASIC presets.
    Optionally:
    -- 2nd parameter can contain extra Highlight invocation options.
    -- 3rd parameter can define an extra class for <pre> & <code> tags.
    -- 4th parameter can define text for title attribute of <code> & <pre> tags.

USAGE:

    !PureBasicFile(FILE)[(EXTRA HIGHLIGHT OPTIONS)(CODE CLASS)(CODE TITLE)]

``````````````````````````````````````````````````````````````````````````````
!define(   PureBasicFile   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!HighlightFile(!1)(purebasic)(!2)(!3)(!ifne[!4][][!4][!_TitlePB])
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(
******************************************************************************
*                                                                            *
*                               FASM SHORTCUTS                               *
*                                                                            *
******************************************************************************
)





!comment(   Fasm   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand macro to invoke Highlight for Fasm code blocks.

USAGE:

    !Fasm
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   Fasm   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(fasm)()()(!_TitleFasm)(!1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   FasmLN   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the HighlightLN macro (Highlight + Line Numbers), but for Fasm
            code blocks.
USAGE:

    !FasmLN([START NUM])([WIDTH])
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   FasmLN   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Highlight(fasm)(
-l !ifdef[1][-m !1] !ifdef[2][-j !2]
)()(!_TitleFasm)(!3)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   FasmSmall   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand like !Fasm macro but uses !HighlightSmall instead.

USAGE:

    !FasmSmall
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   FasmSmall   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!HighlightSmall(fasm)()()(!_TitleFasm)(!1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   FasmFile   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Short-hand to !HighlightFile, with Fasm presets.

USAGE:

    !FasmFile(FILE)

``````````````````````````````````````````````````````````````````````````````
!define(   FasmFile   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!HighlightFile(!1)(fasm)()()(!_TitleFasm)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
