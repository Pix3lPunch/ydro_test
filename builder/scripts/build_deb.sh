#!/bin/bash

set -e

SRC_PATH="/build/src"

#Cleanup
if [ -d "$SRC_PATH/debian" ]; then
    rm -r "$SRC_PATH/debian"
fi

#Set env
cd "$SRC_PATH"
PACKAGE_NAME=$(python3 setup.py --name)
PACKAGE_VERSION=$(python3 setup.py --version)
PACKAGE_LICENSE=$(python3 setup.py --license | tr '[:upper:]' '[:lower:]')
PACKAGE_EMAIL=$(python3 setup.py --author-email)
export DEBFULLNAME=$(python3 setup.py --author)
export $(grep -v '^#' /build/.env | xargs)

#Install python requirements
python3 -m pip install -r requirements.txt

#Create debian/ dummy
dh_make -s -n -c "$PACKAGE_LICENSE" -p "${PACKAGE_NAME}_${PACKAGE_VERSION}" -e "$PACKAGE_EMAIL" --createorig -y

#Fill debian/control
PACKAGE_DESCRIPTION=$(python3 setup.py --description)
BUILD_DEPENDENCIES="python3 (>=${PYTHON_VER}), debhelper (>=7), dh-python, python3-setuptools"

sed -i "s/Description: .*/Description: $PACKAGE_DESCRIPTION/g" "$SRC_PATH/debian/control"
sed -i "s/Section: .*/Section: python/g" "$SRC_PATH/debian/control"
sed -i "s/Build-Depends: .*/Build-Depends: $BUILD_DEPENDENCIES/g" "$SRC_PATH/debian/control"
sed -i "/Standards-Version:/a\XS-Version: $PYTHON_VER" "$SRC_PATH/debian/control"

#Fill debian/rules
sed -i "s/\tdh \$@.*/\tdh \$@ --with python3 --buildsystem=pybuild/g" "$SRC_PATH/debian/rules"

#Fill compat
echo "$COMPAT_LEVEL" > "$SRC_PATH/debian/compat"

#Start build
dpkg-buildpackage

#Move package out
cp ../*.deb /package