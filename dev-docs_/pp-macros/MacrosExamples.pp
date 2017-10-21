!comment(   "Macros Examples" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"MacrosExamples.pp" v1.0.0 (2017-XX-XX)

A set of macros for showing macros usage examples.
------------------------------------------------------------------------------
MACROS LIST:

- !md2html
- !TripleTest
- !
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
------------------------------------------------------------------------------
NOTES: Some macro definitions parameters in this file are enclosed in extra-long
	   lines of tildas. This is because they accept raw definitions as params,
	   which can be markdown or PP macros containing tildas themselves.
	   To avoid a premature parameter closing, we use >80 tildas here.
	   The passed params must not contain more than 80 tildas!
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   md2html   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Convert markdown to HTML code block.
			Markdown text can contain PP macros.
USAGE:

        !md2html(MARKDOWN TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   md2html   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ html
\sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<'EOF' | pandoc -f markdown -t html5 --no-highlight
\1
EOF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   TripleTest   )
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

        !TripleTest(MARKDOWN TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   TripleTest   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__MARKDOWN SOURCE:__

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


__HTML OUTPUT:__


\md2html(\pp[\1])

__VISUAL RESULT:__

\pp[\1]

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


