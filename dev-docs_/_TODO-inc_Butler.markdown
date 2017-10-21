
## Butler

!TaskList
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
