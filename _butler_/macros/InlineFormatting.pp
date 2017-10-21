!comment(   "Inline Formatting" pp-macros set   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"InlineFormatting.pp" v0.1 (2017-10-20) Alpha

A set of shortcut-macros for various standard html inline elements.
------------------------------------------------------------------------------
MACROS LIST:

- !kbd
- !mark
- !markRed
- !markBlue
- !markGreen
------------------------------------------------------------------------------
  OUT FORMAT: html
  OS SUPPORT: all
------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



!comment(   kbd   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Wraps the passed keys in <kbd> tags, separating each key from its
            predecessor with a "+" char. Accepts up to 4 keys.
USAGE:

        !kbd(KEY1)[(KEY2)(KEY3)(KEY4)]

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
``````````````````````````````````````````````````````````````````````````````
!define(   kbd   )(
<kbd>\1</kbd>!ifdef(2)(+<kbd>\2</kbd>)!ifdef(3)(+<kbd>\3</kbd>)!ifdef(4)(+<kbd>\4</kbd>)
)!comment `````````````````````````````````  `````````````````````````````````



!comment(   fa   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Emits a Font-Awesome inline icon. The passed icon name must be
			a valid Font-Awesome icon name (withouth the leading "fa-"), and
			it must be implemented in the CSS stylesheet.
USAGE:

        !fa(ICON NAME)

------------------------------------------------------------------------------
(c) Tristano Ajmone 2017, MIT License.
``````````````````````````````````````````````````````````````````````````````
!define(   fa   )(
<i class="fa fa-\1"></i>
)!comment `````````````````````````````````  `````````````````````````````````




!comment(
******************************************************************************
*                                                                            *
*                                   <mark>                                   *
*                                                                            *
******************************************************************************
)


!comment(   mark   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Wraps the parameter text in <mark> tags (fluorecent yellow).
USAGE:

    !mark(TEXT)

``````````````````````````````````````````````````````````````````````````````
!define(   mark   )(

<mark>\1</mark>

)!comment `````````````````````````````````  `````````````````````````````````


!comment(   markRed   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like !mark, but fluorescent red.

``````````````````````````````````````````````````````````````````````````````
!define(   markRed   )(

<mark class="red">\1</mark>

)!comment `````````````````````````````````  `````````````````````````````````


!comment(   markBlue   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like !mark, but fluorescent blue.

``````````````````````````````````````````````````````````````````````````````
!define(   markBlue   )(

<mark class="blue">\1</mark>

)!comment `````````````````````````````````  `````````````````````````````````


!comment(   markGreen   )
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like !mark, but fluorescent green.

``````````````````````````````````````````````````````````````````````````````
!define(   markGreen   )(

<mark class="green">\1</mark>

)!comment `````````````````````````````````  `````````````````````````````````

