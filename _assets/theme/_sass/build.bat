@ECHO OFF
ECHO.
ECHO ==================================================
SET _STYLE=nested
:: STYLES:  compact  |  compressed  |  expanded  |  nested (default)
SET _SMAP=auto
:: auto (default): relative paths where possible, file URIs elsewhere
:: file: always absolute file URIs
:: inline: include the source text in the sourcemap
:: none: no sourcemaps
SET "_OPTS=./:../css --sourcemap=%_SMAP% --style=%_STYLE%"
ECHO SASS OPTIONS:
ECHO    %_OPTS%
:: Add required libraries paths to SASS Load Path env-var:
SET "SASS_PATH=%~dp0vendors\normalize-scss"
ECHO SASS LOAD PATHS (%%SASS_PATH%%):
ECHO    %SASS_PATH%
ECHO --------------------------------------------------
ECHO Force building SASS project...
ECHO.
CALL SCSS --update --force %_OPTS%
ECHO.
CHOICE /C:YN /D:N /T:5 /M "Do you want to watch the Sass project"
IF errorlevel 2 EXIT /B
ECHO --------------------------------------------------
ECHO Watching SASS project...
ECHO.
CALL SCSS --watch %_OPTS%

