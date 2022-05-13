rem header is written by bld.bat

set "PKG_UUID=%PKG_NAME%-%PKG_VERSION%_%PKG_BUILDNUM%"
set "CONDA_MESO=%CONDA_PREFIX%\conda-meso\${PKG_UUID}"
set "DEACTIVATE_SCRIPT=%CONDA_MESO%\deactivate.bat"

if exist "%DEACTIVATE_SCRIPT%" do (
  call "%DEACTIVATE_SCRIPT%"
  del "%DEACTIVATE_SCRIPT%"
)

