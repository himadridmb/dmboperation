@echo off
:again
echo %USERNAME%
set VLCPATH=C:\Program Files\VideoLAN\VLC
echo %VLCPATH%
C:
cd \
cd Users
cd %USERNAME%
cd Desktop
cd dmbplayer
	TASKLIST /NH /FI  "IMAGENAME eq java.exe"> psid.txt
	FOR /F "tokens=2" %%I in (psid.txt ) DO set dmbprocess=%%I
	echo '%dmbprocess%'
		
	IF "%dmbprocess%"=="" GOTO NODMB
	IF %dmbprocess% ==[] GOTO NODMB
	IF %dmbprocess% =='' GOTO NODMB
	IF %dmbprocess% ==No GOTO NODMB

	echo DMB IS RUNNING
	GOTO END
:NODMB
	echo DMB is NOT RUNNING
	java -jar -Dvlcj.check=no -Djna.library.path="%VLCPATH%" -Xmx1000M -Xms1000M dmbplayer.jar
:END	

echo Checking each 60 sec 
ping -n 60 127.0.0.1 > nul
del psid.txt
set dmbprocess=''
goto again
pause