!comment(   Examples Utilities pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"ExamplesUtils.pp" v0.1.0 (2017-11-04) Alpha Test

A set of macros for showing PP-macros and Markdown usage examples.
------------------------------------------------------------------------------
MACROS LIST:

- !MDExampleHTML

INTERNAL MACROS:
- !_md2html
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
REQUIREMENTS: The !FakeH3 macro from "BlockFormatting.pp"
------------------------------------------------------------------------------
NOTES: Some macro definitions parameters in this file are enclosed in extra-long
       lines of tildas. This is because they accept raw definitions as params,
       which can be markdown or PP macros containing tildas themselves.
       To avoid a premature parameter closing, we use >80 tildas here.
       The passed params must not contain more than 80 tildas!
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!comment(   MDExampleHTML   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Emits markdown example/test in triple format:
            1) Markdown source (as plain code block)
            2) HTML output result (as html code block)
            3) Result preview

            Markdown text can contain PP macros.
NOTES: Since the final markdown source can contain PP macros, it's emitted as
       a fenced code block without specifying a language, so pandoc will not
       highlight it (macros would confuse the parser). 
       HTML output result, on the other hand, is emited as a fenced HTML code
       block, so that pandoc will highlight its syntax.
USAGE:

        !MDExampleHTML(MARKDOWN TEXT)

    ... where MARKDOWN TEXT can cointain PP macros, but this will be expanded
    to markdown in "Markdown source" preview. If you wish to preserve PP macros
    unexpanded in the "Markdown source" preview:

        !MDExampleHTML(!raw[MARKDOWN/PP TEXT])

    ... or, alternatively:


        !define(MacrosExample)
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        MARKDOWN/PP TEXT BLOCK 
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        !MDExampleHTML(!rawdef[MacrosExample])

``````````````````````````````````````````````````````````````````````````````
!define(   MDExampleHTML   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!FakeH3(MARKDOWN SOURCE:)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!FakeH3(HTML OUTPUT:)


!_md2html(!pp[!1])


!FakeH3(VISUAL RESULT:)

!pp[!1]

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             INTERNAL USE MACROS                              
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment(  _md2html  )
!`````````````````````````````````````````````````````````````````````````````
DECRIPTION: Convert markdown to HTML code block.
            Markdown text can contain PP macros.
USAGE:

        !_md2html(MARKDOWN TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(  _md2html  )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ html
!sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<'EOF' | pandoc -f markdown -t html5 --no-highlight
!1
EOF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




