!comment(   "Linking Helpers" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"LinkingHelpers.pp" v0.1 (2017-10-20) Alpha

A set of macros for cross-references and links.
------------------------------------------------------------------------------
MACROS LIST:

- !anchor
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   anchor   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Creates a <span> tag with ID as an anchor for cross linking.
            This is a substitute of the old (and abrogated) HTML4 anchor (ie: 
            <a name="anchor-name">); useful when you need to place an anchor in
            the middle of markdown text. The final HTML anchor will be:

                <span id="anchor-name"></span>
USAGE:

        !anchor(ANCHOR ID)

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
``````````````````````````````````````````````````````````````````````````````
!define(   anchor   )(
<span id="\1"></span>
)!comment `````````````````````````````````  `````````````````````````````````

