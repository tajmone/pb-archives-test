---
title:    Git Resources for PureBASIC
subtitle: Resources and guidelines managing PureBASIC projects with Git
# meta-title: TITLE_SHOWN_IN_BROWSER_BAR
# author: 
# date: YYMMDD
# description: METADATA_DESCRIPTION
# description: >-
#    BLOCK DESCRIPTION
# css: 
# baseliner: true
...

Resources and guidelines managing PureBASIC projects with Git.

:::::: Warning :::::::::::::::::::::::::::::

__WIP TODOs LIST__: this page is still a draft.
!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Finish writing text and polish]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Fix]
~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Fix]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


::::::::::::::::::::::::::::::::::::::::::::


# Resources List


In this folder you'll find two Git configuration boilerplate files for your PureBASIC projects: 

- [`PureBASIC.gitignore`](./PureBASIC.gitignore)
- [`PureBASIC.gitattributes`](./PureBASIC.gitattributes)

To use them, just copy them to your repository root and rename "`PureBASIC.gitignore`" to "`.gitignore`", and "`PureBASIC.gitattributes`" to "`.gitattributes`" (the "`PureBASIC`" part in the filenames was added to prevent them being used in the current project).

The details of these files' contents are explained in this document.

# PureBASIC IDE Settings

When working with PureBASIC projects and Git you should check the following settings in the PureBASIC IDE's preferences:

- `Preferences » Editor »  Save Settings to:`
 
Make sure it isn't set to "__The end of the Source file__"; otherwise the IDE will append to the source files your custom settings and Git will see them as changed files even though no significant changes in contents have taken place. If different contributors use different settings or a different PureBAISC version (eg: a LTS or beta release), source files would end up being overwritten and changed back and forth.

You should set it to either:

- "__A common file project.cfg for every director__ " 
- "__The file &lt;filename&gt;.pb.cfg__"
 
Then the repository's `.gitignore` file should be configured to make Git ignore all of PureBASIC's `*.cfg` configuration files, as described later on in this page.


# Git Configuration

To optimize your project, you should add in the repository root two special files to ensure that Git will handle correctly your project's files, regardless of users' custom Git configuration:

- `.gitignore` --- tells Git which files and folders should be ignored
- `.gitattributes` --- tells Git how to handle files extensions (ie: text or binary)

You can use the two boilerplate files in this folder as a starting point, and we'll be referencing them as examples in the course of our explanations.

Both `.gitignore` and `.gitattributes` files share a common syntax for file patterns declarations and comments. Any line starting with the hash symbol ("`#`") will be considered a comment. You can always disable a settings line by commenting it out with the addition of a "`#`" at the beginning of the line.

## Git Ignore

Boilerplate for PureBASIC projects: 

- [`PureBASIC.gitignore`](./PureBASIC.gitignore)

By default, this boilerplate will ignore:

- `*.pb.cfg`, `*.pbi.cfg`  --- per-file configurations
- `project.cfg` --- per-folder configurations
- `*.pbp` --- PB project files

I've already [mentioned earlier on][PureBASIC IDE Settings] why PB source files should be ignored; now I'll explain why I advice to also ignore PB project files by default.

### Ignoring PB Project Files

There are two reasons for not sharing PureBASIC project files (`*.pbp`) in a Git repository:

1. They contain some personal information which you might not wish to share over the Internet (ie: your PC name, paths, etc.)
2. They contain extra local files history info that changes with each IDE session, causing Git to constantly detect project files changes.

The former is an issue of privacy --- and maybe even security ---, the latter is a real pain when working with Git: if you allow Git to track PB project files, they will end up being seen as uncommited changes, and this will interfere with many Git operations during a work session (like branch switiching) because Git will warn you that there are uncomitted changes that would be lost and need to be commited or stashed.

In most cases, just sharing the source files with some direction on how to compile the project is more than enough. But there are cases when sharing a project file makes sense (for example, very big projects with multiple binaries output). In these cases, the best option might be to create sample project files.

### Sample PB Project Files

A sample PureBASIC project file is nothing but a copy of the original project file, renamed to "`<filename>.sample.pbp`" and stripped all the non-essential XML fields (personal data, file history, checksums, etc.).

Since the PureBASIC IDE will rebuild all the missing fields when it opens the project file, the sample file can be shared in your Git project (by exclduing it from being ignored) and endusers can copy it, strip the "`.sample`" from its name, and use it to work locally.

In order for this system to work, you must edit your `.gitignore` file to:

```
*.pbp
!*.sample.pbp
```

This tells Git to ignore all files with names ending in "`.pbp`", except those ending in "`.sample.pbp`".

As a practical example, let's suppose you have a project file "`MyProject.pbp`". This file will be ignored by Git, and it's the file you actually work with, so its contents will change during PB IDE sessions. You will create a sample project file by copying it to "`MyProject.sample.pbp`", and editing its XML contents to remove all entries referring to local and personal data. This file will be tracked by Git because it falls under the exclusion exception pattern rule (`!*.sample.pbp`).

