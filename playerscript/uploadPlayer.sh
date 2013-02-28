#!/bin/sh
SCRIPT_DIRECTORY='/home/street/Developer/DMBToServer/'
DIST_DIRECTORY=/home/street/workspace/LinuxNewFeatureDMB/dist/
CLOG_DIRECTORY=/home/street/workspace/LinuxNewFeatureDMB/

cd $SCRIPT_DIRECTORY
chmod a+x *.sh
tar cvzfp install_linuxplayer.tar.gz install_linuxplayer.sh
tar cvzfp install_macplayer.tar.gz install_macplayer.command RestartPlayerMac.command
mv install*player.tar.gz $DIST_DIRECTORY

cd $DIST_DIRECTORY
rm linuxplayer.tar.gz
rm macplayer.tar.gz
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


# FTP INFO
HOST='ftp.abcde.com'
USER='programmer@abcde.com'
PASSWD='abcde'

FILE1=$DIST_DIRECTORY'linuxplayer.tar.gz'
FILE2=$DIST_DIRECTORY'macplayer.tar.gz'
FILE3=$CLOG_DIRECTORY'changelog.xml'
FILE4=$DIST_DIRECTORY'install_linuxplayer.tar.gz'
FILE5=$DIST_DIRECTORY'install_macplayer.tar.gz'
#FILE6='/var/www/dmb/newplayer/index.php'

# TODO: upload player webpage from this script as well.

# Start FTP Connection
ftp -n $HOST <<END_SCRIPT
	quote USER $USER
	quote PASS $PASSWD
    binary
    verbose
	cd /player/
	put $FILE3 ./changelog.xml
	put $FILE4 ./install_linuxplayer.tar.gz
	put $FILE5 ./install_macplayer.tar.gz
    put $FILE6 ./index.php
	cd /yang/newplayer/
	put $FILE1 ./linuxplayer.tar.gz
	put $FILE2 ./macplayer.tar.gz
	exit
END_SCRIPT

