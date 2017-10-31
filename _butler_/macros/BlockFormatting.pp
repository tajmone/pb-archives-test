!comment(   "Block Formatting" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"BlockFormatting.pp" v0.1 (2017-10-20) Alpha

A set of shortcut-macros for emitting various HTML5 block elements.
------------------------------------------------------------------------------
MACROS LIST:

- !FakeH3
- !Caption
- !QuoteSource
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   FakeH3   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Wraps text param in a paragraph with "FakeH3" class (<p class="FakeH3">).
            Used for non-indicised pseudo-headings.
USAGE:

        !FakeH3(HEADING TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   FakeH3   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<p class="FakeH3">\1</p>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





!comment(   Caption   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Wraps text param in a paragraph with "caption" class (<p class="caption">).
            Used for adding caption to code examples.
USAGE:

        !Caption(CAPTION TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   Caption   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<p class="caption">\1</p>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   QuoteSource   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Used for mentioning Blockquote source.
			Wraps the text in a <p class="source"> and adds a trailing em dash
			followed by a space ("— ") before the parameter's text.
USAGE:

        !QuoteSource(TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   QuoteSource   )(

<p class="source">— \1</p>

)!comment `````````````````````````````````  `````````````````````````````````
