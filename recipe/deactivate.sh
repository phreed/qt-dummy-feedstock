# header is written by build.sh or bld.bat

PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"
CONDA_MESO="${CONDA_PREFIX}/conda-meso/${PKG_UUID}"
DEACTIVATE_SCRIPT="${CONDA_MESO}/deactivate.sh"

if [[ -f $DEACTIVATE_SCRIPT ]]; then
  source "${DEACTIVATE_SCRIPT}"
  rm -f "${DEACTIVATE_SCRIPT}"
fi

echo "Deactivation of ${PKG_NAME} complete"
true
