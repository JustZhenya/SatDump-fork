#!/bin/sh

echo Creating directory structure
DIR=satdump_debian_$2
mkdir $DIR
mkdir $DIR/DEBIAN

echo Creating package info
echo Package: satdump >> $DIR/DEBIAN/control
echo Version: 1.2.3$BUILD_NO >> $DIR/DEBIAN/control
echo Maintainer: just_zhenya >> $DIR/DEBIAN/control
echo Architecture: $2 >> $DIR/DEBIAN/control
echo Description: A generic satellite data processing software >> $DIR/DEBIAN/control
echo Depends: $3 >> $DIR/DEBIAN/control
echo Recommends: $4 >> $DIR/DEBIAN/control

echo Copying files
ORIG_DIR=$PWD
cd $1
make install DESTDIR=$ORIG_DIR/$DIR
cd $ORIG_DIR

echo Creating package
dpkg-deb --build $DIR
