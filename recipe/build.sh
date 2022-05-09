#!/bin/bash -euo

# Copy the [de]activate scripts to ${PREFIX}\etc\conda\[de]activate.d.
# This causes them to be run on environment [de]activation.
# https://github.com/mamba-org/mamba/blob/master/libmamba/src/core/activation.cpp#L32-L47

for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    BASH_SCRIPT="${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}-${CHANGE}.sh"
    {
        printf "#!/bin/bash -euo\n"
        echo "export PKG_NAME=${PKG_NAME}"
        echo "export PKG_VERSION=${PKG_VERSION}"
        echo "export PKG_BUILDNUM=${PKG_BUILDNUM}"
        cat "${RECIPE_DIR}/${CHANGE}.sh"
    } > "BASH_SCRIPT"
done

exit 0
