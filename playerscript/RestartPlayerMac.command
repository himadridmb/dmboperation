#!/bin/bash -x
while true;do
    ps -ef | grep -v grep | grep dmbplayer
    if [ $? -eq 1 ];
    then
        echo "Not running so starting the player"
        cd ~/Desktop
        osascript -e 'tell application "./dmbplayer.app" to activate'
    else
        echo "Running"
	echo "run"	
fi
sleep 300
done