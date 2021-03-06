# header is written by build.sh or bld.bat

# `activate.sh` is run as `source activate` so `exit` cannot be used.

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

[[ -d $CONDA_MESO ]] || mkdir -p "${CONDA_MESO}"

# Discovery
WIP=0
for gx in ~/Qt${PKG_VERSION} /opt/Qt${PKG_VERSION}; do
  if [[ -d $gx ]]; then
    export QT_DIR="$gx"
    break
  fi
done

echo "Qt dir = ${QT_DIR}"
if [[ ! -d $QT_DIR ]]; then
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
  true
  return
fi

DEACTIVATE_SCRIPT="${CONDA_MESO}/deactivate.sh"
echo "Writing revert-script to ${DEACTIVATE_SCRIPT}"
cat - << END_OF_DEACTIVATE_SCRIPT > "${DEACTIVATE_SCRIPT}"
#/bin/bash -euo
export QT_BASE_DIR="${QT_BASE_DIR}"
export QTDIR="${QTDIR}"
export PATH="${PATH}"
END_OF_DEACTIVATE_SCRIPT

export QT_BASE_DIR="${QT_DIR}"
export QTDIR="${QT_DIR}/${PKG_VERSION}/gcc_64"

SRC_BIN="${QTDIR}/bin"
TGT_BIN="${CONDA_PREFIX}/bin"

echo "Preparing to link *.exe files, from ${QTDIR}."

[[ -d ${TGT_BIN} ]] || mkdir -p "${TGT_BIN}"
echo "# linking from ${SRC_BIN}" >> "${DEACTIVATE_SCRIPT}"
for ix in "${SRC_BIN}"/*; do
  BASE_NAME=$(basename -- "${ix}")
  jx="${TGT_BIN}/${BASE_NAME}"
  if [[ -f  $jx ]] ; then
     rm -f "$jx"
     echo "link ${jx} is being overwritten"
  fi
  ln "${ix}" "${jx}" || echo "failed creating link ${jx} to ${ix}"
  echo "rm -f \"${jx}\"" >> "${DEACTIVATE_SCRIPT}"
done

TGT_BIN_LIB="${CONDA_PREFIX}/Library/bin"
[[ -d ${TGT_BIN_LIB} ]] || mkdir -p "${TGT_BIN_LIB}"
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
echo "rm \"${DUMMY_CONF}\"" >> "${DEACTIVATE_SCRIPT}"
echo "rm \"${CONDA_PREFIX}/qt-dummy.conf\"" >> "${DEACTIVATE_SCRIPT}"

echo "Activation of ${PKG_NAME} complete"
true

