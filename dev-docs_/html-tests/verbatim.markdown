---
title: Verbatim Tests
---

Just tests --- DELETE ME!

# Markdown Can't Achieve Preformatted Blocks

In markdown there is no way to achive a pure pre block.

Indented text will become wrapped in a `<pre><code>` block:

``` markdown
    Indented lines become a `<pre><code>` block.
```

RESULT:

    Indented lines become a `<pre><code>` block.

... the same as if it was enclosed within tildas/backticks without language specification:


``` markdown
~~~
Classless tildas become a `<pre><code>` block.
~~~
```

RESULT:

~~~
Classless tildas become a `<pre><code>` block.
~~~

# Using Raw HTML

Of course, using raw HTML tags within markdown can achieve preformatted blocks:

<pre>I'm enclosed within &lt;pre&gt; tags.</pre>


