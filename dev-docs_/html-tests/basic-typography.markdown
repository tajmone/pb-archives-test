---
title: Basic Typography Test
---

!import(Typography-Tests.pp)

# Headings

!GenHeadings(Lorem Ipsum)

# General Typography

Lorem markdownum quoniam specie adsumpserat quo ora habet retinacula miserata in essent Thybris ab concita mactatarumque, **sidera**? At aethera, petii via spuma, Aegides, teneat evolvere erat, nec et. Uni Achaidas accipe videndi, querenti cinguntur trabeati *addiderat __duobus__ ut* loris et **Virbius manat**, Iove.

Pellentesque <mark>mark tag</mark> habitant morbi tristique `inline code`senectus et netus et  `inline code` malesuada fames ac turpis egestas. Vestibulum  `inline code` tortor quam, <mark>feugiat vitae, ultricies eget, tempor sit amet, ante</mark>. <kbd>Ctrl</kbd>+<kbd>Z</kbd>. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.

------------

Lorem markdownum quoniam specie adsumpserat quo ora habet retinacula miserata in essent Thybris ab concita mactatarumque, **sidera**? At aethera, petii via spuma, Aegides, teneat evolvere erat, nec et. Uni Achaidas accipe videndi, querenti cinguntur trabeati *addiderat duobus ut* loris et **Virbius manat**, Iove.

# Lists

## Ordered Lists

1. Agisque credule rudente senioribus illic
2. Per iaculum partus
3. Fuerat protecta cervos di ipsum arduus
4. Non ceris mentitis clamor
5. Prima quasi vulnus Graiosque decus lebetes facietque
6. Dira et bracchia istis

## Unordered Lists

- Agisque credule rudente senioribus illic
- Per iaculum partus
- Fuerat protecta cervos di ipsum arduus
- Non ceris mentitis clamor
- Prima quasi vulnus Graiosque decus lebetes facietque
- Dira et bracchia istis

## Task Lists

!TaskList{
!Task[ ][Agisque credule rudente senioribus illic]
!Task[x][Per iaculum partus]
!Task[ ][Fuerat protecta cervos di ipsum arduus]
!Task[x][Non ceris mentitis clamor]
!Task[x][Prima quasi vulnus Graiosque decus lebetes facietque]
!Task[ ][Dira et bracchia istis]
}
--------------------

## Blockquotes

> I'm a blockquote. Picto loqui, conplevit tollens; et finge positisque coniunx inclinarat. Aevo
> est inopes. Defecto pro et Minos delectat cadendum lato comites et deos in.
> Sit velociter! Ferunt ab, mihi memorantur Messenia nec quas cum?
> 
> > I'm a nested blockquote. At ligno: verba saepe illo triumphi. Sanguine dum [aerii nocuit](http://www.ferrivestes.com/hospes.html): tremulo possunt corpore talibus quod turbatum [magni](http://www.an.com/nullique.html)! Et [et fugit dixerunt](http://dum.net/viri-tua.html) sinistro rata mediamque altera, via per suo parvoque, vis fida, ne membra mactatos.


## Cum terribili quantaque vulnera et suum armenta

Ergo ordine tu, monte error ora saepe reverti sternitur. Quoque arma ambit
timidissime vana Cytherea vinum. Praefert viso fata Alcides rosarum pendentibus
criminis caducas et atque sagitta umerique: aut mandata.

- Me patiemur dextra perpetuo quidem
- Titani victus et mecum tantum irascentemque relictis
- Motu silvas
- Ab novis flumina facies quicumque quorum hominemque

**Conatur suis** est sic violentaque feres trepidum ossibus Pallante multorumque
maritum iuravimus sustinui curvi prunaque exprimit tamen. Pharetraque ad molles
plerumque dapibus **noscar** reparabat deos distabat, sic: hiemem possem.
Piasque *ablata* quam mora Iovis est nam iungunt tenues ab vox [venere
quotiensque](http://viros.io/percutit-alias.php): unde mater Hector, posita.
Ripis aera moras, nam quaque revincta erat satis imbres.

Rediturum quasi vertere conligit abeunt illis adhuc **nubes**, quarum, fuistis
letum demittit primasque mea? Balearica quo mansura locum intulerant nullis,
nemus in cycnus tenent!

---------------

# MD-Ipsum

What follows was taken from:

- http://md-ipsum.com/
 
## Standard Navigation List

``` markdown
<nav>
  * [Lorem](#)
  * [Aliquam](#)
  * [Morbi](#)
  * [Praesent](#)
  * [Pellentesque](#)
</nav>
```

<nav>
  * [Lorem](#)
  * [Aliquam](#)
  * [Morbi](#)
  * [Praesent](#)
  * [Pellentesque](#)
</nav>

## Unordered List: Navigation


``` markdown
<nav>
  * [Lorem](#nowhere "Lorum ipsum dolor sit amet")
  * [Aliquam](#nowhere "Aliquam tincidunt mauris eu risus")
  * [Morbi](#nowhere "Morbi in sem quis dui placerat ornare")
  * [Praesent](#nowhere "Praesent dapibus, neque id cursus faucibus")
  * [Pellentesque](#nowhere "Pellentesque fermentum dolor")
</nav>
```

<nav>
  * [Lorem](#nowhere "Lorum ipsum dolor sit amet")
  * [Aliquam](#nowhere "Aliquam tincidunt mauris eu risus")
  * [Morbi](#nowhere "Morbi in sem quis dui placerat ornare")
  * [Praesent](#nowhere "Praesent dapibus, neque id cursus faucibus")
  * [Pellentesque](#nowhere "Pellentesque fermentum dolor")
</nav>

## Definition List

``` markdown
Definition list
 : Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Lorem ipsum dolor sit amet
 : Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
```

Definition list
 : Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Lorem ipsum dolor sit amet
 : Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Empty Table

``` markdown
|   |   |   |
| - | - | - |
|   |   |   |
|   |   |   |
|   |   |   |
```

|   |   |   |
| - | - | - |
|   |   |   |
|   |   |   |
|   |   |   |

--------

``` markdown
zzz
```
