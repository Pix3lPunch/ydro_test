SRC_PATH=/package/src

#Cleanup
rm -r $SRC_PATH/debian

#Set env
PACKAGE_NAME=$(python3 setup.py --name)
PACKAGE_VERSION=$(python3 setup.py --version)
PACKAGE_LICENSE=$(python3 setup.py --license | tr '[:upper:]' '[:lower:]')
PACKAGE_EMAIL=$(python3 setup.py --author-email)
export DEBFULLNAME=$(python3 setup.py --author)

#Create CONTROL dummy
cd $SRC_PATH && dh_make -s -n -c $PACKAGE_LICENSE -p $PACKAGE_NAME"_"$PACKAGE_VERSION -e $PACKAGE_EMAIL --createorig -y

#Fill debian/control
PACKAGE_DESCRIPTION=$(python3 setup.py --description)
PYTHON_VER=3.8
DEPENDENCIES="python3 (>= 3.8), debhelper (>=7), dh-python, python3-setuptools"
sed -i "s/Description: .*/Description: $PACKAGE_DESCRIPTION/g" $SRC_PATH/debian/control
sed -i "s/Section: .*/Section: python/g" $SRC_PATH/debian/control
sed -i "s/Build-Depends: .*/Build-Depends: $DEPENDENCIES/g" $SRC_PATH/debian/control
sed -i "/Standars-Version:/a\XS-Version: $PYTHON_VER" $SRC_PATH/debian/control

#Fill debian/rules
sed -i "s/	dh $@.*/	dh \$@ --with python3 --buildsystem=pybuild/g" $SRC_PATH/debian/rules

#Fill compat
echo "12" > $SRC_PATH/debian/compat

