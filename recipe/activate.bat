rem header written by bld.bat

@echo off

SetLocal EnableExtensions EnableDelayedExpansion

rem https://ss64.com/nt/syntax-args.html
set "PKG_UUID=%PKG_NAME%-%PKG_VERSION%_%PKG_BUILDNUM%"
set "CONDA_MESO=%CONDA_PREFIX%\conda-meso\%PKG_UUID%"

set "MY_SELF=%~f0
(
    echo Starting %MY_SELF%
    echo Activating in %CONDA_PREFIX%
    echo    CONDA_ROOT   : %CONDA_ROOT%
    echo    CONDA_QUIET  : %CONDA_QUIET%
    echo    PKG_NAME     : %PKG_NAME%
    echo    PKG_VERSION  : %PKG_VERSION%
    echo    PKG_BUILDNUM : %PKG_BUILDNUM%
    echo    PKG_UUID     : %PKG_UUID%

    echo    CONDA_JSON   : %CONDA_JSON%
    echo    CONDA_EXE    : %CONDA_EXE%
    echo    CONDA_EXES   : %CONDA_EXES%
    echo    CONDA_MESO   : %CONDA_MESO%

    echo    CONDA_PREFIX          : %CONDA_PREFIX%
    echo    CONDA_PREFIX_1        : %CONDA_PREFIX_1%

    echo    CONDA_DEFAULT_ENV     : %CONDA_DEFAULT_ENV%
    echo    CONDA_PROMPT_MODIFIER : %CONDA_PROMPT_MODIFIER%
    echo    CONDA_PYTHON_EXE      : %CONDA_PYTHON_EXE%
    echo    CONDA_SHLVL           : %CONDA_SHLVL%

    echo    CONDA_ALLOW_SOFTLINKS : %CONDA_ALLOW_SOFTLINKS%
    echo    CONDA_PATH_CONFLICT   : %CONDA_PATH_CONFLICT%
)
if not exist "%CONDA_MESO%" mkdir "%CONDA_MESO%"

rem https://en.wikipedia.org/wiki/Environment_variable#Windows
rem  Discovery
for /D %%G in ("%ProgramFiles%\Qt\Qt%PKG_VERSION%" "%SYSTEMDRIVE%\Qt\Qt%PKG_VERSION%") do set "QT_DIR=%%~G"

rem  Qt dir = %QT_DIR%
if not exist "%QT_DIR%" (
    for /f "tokens=1,2,3* delims=." %%G in ("%PKG_VERSION%") do set "PKG_MAJOR_MINOR=%%G.%%H"
    (
     echo The target Qt version has not been installed. %QT_DIR%
     echo see https://download.qt.io/new_archive/qt/%PKG_MAJOR_MINOR%/%PKG_VERSION%/qt-opensource-windows-x86-msvc2010-%PKG_VERSION%.exe
    )
    exit /B 0
)

set "DEACTIVATE_SCRIPT=%CONDA_MESO%\deactivate.bat"
echo Writing revert-script to %DEACTIVATE_SCRIPT%
(
  echo @echo off
  echo set "QT_BASE_DIR=%QT_BASE_DIR%"
  echo set "QTDIR=%QTDIR%"
  echo set "QT_BIN_DIR=%QT_BIN_DIR%"
) > "%DEACTIVATE_SCRIPT%"

set "QT_BASE_DIR=%QT_DIR%"
set "QTDIR=%QT_DIR%\msvc2010"
set "SRC_BIN=%QTDIR%\bin"
set "TGT_BIN=%CONDA_PREFIX%\bin"

if not exist "%TGT_BIN%" mkdir "%TGT_BIN%"
for /R "%SRC_BIN%" %%G in (*.exe) do (
  for %%H in (%TGT_BIN%\%%~nxG) do (
      if exist "%%H" (
        del "%%H"
        echo link %%H is being overwritten
      )
      mklink /H "%%H" "%%G" || echo failed creating link "%%H" to "%%G"
      echo rem mklink /H "%%H" "%%G"  >> "%DEACTIVATE_SCRIPT%"
      echo del "%%H" >> "%DEACTIVATE_SCRIPT%"
  )
)


set "FORWARD_SLASHED_PREFIX=%CONDA_PREFIX:\=/%"
if not exist "%CONDA_PREFIX%\Library" mkdir "%CONDA_PREFIX%\Library"
if not exist "%CONDA_PREFIX%\Library\bin" mkdir "%CONDA_PREFIX%\Library\bin"
(
    echo [Paths]
    echo Prefix = %FORWARD_SLASHED_PREFIX%/Library
    echo Binaries = %FORWARD_SLASHED_PREFIX%/Library/bin
    echo Libraries = %FORWARD_SLASHED_PREFIX%/Library/lib
    echo Headers = %FORWARD_SLASHED_PREFIX%/Library/include/qt
    rem Qt seems to not bother setting QMAKE_SPEC nor QMAKE_XSPEC these days on Windows.
    echo TargetSpec = win32-msvc
    echo HostSpec = win32-msvc
) > "%CONDA_PREFIX%\Library\bin\qt-dummy.conf"
rem Some things go looking in the prefix root (pyqt, for example)
copy "%CONDA_PREFIX%\Library\bin\qt-dummy.conf" "%CONDA_PREFIX%\qt-dummy.conf"

exit /B 0
