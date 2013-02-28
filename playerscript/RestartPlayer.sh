#!/bin/bash
export XUGGLE_HOME=/usr/local/xuggler
export LD_LIBRARY_PATH=$XUGGLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$XUGGLE_HOME/bin:$PATH

while true
do 
  ps -ef | grep -v grep | grep dmbplayer

  if [ $? -eq 1 ]
  then
        echo "Not running so starting the player"
	cd ~/Desktop/dist
	java -Dvlcj.check=no -Xms1024M -Xmx1024M -jar dmbplayer.jar	
   else
        echo "Running"	
  fi
  sleep 300

done
