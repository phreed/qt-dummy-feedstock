# header is written by build.sh or bld.bat

PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"
CONDA_MESO="${CONDA_PREFIX}/conda-meso/${PKG_UUID}"

MY_SELF="$@"
cat - << SHOW_IMPORTANT_ENV_VARIABLES
Starting ${MY_SELF}
Activating in ${CONDA_PREFIX}
   CONDA_ROOT   : ${CONDA_ROOT}
   CONDA_QUIET  : ${CONDA_QUIET}
   PKG_NAME     : ${PKG_NAME}
   PKG_VERSION  : ${PKG_VERSION}
   PKG_BUILDNUM : ${PKG_BUILDNUM}
   PKG_UUID     : ${PKG_UUID}

   CONDA_JSON   : ${CONDA_JSON}
   CONDA_EXE    : ${CONDA_EXE}
   CONDA_EXES   : ${CONDA_EXES}
   CONDA_MESO   : ${CONDA_MESO}

   CONDA_PREFIX          : ${CONDA_PREFIX}
   CONDA_PREFIX_1        : ${CONDA_PREFIX_1}

   CONDA_DEFAULT_ENV     : ${CONDA_DEFAULT_ENV}
   CONDA_PROMPT_MODIFIER : ${CONDA_PROMPT_MODIFIER}
   CONDA_PYTHON_EXE      : ${CONDA_PYTHON_EXE}
   CONDA_SHLVL           : ${CONDA_SHLVL}

   CONDA_ALLOW_SOFTLINKS : ${CONDA_ALLOW_SOFTLINKS}
   CONDA_PATH_CONFLICT   : ${CONDA_PATH_CONFLICT}
SHOW_IMPORTANT_ENV_VARIABLES

[ -d "${CONDA_MESO}" ] || mkdir -p "${CONDA_MESO}"

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
    echo "The target Qt version has not been installed. ${QT_DIR}";
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
  return 0 2> /dev/null | exit 0
fi

DEACTIVATE_SCRIPT="${CONDA_MESO}/deactivate.sh"
echo "Writing revert-script to ${DEACTIVATE_SCRIPT}"
cat - << END_OF_DEACTIVATE_SCRIPT > "${DEACTIVATE_SCRIPT}"
#/bin/bash -euo
export QT_BASE_DIR="${QT_BASE_DIR}"
export QTDIR="${QTDIR}"
export QT_BIN_DIR="${QT_BIN_DIR}"
export PATH="${PATH}"
END_OF_DEACTIVATE_SCRIPT

export QT_BASE_DIR="${QT_DIR}"
export QTDIR="${QT_DIR}/${PKG_VERSION}/gcc_64"
export QT_BIN_DIR="${QTDIR}/bin"
export PATH="${PATH}:${QT_BIN_DIR}"

[ -d "${CONDA_PREFIX}/Library/bin" ] || mkdir -p "${CONDA_PREFIX}/Library/bin"
DUMMY_CONF="${CONDA_PREFIX}/Library/bin/qt-dummy.conf"
echo "Writing qt-dummy.conf to ${DUMMY_CONF}"
cat - <<EOF_DUMMY_CONF > "${DUMMY_CONF}"
[Paths]
Prefix = ${CONDA_PREFIX}/Library
Binaries = ${CONDA_PREFIX}/Library/bin
Libraries = ${CONDA_PREFIX}/Library/lib
Headers = ${CONDA_PREFIX}/Library/include/qt
TargetSpec = linux64
HostSpec = linux64
EOF_DUMMY_CONF

cp "${DUMMY_CONF}" "${CONDA_PREFIX}/qt-dummy.conf"
echo "Activation complete"

