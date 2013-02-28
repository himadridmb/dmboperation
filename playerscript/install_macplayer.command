#!/bin/bash
cd ~/Desktop

XUGGLER_FILE="xuggle-xuggler.3.4.1012-i386-apple-darwin9.8.0.sh"
SERVER_ADDR="http://www.digitalmarketingbox.com"
export XUGGLE_AUTOACCEPT_LICENSE=TRUE

curl -O $SERVER_ADDR/yang/newplayer/macplayer.tar.gz
tar xvfz macplayer.tar.gz
#chmod +x dmbplayer.app/Contents/MacOS/JavaApplicationStub

#download xuggler
if [ ! -d "/usr/local/xuggler" ]; then
	if [ ! -f $XUGGLER_FILE ]; then
	    curl -O $SERVER_ADDR/yang/macplayer/backup/environment.plist
	    curl -O $SERVER_ADDR/yang/macplayer/backup/profile

	    mkdir ~/.MacOSX/
	    sudo mv -f environment.plist ~/.MacOSX/
	    sudo mv -f profile ~/.profile

	    curl -O http://com.xuggle.s3.amazonaws.com/xuggler/xuggler-3.4.FINAL/xuggle-xuggler.3.4.1012-i386-apple-darwin9.8.0.sh
	fi

	#install xuggler
	sudo mkdir /usr/local
	sudo rm -rf /usr/local/xuggler
	chmod a+x $XUGGLER_FILE
	sudo -E ./$XUGGLER_FILE <<EOF
	^M
	y
	/usr/local/xuggler
EOF
fi

#clean up
rm macplayer.tar.gz
chmod a+x RestartPlayerMac.command
open RestartPlayerMac.command
exit
