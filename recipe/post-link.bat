
@echo off

SetLocal EnableExtensions EnableDelayedExpansion

rem https://ss64.com/nt/syntax-args.html
set "MSG_FILE=%CONDA_PREFIX%\.messages.txt"
set "MY_SELF=%~f0

set "PKG_BIN=%CONDA_PREFIX%\bin"
set "PKG_UUID=%PKG_NAME%-%PKG_VERSION%_%PKG_BUILDNUM%"

set "CONDA_MESO=%CONDA_PREFIX%\conda-meso\%PKG_UUID%"
if not exist "%CONDA_MESO%" mkdir "%CONDA_MESO%"

(
    echo Starting %MY_SELF%
    echo Installing in %CONDA_PREFIX%
    echo    CONDA_ROOT   : %CONDA_ROOT%
    echo    CONDA_QUIET  : %CONDA_QUIET%
    echo    CONDA_PREFIX : %CONDA_PREFIX%
    echo    PKG_NAME     : %PKG_NAME%
    echo    PKG_VERSION  : %PKG_VERSION%
    echo    PKG_BUILDNUM : %PKG_BUILDNUM%

    echo    CONDA_JSON   : %CONDA_JSON%
    echo    CONDA_EXE    : %CONDA_EXE%
    echo    CONDA_EXES   : %CONDA_EXES%

    echo    CONDA_PREFIX          : %CONDA_PREFIX%
    echo    CONDA_PREFIX_1        : %CONDA_PREFIX_1%

    echo    CONDA_DEFAULT_ENV     : %CONDA_DEFAULT_ENV%
    echo    CONDA_PROMPT_MODIFIER : %CONDA_PROMPT_MODIFIER%
    echo    CONDA_PYTHON_EXE      : %CONDA_PYTHON_EXE%
    echo    CONDA_SHLVL           : %CONDA_SHLVL%

    echo    CONDA_ALLOW_SOFTLINKS : %CONDA_ALLOW_SOFTLINKS%
    echo    CONDA_PATH_CONFLICT   : %CONDA_PATH_CONFLICT%

    echo    PKG_UUID     : %PKG_UUID%
    echo    CONDA_MESO   : %CONDA_MESO%
    echo    PKG_BIN      : %PKG_BIN%
    echo    CONDA_QUIET  : %CONDA_QUIET%
    echo    CONDA_JSON   : %CONDA_JSON%
) > "%MSG_FILE%"

exit /B 0
