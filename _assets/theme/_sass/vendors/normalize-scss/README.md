Normalize-scss
==============

This folder contains John Albin Wilkins’s **normalize-scss** (“`typey-chroma-kss`” fork) Sass library v7.0.0 (2017/05/17).

------------------------------------------------------------------------

**Table of Contents**

<!-- #toc -->
-   [About Normalize-scss](#about-normalize-scss)
    -   [License](#license)
-   [Changes](#changes)

<!-- /toc -->

------------------------------------------------------------------------

About Normalize-scss
====================

-   <https://github.com/JohnAlbin/normalize-scss>

Normalize-scss is the Sass version of Nicolas Gallagher’s **Normalize.css**, a collection of HTML element and attribute rulesets to normalize styles across all browsers:

-   <http://necolas.github.io/normalize.css>
-   <https://github.com/necolas/normalize.css>

For an overview of Normalize.css read:

-   <http://nicolasgallagher.com/about-normalize-css>

This folder contains the “typey-chroma-kss” fork version of Normalize-scss:

-   <https://github.com/JohnAlbin/normalize-scss/tree/master/fork-versions/typey-chroma-kss>

License
-------

    MIT License

    Copyright (c) Nicolas Gallagher and Jonathan Neal and John Albin Wilkins

-   [`LICENSE`](./LICENSE) — full text of the MIT license.

Changes
=======

Changes to the original library are listed below. All changes here described were carried out by Tristano Ajmone, and they refer to version `7.0.0` of Normalize-scss, as viewable at:

-   <https://github.com/JohnAlbin/normalize-scss/tree/7.0.0>

… or downloadable from:

-   <https://github.com/JohnAlbin/normalize-scss/archive/7.0.0.zip>

List of changes:

-   For the scope of this project, only those files relating to normalize-scss’ Sass module (“typey-chroma-kss” fork version) were imported, leaving out files and folders not strictly related to that fork version or the Sass workflow. Namely:
    -   All the contents of the [`/fork-versions/typey-chroma-kss/` folder](https://github.com/JohnAlbin/normalize-scss/tree/7.0.0/fork-versions/typey-chroma-kss) from the original repo were copied here (contents unchanged); the following files were renamed:
        -   The fork version’s original [`README.md`](https://github.com/JohnAlbin/normalize-scss/blob/7.0.0/fork-versions/typey-chroma-kss/README.md) was renamed to [`README_NORMALIZE-SCSS-FORK.md`](./README_NORMALIZE-SCSS-FORK.md);
        -   The example file [`styles.scss`](https://github.com/JohnAlbin/normalize-scss/blob/7.0.0/fork-versions/typey-chroma-kss/styles.scss) was renamed to [`___styles.scss`](./___styles.scss) to prevent Sass from building it to CSS.
    -   The original [`README.md`](https://github.com/JohnAlbin/normalize-scss/blob/7.0.0/README.md) file from the repo’s root folder was also copied here (contents unchanged), and renamed as [`README_NORMALIZE-SCSS.md`](./README_NORMALIZE-SCSS.md);
    -   The [`LICENSE.md`](https://github.com/JohnAlbin/normalize-scss/blob/7.0.0/LICENSE.md) file from the repo’s root folder was also copied here (contents unchanged), and renamed as [`LICENSE`](./LICENSE).
-   Since we’re using the module without installing it, some `@import` paths had to be fixed:
    -   `/vendors/normalize-scss/base/grouping/_grouping.scss` (Line 2):

        ``` scss
        @import '../../components/divider/divider'; // <= Relative path changed!
        // @import 'components/divider/divider';
        ```

    -   `vendors/normalize-scss/base/forms/_forms.scss` (Line 94):

        ``` scss
        @import '../../forms/button/button'; // <= Relative path changed!
        // @import 'forms/button/button';
        ```

-   This `README.md` file (the one you’re reading) was added to state changes.

