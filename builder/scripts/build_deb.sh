#!/bin/bash

set -e

# Cleanup
if [ -d "$MODULE_SRC/debian" ]; then
    rm -r "$MODULE_SRC/debian"
fi

# Set env
cd "$MODULE_SRC"

# Gathering variables
PACKAGE_NAME=$(python3 setup.py --name)
PACKAGE_VERSION=$(python3 setup.py --version)
PACKAGE_LICENSE=$(python3 setup.py --license | tr '[:upper:]' '[:lower:]')
PACKAGE_EMAIL=$(python3 setup.py --author-email)
PACKAGE_DESCRIPTION=$(python3 setup.py --description)
export DEBFULLNAME=$(python3 setup.py --author)

# Install python requirements
python3 -m pip install -r requirements.txt

# Create debian/ dummy
dh_make -s -n -c "$PACKAGE_LICENSE" -p "${PACKAGE_NAME}_${PACKAGE_VERSION}" -e "$PACKAGE_EMAIL" --createorig -y

# Fill debian/control
sed -i "s/Description: .*/Description: $PACKAGE_DESCRIPTION/g" "$MODULE_SRC/debian/control"
sed -i "s/Section: .*/Section: python/g" "$MODULE_SRC/debian/control"
sed -i "/^Depends:/ s/$/, $DEPENDENCIES/" "$MODULE_SRC/debian/control"
sed -i "s/Build-Depends: .*/Build-Depends: $BUILD_DEPENDENCIES/g" "$MODULE_SRC/debian/control"
sed -i "/Standards-Version:/a\XS-Version: $PYTHON_VER" "$MODULE_SRC/debian/control"

# Fill debian/rules
sed -i "s/\tdh \$@.*/\tdh \$@ --with python3 --buildsystem=pybuild/g" "$MODULE_SRC/debian/rules"

# Fill debian/compat
echo "$COMPAT_LEVEL" > "$MODULE_SRC/debian/compat"

# Start build
dpkg-buildpackage

# Move package out
cp /build/*.deb /package