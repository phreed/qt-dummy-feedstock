
@echo off

set "PKG_UUID=%PKG_NAME%-%PKG_VERSION%_%PKG_BUILDNUM%"
set "UNLINK_SCRIPT=%CONDA_PREFIX%\conda-meso\%PKG_UUID%\unlink.bat"
echo unlink script %UNLINK_SCRIPT% > "%CONDA_PREFIX%\.messages.txt"

if exist "%UNLINK_SCRIPT%" do (
  call "%UNLINK_SCRIPT%"
  del "%UNLINK_SCRIPT%"
)
if exist "%CONDA_PREFIX%\conda-meso\%PKG_UUID%\deactivate.bat" rm "%CONDA_PREFIX%\conda-meso\%PKG_UUID%\deactivate.bat"

del /S /Q "%CONDA_PREFIX%\conda-meso\%PKG_UUID%"
