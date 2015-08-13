#!/bin/bash

MIRROR=http://sources.lakka.tv/nightly
PROJECT=@PROJECT@
ARCH=@ARCH@

echo ":: Getting latest update information"
FILE=`wget $MIRROR/${PROJECT}.${ARCH}/ -q -O - | grep -E "\-[A-Za-z0-9]{8}.tar[^\.]" | sed -e 's/^.*\(Lakka.*\.tar\).*$/\1/g' | sort -r | head -1`
FOLDER=${FILE%.*}

if [ -z "$FILE" ]; then
	echo "Something went wrong in getting the update list. Check your internet connexion."
	exit 1
fi

URL=$MIRROR/${PROJECT}.${ARCH}/$FILE

rm -rf ~/.update/*

echo ":: Downloading upgrade"
wget -P ~/.update/ $URL

if [ -z "~/.update/$FILE" ]; then
	echo "Something went wrong during the download."
	exit 1
fi

echo ":: Extracting $FILE"
tar xf ~/.update/$FILE -C ~/.update/

if [ -z "~/.update/$FOLDER/target" ]; then
	echo "Something went wrong during the extraction."
	exit 1
fi

mv ~/.update/$FOLDER/target/* ~/.update/
rm -rf ~/.update/$FILE/
rm -rf ~/.update/$FOLDER/

echo ":: Done, you can now reboot"
