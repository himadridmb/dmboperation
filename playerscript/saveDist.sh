#!/bin/bash
VERSION=${1}

SCRIPT_DIRECTORY='/home/street/Developer/DMBToServer/'
DIST_DIRECTORY=/home/street/workspace/LinuxNewFeatureDMB/dist/

if ! [[ -n $VERSION ]] ; then
    echo "Please set a version"
    exit 0
fi

DEST_PATH=~/Developer/dmbplayer_versions/
SOURCE_PATH=~/workspace/LinuxNewFeatureDMB/dist

cd $SOURCE_PATH
rm linuxplayer.tar*
rm macplayer.tar*
cd linuxplayer
cp $SCRIPT_DIRECTORY"install_linuxplayer.sh" .
cp $SCRIPT_DIRECTORY"RestartPlayer.sh" .
tar cvzfp linuxplayer.tar.gz dmbplayer_lib/ dmbplayer.jar install_linuxplayer.sh RestartPlayer.sh
cp -rf linuxplayer.tar.gz ..
cd ../macplayer
cp $SCRIPT_DIRECTORY"install_macplayer.command" .
cp $SCRIPT_DIRECTORY"RestartPlayerMac.command" .
tar cvzfp macplayer.tar.gz dmbplayer.app install_macplayer.command RestartPlayerMac.command
cp -rf macplayer.tar.gz ..

cd $DEST_PATH
if [[ -d $VERSION ]] ; then
    echo "a copy of the distribution already exists."
    exit 0
fi

mkdir $VERSION
cp -rf $SOURCE_PATH/* $VERSION/


# FTP INFO
HOST='ftp.abced.com'
USER='abcdef@abced.com'
PASSWD='abced'

# Start FTP Connection
ftp -n $HOST <<END_SCRIPT
	quote USER $USER
	quote PASS $PASSWD
    binary
    verbose
	cd /yang/newplayer/
    mkdir $VERSION/
    cd $VERSION
    lcd ~/Developer/dmbplayer_versions/$VERSION
    put linuxplayer.tar.gz
    put macplayer.tar.gz
	exit
END_SCRIPT
