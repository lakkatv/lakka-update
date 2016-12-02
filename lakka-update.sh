#!/bin/bash

source /etc/os-release

MIRROR=http://mirror.lakka.tv/nightly

FILE=`wget $MIRROR/${OPENELEC_ARCH}/.index -q -O - | head -1`
URL=$MIRROR/${OPENELEC_ARCH}/$FILE

rm -rf ~/.update/*

echo ":: Downloading upgrade"
wget -P ~/.update/ $URL

if [ -z "~/.update/$FILE" ]; then
	echo "Something went wrong during the download."
	exit 1
fi

echo ":: Done, you can now reboot"
