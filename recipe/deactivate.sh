# header is written by build.sh or bld.bat

# PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"
DEACTIVATE_SCRIPT="${CONDA_PREFIX}/conda-activate-meta/${PKG_UUID}/deactivate.sh"

if [ -f "${DEACTIVATE_SCRIPT}" ]; then
  source "${DEACTIVATE_SCRIPT}"
  rm "${DEACTIVATE_SCRIPT}"
fi
