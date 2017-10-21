!comment(   "Verbatim" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Verbatim.pp" v0.1 (2017-10-20) Alpha

A set of macros for handling verbatim text:

-- Preformatted blocks (<pre>)
-- Code blocks with custom classes for non syntax-higlighted coloring
   (<pre><code class="someclass">)
-- Inline code with custom classes for non syntax-higlighted coloring
   (<code class="someclass">)
------------------------------------------------------------------------------
MACROS LIST:

-- !Code
-- !CodeSmall
-- !CMD
-- !DOS
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: Win + Linux + macOS
REQUIREMENTS: Custom classes must be defined in CSS.
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


!comment(   Code   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Wraps the block of text in 2nd parameter in a <pre><code> block.
    Optionally, if 1st parameter is non empty, it will become the class of the
    <code> tag.
USAGE:

    !Code([CODE CLASS])
    ~~~~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   Code   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<pre!ifdef(1)~~~ class="\1"~~~><code!ifdef(1)~~~ class="\1"~~~>\2</code></pre>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment(   CodeSmall   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the !Code macro, but uses a smaller font size  for the source
    code (<code class="small">).

``````````````````````````````````````````````````````````````````````````````
!define(   CodeSmall   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<pre><code class="!ifne(\1)()(small \1)(small)">\2</code></pre>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!comment(   CMD   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: A shortcut to "!Code(CMD)" macro.
USAGE:

    !CMD
    ~~~~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   CMD   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Code(cmd)(\1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!comment(   DOS   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: A shortcut to "!Code(DOS)" macro.
USAGE:

    !DOS
    ~~~~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   DOS   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Code(dos)(\1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
