
@echo off

SetLocal EnableExtensions EnableDelayedExpansion
if errorlevel 1 exit 1

rem  Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
rem  This causes them to be run on environment [de]activation.
rem  https://github.com/mamba-org/mamba/blob/master/libmamba/src/core/activation.cpp#L32-L47
if errorlevel 1 exit 1

echo %~f0

for %%G in (activate deactivate) do (

    if not exist %PREFIX%\etc\conda\%%G.d mkdir %PREFIX%\etc\conda\%%G.d
    if errorlevel 1 exit 1

    set "BAT_SCRIPT=%PREFIX%\etc\conda\%%G.d\%PKG_NAME%-%%G.bat"
    (
        echo @echo off
        echo set "PKG_NAME=%PKG_NAME%"
        echo set "PKG_VERSION=%PKG_VERSION%"
        echo set "PKG_BUILDNUM=%PKG_BUILDNUM%"
        type %RECIPE_DIR%\%%G.bat
    ) > "!BAT_SCRIPT!"
    if errorlevel 1 exit 1

    rem  Copy unix shell activation scripts, needed by Windows Bash users
    set "SH_SCRIPT=%PREFIX%\etc\conda\%%G.d\%PKG_NAME%-%%G.sh"
    if errorlevel 1 exit 1
    (
        echo #^^!/bin/bash -euo
        echo PKG_NAME="%PKG_NAME%"
        echo PKG_VERSION="%PKG_VERSION%"
        echo PKG_BUILDNUM="%PKG_BUILDNUM%"
        type %RECIPE_DIR%\%%G.sh
    ) > "!SH_SCRIPT!"
    if errorlevel 1 exit 1
)
if errorlevel 1 exit 1

exit /B 0