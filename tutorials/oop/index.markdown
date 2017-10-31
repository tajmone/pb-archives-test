
---
title:     PureBASIC OOP
subtitle:  (Object-Oriented Programming)
# meta-title:
# author: 
# date: YYMMDD
description: >-
    PureBASIC OOP Tutorials and Resources — This section of the PureBASIC
    Archives is dedicated to implementing Object-Oriented Programming in PureBASIC.
keywords:   PureBasic, tutorials, OOP, object-oriented, programming,
            resources, examples
...


PureBASIC (a procedural language) doesn’t support Object-Oriented Programming — and it [doesn’t plan to][PureBASIC Will Never Support OOP] either! Nevertheless, this is as not prevented its users to go to great length in trying to implement the OOP paradigm — to some extent or another — in PureBASIC.



!AlertWarn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__WIP TODOs LIST__:
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Fix links to `index.html`]
!Task[ ][Fix `CONTRIBUTING` link]
!Task[ ]Remove HTML-Preview links]
!Task[x]Remove gfmtoc]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



In This Repo
============

Dräc’s *PureBasic and OOP*
--------------------------

**PureBASIC Archives** has reprinted (with its author’s permission) Dräc’s famous tutorial *PureBasic and OOP* — also known as *OOP Demystified*:

-   [`/drac/`](./drac/index.html) – tutorial folder with source files
-   [English: HTML online preview](http://htmlpreview.github.io/?https://github.com/tajmone/purebasic-archives/blob/master/tutorials/oop/drac/en/OOP-Demystified.html) (needed if you are on GitHub)
-   [French: HTML online preview](http://htmlpreview.github.io/?https://github.com/tajmone/purebasic-archives/blob/master/tutorials/oop/drac/fr/POO-Demystifiee.html) (needed if you are on GitHub)

PureBASIC Will Never Support OOP
================================

The feature request of adding OOP support to PureBASIC is one that pops up in the PB Forum time and again. 

Since the OOP topic seems to draw so much interest in the PureBASIC community, I've gathered here some answers and personal views I've found on the topic by Fred «AlphaSND» (creator and mainter of PureBASIC) and Timo «Fr34k» Harter (of the PureBASIC Team), when asked about the future of PureBASIC regarding OOP support.

Fred, 2005:

> No. It will stay a procedural BASIC, I don't plan to add class and such I think it will split the PB world in 2 classes (!): the one which have understood fully how OOP work and other which don't. Which means than you couldn't share source codes easily anymore at one place. Procedural and Object Oriented Programming are two opposite concepts and it's not a good idea to mix them in a BASIC language (which is intended for beginners...)
> 
> !QuoteSource(Frédéric Laboureur, _[Interview 2005]_.)


Fr34k, 2009:

> Like so many other things on the internet, the OOP question has become a religious issue with most people taking a "my way or the highway"-position. This tends to make any discussion about it go down in flames, which is why I tried to keep out of such discussions recently. It’s funny because usually both sides of the argument seem to miss the point. OOP is neither a magic cure for everything, nor is it this big bad beast that needs to be avoided. It’s just another way of getting the job done, nothing more.
>  
> One thing I have noticed while reading the OOP related discussions in the forum is that people seem to try to prove their own "professionalism" by the fact that they can use the 'Class' keyword. The logical conclusion from that is that PB cannot be professional enough for them since it does not have it. This argument is plain rubbish. It’s the same line of arguments that leads to the browser wars: "I like browser X --- hence browser X must be the best --- therefore all other browsers must be bad --- therefore whoever uses something else must be stupid, as they use a bad browser". In the end, all a web-browser does is display web pages, and every browser out there manages to do that. It is the same with programming tools. The tool that suits you best might not be what is best for other people. And quite frankly, if people need a buzzword like "OOP" to justify their own level of skill, then they have already proven their lack thereof. If you like it and it helps you write good programs then that is fine, but don't think because other people get along fine without it makes you the better coder.
>  
> "The best tool for the job" is what we said all along, and this includes the question of OOP. PB never tried to be and will never be the one and all for everybody. If you like it you use it, and if you don't then just don't. And if you find a task that you think can be better done with another language, then use that. That doesn't need to stop you from using PB for other things still. This is where programming is better than the browser wars: you don't have to choose one single tool. The more diversity the better, because in the end this is how you gain new knowledge. Maybe the next time the "OOP hype" as you calls it comes up on the forum, I might start my own fight for functional programming. After all, that is the only truly elegant way of coding 
>  
> As a final word, I would like to quote Flon's Law:
> 
>  > "There is not now, nor has there ever been, nor will there ever be, any programming language in which it is the least bit difficult to write bad code."
>  > 
>  >  !QuoteSource(Lawrence Flon, 1975)
>
> It is the programmer that writes good code, not the language. And just because it contains classes does not make it a good program.
> 
> OOP in PB? Who knows, maybe some day. I will not rule that out for all eternity. It is however not on our agenda for the foreseeable future, and the chance of it happening is quite low.
> 
> !QuoteSource(Timo «Fr34k» Harter, _[Interview 2009]_.)

Fred, 2012:

> No. The command set is not OOP and it won't mix well. Either do a procedural or OOP language, but don't try to do both. It will end up like C++ where clean C++ sources are rare. Most are patches of C and C++.
> 
> !QuoteSource(Frédéric Laboureur, _[Interview 2012]_.)

Fred, 2015:

> OOP for sure won't be implemented.
> 
> !QuoteSource(Frédéric Laboureur, _[Interview 2015]_.)


Fr34k, 2015:

> I say: “never say never” ;-)
> 
> !QuoteSource(Timo «Fr34k» Harter, _[Interview 2015]_.)


External Links
==============

-   [Purebasic OOP Example](http://zfgc.com/forum/index.php?topic=39610.0) – by MaJoRa, 2012.
-   [Rosetta Code](http://rosettacode.org/wiki/Classes#PureBasic) – 2 examples on how to implement Classes in PB.
-   [SimpleOOP](https://web.archive.org/web/20160312160643/http://development-lounge.de/viewtopic.php?t=5915) – (links to WaybakMachine) An old (2010) opensource compiler which added OOP to **PB 4.51** (x86/64). Still downloadable from the provided link — page is in German, but SimpleOOP documentation comes also in English.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         REFERENCE LINKS DEFINITIONS                          
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[Interview 2005]: http://www.purearea.net/pb/english/interview.htm "2005 Interview with Fred, by André Beer (PureArea.net)"

[Interview 2009]: http://www.purearea.net/pb/english/interview_freak.htm "2009 Interview with freak, by André Beer (PureArea.net)"

[Interview 2012]: http://www.purearea.net/pb/english/interview_fred_2012.htm "2012 Interview with Fred, by André Beer (PureArea.net)"

[Interview 2015]: http://www.purearea.net/pb/english/interview_2015.htm "2015 Interview with Fred and freak, by André Beer (PureArea.net)"

