#!/bin/bash

set -ex

cd "$(dirname "$0")"

WORKING_LOCATION="$(pwd)"
APPLICATION_NAME="permasigneriOS"
BUILD_VERSION=1.0.6

rm -rf *.deb
rm -rf build || true
mkdir build
mkdir build/Applications
mkdir build/Applications/$APPLICATION_NAME.app

cp -r ./*.lproj ./build/Applications/$APPLICATION_NAME.app
cp -r ./DEBIAN ./build
sed -i '' "s/@@VERSION@@/$BUILD_VERSION/g" ./build/DEBIAN/control

PKG_NAME="com.powen.permasignerios.localizations.$BUILD_VERSION.deb"
find . -name '.DS_Store' -type f -delete

dpkg-deb -b ./build ./$PKG_NAME

echo "Package is at $WORKING_LOCATION/$PKG_NAME"
