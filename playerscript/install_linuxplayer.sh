#!/bin/bash
SKIP_DOWNLOAD=${1}
#TO BE DELETED AFTER TESTING
#sudo rm -rf /usr/local/xuggler

cd ~/Desktop

XUGGLER_FILE="xuggle-xuggler.3.4.1012-i686-pc-linux-gnu.sh"
SERVER_ADDR="http://www.digitalmarketingbox.com"
export XUGGLE_AUTOACCEPT_LICENSE=TRUE

if ! [[ -n $SKIP_DOWNLOAD ]] ; then 
    echo "downloading the new install script";
    rm install_linuxplayer.tar.gz
    wget $SERVER_ADDR/player/install_linuxplayer.tar.gz
    tar xvfz install_linuxplayer.tar.gz
    chmod a+x install_linuxplayer.sh
    ./install_linuxplayer.sh SKIP_DOWNLOAD
    exit
fi

rm linuxplayer.tar.gz
wget $SERVER_ADDR/yang/newplayer/linuxplayer.tar.gz
mkdir dist
cd dist
tar xvfz ../linuxplayer.tar.gz
cd ..

if [ ! -d "/usr/local/xuggler" ]; then
#download xuggler
if [ ! -f $XUGGLER_FILE ]; then
	wget http://com.xuggle.s3.amazonaws.com/xuggler/xuggler-3.4.FINAL/xuggle-xuggler.3.4.1012-i686-pc-linux-gnu.sh
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
chmod a+x RestartPlayer.sh
./RestartPlayer.sh

