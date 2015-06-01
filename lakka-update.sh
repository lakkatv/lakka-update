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

rm -rf /tmp/Lakka-*

echo ":: Downloading upgrade"
wget -P /tmp/ $URL

if [ -z "/tmp/$FILE" ]; then
	echo "Something went wrong during the download."
	exit 1
fi

echo ":: Extracting $FILE"
tar xf /tmp/$FILE -C /tmp/

if [ -z "/tmp/$FOLDER/target" ]; then
	echo "Something went wrong during the extraction."
	exit 1
fi

mv /tmp/$FOLDER/target/* ~/.update/

echo ":: Done, you can now reboot"