The "`MyProject.sample.pbp`" will therefore be part of the project, and endusers can copy and rename it back to "`MyProject.pbp`" in their local copy --- this file, like yours, will be ignored by Git, so the fact that the IDE will continuosly change its contents is not going to be a problem.


## Git Attributes

Boilerplate for PureBASIC projects:

- [`PureBASIC.gitattributes`](./PureBASIC.gitattributes)


The `.gitattributes` files is an important Git configuration file that allows to control how Git should behave for the current project, regardless on how the user configured Git on his system. This file is capable of handling many different settings, but for the sake of this topic I'll be covering mainly the settings that deal with text and binary file extensions, and line-endings normalization of text files, and some GitHub specific settings.

As far as PureBASIC source files go, you should set the gitattributes for all PB related extensions as `text`, so that Git will normalize all line-endings to the OS' native EOL:

```
*.pb       text
*.pbi      text
*.pbp      text
*.pbf      text
*.cfg      text
```

For more information open the gitattributes boilerplate and read the comments. 

### GitHub Linguist

- <https://github.com/github/linguist/>

GitHub Linguist entries in a `.gitattributes` file are ignroed by Git, they are intended to tell GitHub server how to handle some of its services for the current project's files --- namely: how to associate unknown file extensions to known languages in order to handle syntax highlighting and statistics for the repository.

Here are the [gitattributes](https://github.com/github/linguist/blob/master/README.md#using-gitattributes) supported by Linguist:

- `linguist-language` --- set syntax highlighting
- `linguist-documentation` --- include/exclude from repo's language stats.
- `linguist-vendored` ---  include/exclude from repo's language stats.
- `linguist-generated` --- include/exclude from repo's language stats and diffs.

#### Syntax Extensions

Linguist already associates the `*.pb` and `*.pbi` extension to PureBASIC: 

- <https://github.com/github/linguist/blob/c8ca488/lib/linguist/languages.yml#L3568>

``` yaml
PureBasic:
  type: programming
  color: "#5a6986"
  extensions:
  - ".pb"
  - ".pbi"
  tm_scope: none
  ace_mode: text
  language_id: 301
```

But it currently doesn't support the `*.pbf` (PB form file) and `*.pbp` (PB project) extensions. So you should manually set them in your `.gitattributes` file if you decide to include files with these extensions in your project:

```
*.pbp    linguist-language=XML
*.pbf    linguist-language=PureBasic
```


:::::: Note ::::::::::::::::::::::::::::::::
__NOTE__: There is a [pending pull-request (#3926)](https://github.com/github/linguist/pull/3926) to integrate these two PureBASIC extension into GitHub Linguist.
::::::::::::::::::::::::::::::::::::::::::::

The `*.cfg` extension is already defined as `INI` file:

- <https://github.com/github/linguist/blob/c8ca488/lib/linguist/languages.yml#L1914>

``` yaml
INI:
  type: data
  extensions:
  - ".ini"
  - ".cfg"
  - ".prefs"
  - ".pro"
  - ".properties"
  filenames:
  - buildozer.spec
  tm_scope: source.ini
  aliases:
  - dosini
  ace_mode: ini
  codemirror_mode: properties
  codemirror_mime_type: text/x-properties
  language_id: 163
```

The actual  `INI` grammar file:

- <https://github.com/textmate/ini.tmbundle/blob/master/Syntaxes/Ini.plist>

### Vendored Extension

Manually define/override some vendored files extension.
Vendored files and directories are excluded from language statistics.

```
*.pbp    linguist-vendored
*.cfg    linguist-vendored
```

### Pull Request #3926

I've added the `.pbf` and `.pbp` file extensions to Linguist and created a pull request:

- <https://github.com/github/linguist/pull/3926>

# Ref Links

- [Overrides](https://github.com/github/linguist/blob/master/README.md#overrides)
- [Troubleshooting](https://github.com/github/linguist/blob/master/README.md#troubleshooting)
- [Grammar index](https://github.com/github/linguist/blob/master/vendor/README.md)
- [`documentation.yml`](https://github.com/github/linguist/blob/master/lib/linguist/documentation.yml)
- [vendor.yml](https://github.com/github/linguist/blob/master/lib/linguist/vendor.yml)
- [`languages.yml`](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml)



# Useful Links

!FakeH3(.gitgnore)

- [Git Reference Manual: gitignore](https://git-scm.com/docs/gitignore)
- [Pro Git book: Ignoring Files](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository#_ignoring)
- [github.com/github/gitignore](https://github.com/github/gitignore) --- A collection of useful `.gitignore` templates
- [www.gitignore.io](https://www.gitignore.io/) --- Online tool to create useful `.gitignore` files for your project

