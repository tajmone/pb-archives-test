@ECHO OFF
ECHO.
ECHO ******************************************************************************
ECHO *                                                                            *
ECHO *                               HTML 2 PANDOC                                *
ECHO *                                                                            *
ECHO *                             by Tristano Ajmone                             *
ECHO *                                                                            *
ECHO *                             v1.0 (2017/02/04)                              *
ECHO *                                                                            *
ECHO ******************************************************************************
::   Convert all *.md files in folder to pandoc markdown ("*.markdown") and add a
::   YAML header.
::   Logs errors to "html2pandoc.log"
SET _LOGFILE=html2md.log
ECHO. 1> %_LOGFILE%
FOR %%i IN (*.md) DO (
    ECHO Processing %%i
    :: 1) Add YAML header.
    TYPE %~dpn0.yaml 1> "%%~ni.markdown"
    :: 2) Convert
    pandoc -f markdown_github -t markdown --wrap=none --smart --normalize "%%i" 1>> "%%~ni.markdown" 2>> %_LOGFILE%
    IF ERRORLEVEL 1 (
        ECHO !!! ERROR CONVERTING "%%i"
        ECHO ==============================================================================
        ECHO ERROR FILE: "%%i">> %_LOGFILE%
        ECHO ==============================================================================>> %_LOGFILE%
    )
)
EXIT /B
