---
title: Typography CSS Tests
# css: XXXXtest-typography2.css
# highlight-style: none
---


-------------

# Test Custom Code CSS

Lorem markdownum quoniam specie adsumpserat quo ora habet retinacula miserata in essent Thybris ab concita mactatarumque, **sidera**? At aethera, petii via spuma, Aegides, teneat evolvere erat, nec et. Uni Achaidas accipe videndi, querenti cinguntur trabeati *addiderat duobus ut* loris et **Virbius manat**, Iove.

Test external custom CSS ("`test-typography2.css`") for fine-tuning `code` elements.

----------------

!inc(_code-ruler80.markdown)

-------------

# Inline Code

This is an `inline code` element. This is an `inline code` element. This is an `inline code` element. This is an `inline code` element. This is an `inline code` element. This is an `inline code` element. This is an `inline code` element.

---------------------

# zxxxx


# H1 With `inline code` Inline

## H2 With `inline code` Inline

### H3 With `inline code` Inline

#### H4 With `inline code` Inline

##### H5 With `inline code` Inline

###### H6 With `inline code` Inline

# H1 _With `inline` code_

# H1 With `inline` code


Lorem ipsum.

`just inline`

Lorem ipsum.

---------------------

## Inline With Attributes

L'estensione `inline_code_attributes` (abilitata di default) consente un controllo granulare sugli stili del codice inline, ed assegnando l'attributo di un linguaggio esegue pure il syntax highglighting:

> __Extension__: `inline_code_attributes` 
>
> Attributes can be attached to verbatim text, just as with
[fenced code blocks]:
>
>     `<$>`{.haskell}

Un mio test:

__MARKDOWN SOURCE:__

``` 
Inline Python: `s = 'The value of x is ' + repr(x)`{.python}.
```

__HTML OUTPUT:__

``` html
<p>Inline Python: <code class="sourceCode python">s <span class="op">=</span> <span class="st">'The value of x is '</span> <span class="op">+</span> <span class="bu">repr</span>(x)</code>.</p>
```

... come vedi, ha eseguito il syntax highlighting dell'inline-code!!

__HTML RESULT:__

Inline Python: `s = 'The value of x is ' + repr(x)`{.python}.


# Preformatted Blocks

In order to achieve a simple `<pre>` block (not followed by  `<code>`)...


__MARKDOWN SOURCE:__

``` html
<pre>I'm a preformatted block, no code inside</pre>
```

__HTML RESULT:__

<pre>I'm a preformatted block, no code inside</pre>

# Non-Highlighted Code Blocks

To define a code block without any highlighting, just enclosed it in tildas or backticks (fenced code), or use indentation (4 spaces or one Tab).

__MARKDOWN SOURCE:__

fenced (backticks):

~~~~~~~~ markdown
```
For i=1 To 10
  Debug("Counting " + Str(i))
Next
```
~~~~~~~~

identented (4 spaces):

``` markdown
    For i=1 To 10
      Debug("Counting " + Str(i))
    Next
```

__HTML OUTPUT:__

``` html
<pre><code>For i=1 To 10
  Debug("Counting " + Str(i))
Next</code></pre>
```

__HTML RESULT:__

    For i=1 To 10
      Debug("Counting " + Str(i))
    Next


# Pandoc Highlighting

## Line Numbers

__MARKDOWN SOURCE:__

``` markdown
~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~
```

__HTML OUTPUT:__

``` html
<div class="sourceCode" id="mycode" startfrom="100"><table class="sourceCode haskell numberLines"><tbody><tr class="sourceCode"><td class="lineNumbers"><pre>100
101
102
</pre></td><td class="sourceCode"><pre><code class="sourceCode haskell">qsort []     <span class="fu">=</span> []
qsort (x<span class="fu">:</span>xs) <span class="fu">=</span> qsort (filter (<span class="fu">&lt;</span> x) xs) <span class="fu">++</span> [x] <span class="fu">++</span>
               qsort (filter (<span class="fu">&gt;=</span> x) xs)</code></pre></td></tr></tbody></table></div>
```

__HTML RESULT:__

~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~



----------------


# Highlight

## Block Simple

!Highlight(purebasic)()
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

## Block With Line Numbers

!Highlight(purebasic)(--line-numbers --line-number-length=1)
~~~~~~~~~~
; PureBASIC 5.60
For i=1 To 10
  Debug("Counting " + Str(i))
Next
~~~~~~~~~~

------
------

# SNIPPETS

__MARKDOWN SOURCE:__

``` markdown

```

__HTML OUTPUT:__

``` html

```

__HTML RESULT:__

