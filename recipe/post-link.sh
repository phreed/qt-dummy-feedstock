#!/bin/bash -euo

MY_SELF=$(basename "0")
{
  echo "Starting ${MY_SELF}"
  echo "Installing in ${CONDA_PREFIX}"
  echo "  CONDA_PREFIX: ${CONDA_PREFIX}"
  echo "  PKG_NAME:     ${PKG_NAME}"
  echo "  PKG_VERSION:  ${PKG_VERSION}"
  echo "  PKG_BUILDNUM: ${PKG_BUILDNUM}"
  env
} > "${CONDA_PREFIX}/.messages.txt"

PKG_BIN="${CONDA_PREFIX}/bin"
PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"

CONDA_MESO="${CONDA_PREFIX}/conda-meso/${PKG_UUID}"
[ -e "%CONDA_MESO%" ] || mkdir -p "${CONDA_MESO}"

{
  echo "Finishing ${MY_SELF}"
  echo "  PKG_BIN: ${PKG_BIN}"
  echo "  PKG_UUID:     ${PKG_UUID}"
  echo "  CONDA_MESO:  ${CONDA_MESO}"
} > "${CONDA_PREFIX}/.messages.txt"

exit 0
