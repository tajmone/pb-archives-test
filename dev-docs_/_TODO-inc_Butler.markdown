
## Butler

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][Butler CLI options:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][`--scaffold` to create empty folders (`/highlight-data/`, `/macros/`, etc.) and `butler.ini` template, plus some `README` files with instructions; needed when creating new projects from scratch.]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][PP invocation options:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[x][add definition of `ROOT` symbol with path back to root (like with pandoc ROOT var) so it will be accessible from current doc/macros]
  !Task[x][in `macros.pp` create also `PATH2MACROS` symbol based on `ROOT` (this will allow changing the path in a single place if I ever change the macros folder name or location)]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][LICENSE:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Add `LICENSE` file]
!Task[x][Add PB standard license file + PCRE to `LICENSE` file]
!Task[x][Add license in source headers' comments]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[x][Implement check Butler version]
!Task[ ][Win: Implement check Bash only]
!Task[ ][Move all TODOs from `TODO` file here]
!Task[ ][Deploy:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][Implement Deploy code.]
  !Task[ ][Implement creating `.nojekyll` file.]
  !Task[ ][Implement `DEPLOY.gitignore`, etc.]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!Task[ ][PB Proj file issue — resolve problem of proj file by:]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !Task[ ][**a)** creating a proj file template (eg: `_Butler.pbp`) with some XML fields remove to copy and rename (ie: `_Butler.pbp`) and add its name to `.gitignore` so that when the user saves the project it doesn't create a false commit! The problem with this approach is that if I change the proj template file users might not be aware of it!]
  !Task[ ][**b)** create a small PB app that cleans up the project file of all spurious fields, and invoke it before commiting.]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


:::::: Warning :::::::::::::::::::::::::::::

__DELETE & DEPLOY__: I should create two variants of the deploy command:

- `--deploy` (`-d`) --- builds whole project, then deploys to dest folder.
- `--delete-deploy` (`-D`) --- builds whole project, clean up dest folder, then deploy all contents.

The second variant, which deletes files in dest/deploy folder needs some considerations:

1. It should never delete the `/.git/` folder
2. It should not delete gitignored files (eg: compiled binaries, proj. files, and other files that users might be enjoying)

This means that I'll have to find a way to interact with Git and get a list of ignored files, so that Butler won't delete them.

Butler can't rely on the source folder contents for deciding which files to delete in deploy folder, because renaming/deleting source files would result in deletion misses --- and the whole purpose of the `--delete-deploy` option is to ensure that deleted/renamed source files will not be kept in the deploy folder.

Since Butler --- as a standalone app --- might be used also outside of Git projects, I'll have to add some a "`use-git`" project setting to `butler.ini`, so that non-Git projects will not try to invoke Git for a list of gitignored files.

::::::::::::::::::::::::::::::::::::::::::::
