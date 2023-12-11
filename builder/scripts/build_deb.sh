SRC_PATH=/build/src
PACKAGE_PATH=/package
cd /package && rm -r *
cp -R /build/src /package
cd /package/src && python3 -m pip install -r requirements.txt
cd /package/src && /scripts/make_debian.sh
cd /package/src && dpkg-buildpackage
cd /package && rm -r ./src