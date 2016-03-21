#!/bin/bash

MIRROR=http://sources.lakka.tv/nightly
PROJECT=@PROJECT@
ARCH=@ARCH@

FILE=`wget $MIRROR/${PROJECT}.${ARCH}/.index -q -O - | head -1`
URL=$MIRROR/${PROJECT}.${ARCH}/$FILE

rm -rf ~/.update/*

echo ":: Downloading upgrade"
wget -P ~/.update/ $URL

if [ -z "~/.update/$FILE" ]; then
	echo "Something went wrong during the download."
	exit 1
fi

echo ":: Done, you can now reboot"
