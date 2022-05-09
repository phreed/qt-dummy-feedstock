# header written by build.sh and bld.bat

PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"
CONDA_MESO="${CONDA_PREFIX}/conda-meso/${PKG_UUID}"

MY_SELF=$(basename "$0")
{
  echo "Starting ${MY_SELF}"
  echo "Activating in ${CONDA_PREFIX}"
  echo "   CONDA_ROOT   : ${CONDA_ROOT}"
  echo "   CONDA_QUIET  : ${CONDA_QUIET}"
  echo "   PKG_NAME     : ${PKG_NAME}"
  echo "   PKG_VERSION  : ${PKG_VERSION}"
  echo "   PKG_BUILDNUM : ${PKG_BUILDNUM}"
  echo "   PKG_UUID     : ${PKG_UUID}"

  echo "   CONDA_JSON   : ${CONDA_JSON}"
  echo "   CONDA_EXE    : ${CONDA_EXE}"
  echo "   CONDA_EXES   : ${CONDA_EXES}"
  echo "   CONDA_MESO   : ${CONDA_MESO}"

  echo "   CONDA_PREFIX          : ${CONDA_PREFIX}"
  echo "   CONDA_PREFIX_1        : ${CONDA_PREFIX_1}"

  echo "   CONDA_DEFAULT_ENV     : ${CONDA_DEFAULT_ENV}"
  echo "   CONDA_PROMPT_MODIFIER : ${CONDA_PROMPT_MODIFIER}"
  echo "   CONDA_PYTHON_EXE      : ${CONDA_PYTHON_EXE}"
  echo "   CONDA_SHLVL           : ${CONDA_SHLVL}"

  echo "   CONDA_ALLOW_SOFTLINKS : ${CONDA_ALLOW_SOFTLINKS}"
  echo "   CONDA_PATH_CONFLICT   : ${CONDA_PATH_CONFLICT}"
}
[ -e "${CONDA_MESO}" ] || mkdir -p "${CONDA_MESO}"

# Discovery
WIP=0
for gx in ~/Qt${PKG_VERSION} /opt/Qt${PKG_VERSION}; do
  if [ -d $gx ]; then
    export QT_DIR="$gx"
    break
  fi
done

echo "Qt dir = ${QT_DIR}"
if [ ! -d "${QT_DIR}" ]; then
  IFS=. read MAJOR MINOR MICRO BUILD << EOF
  ${PKG_VERSION##*-}
EOF
  PKG_MAJOR_MINOR="$MAJOR.$MINOR"
  {
    echo "The target JDK version has not been installed. ${QT_DIR}";
    case "$OSTYPE" in
      darwin*)
        echo "see https://download.qt.io/new_archive/qt/${PKG_MAJOR_MINOR}/${PKG_VERSION}/qt-opensource-mac-x64-clang-{{ version }}.dmg"
        ;;
      linux*)
        echo "see https://download.qt.io/new_archive/qt/${PKG_MAJOR_MINOR}/${PKG_VERSION}/qt-opensource-linux-x64-{{ version }}.run"
        ;;
      msys*)
        echo "see https://download.qt.io/new_archive/qt/${PKG_MAJOR_MINOR}/${PKG_VERSION}/qt-opensource-windows-x86-msvc2010-{{ version }}.exe"
        ;;
      *) echo "unknown $OSTYPE" ;;
    esac
  }
  exit 0
fi

DEACTIVATE_SCRIPT="${CONDA_MESO}/deactivate.sh"
echo "Writing revert-script to ${DEACTIVATE_SCRIPT}"
{
  printf "#!/bin/bash -euo\n"
  echo "export QT_BASE_DIR=${QT_BASE_DIR}"
  echo "export QTDIR=${QTDIR}"
  echo "export QT_BIN_DIR=${QT_BIN_DIR}"
  echo "export PATH=${PATH}"
} > "${DEACTIVATE_SCRIPT}"

export QT_BASE_DIR="${QT_DIR}"
export QTDIR="${QT_DIR}\msvc2010"
export QT_BIN_DIR="${QTDIR}\bin"
export PATH=${PATH};${QT_BIN_DIR}"

[ -d "${CONDA_PREFIX}\Library" ] || mkdir "${CONDA_PREFIX}\Library"
[ -d "${CONDA_PREFIX}\Library\bin" ] || mkdir "${CONDA_PREFIX}\Library\bin"

(
cat <<'EOF_QT'
[Paths]
Prefix = ${CONDA_PREFIX}/Library
Binaries = ${CONDA_PREFIX}/Library/bin
Libraries = ${CONDA_PREFIX}/Library/lib
Headers = ${CONDA_PREFIX}/Library/include/qt
TargetSpec = win32-msvc
HostSpec = win32-msvc
EOF_QT
) > "${CONDA_PREFIX}\Library\bin\qt-dummy.conf"

cp "${CONDA_PREFIX}\Library\bin\qt-dummy.conf" "${CONDA_PREFIX}\qt-dummy.conf"

exit 0
