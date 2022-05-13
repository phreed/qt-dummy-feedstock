#!/bin/bash -euo

# Copy the [de]activate scripts to ${PREFIX}\etc\conda\[de]activate.d.
# This causes them to be run on environment [de]activation.
# https://github.com/mamba-org/mamba/blob/master/libmamba/src/core/activation.cpp#L32-L47

echo "========================= BUILD ================"
echo "$0"

for CHANGE in "activate" "deactivate"
do
  TGT_CHG_DIR="${PREFIX}/etc/conda/${CHANGE}.d"
  [[ -d ${TGT_CHG_DIR} ]] || mkdir -p "${TGT_CHG_DIR}"
  BASH_SCRIPT="${TGT_CHG_DIR}/${PKG_NAME}-${CHANGE}.sh"

  cat - "${RECIPE_DIR}/${CHANGE}.sh" << END_OF_MESSAGE > "${BASH_SCRIPT}"
#!/bin/bash -euo
export PKG_NAME=${PKG_NAME}
export PKG_VERSION=${PKG_VERSION}
export PKG_BUILDNUM=${PKG_BUILDNUM}
END_OF_MESSAGE

done

true
