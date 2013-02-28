@echo off
taskkill /f /im java.exe
:again
echo %USERNAME%
set VLCPATH=C:\Program Files\VideoLAN\VLC
echo %VLCPATH%
C:
cd \
cd "Documents and Settings"
cd %USERNAME%
cd Desktop
cd dmbplayer
	TASKLIST /NH /FI  "IMAGENAME eq java.exe"> psid.txt
	FOR /F "tokens=2" %%I in (psid.txt ) DO set dmbprocess=%%I
	echo dmbprocessid='%dmbprocess%'
		
	IF "%dmbprocess%"=="" GOTO NODMB
	IF %dmbprocess% ==[] GOTO NODMB
	IF %dmbprocess% =='' GOTO NODMB
	echo DMB IS RUNNING
	GOTO END
:NODMB
	echo DMB is NOT RUNNING
	java -jar -Dvlcj.check=no -Djna.library.path="%VLCPATH%" -Xmx1524M -Xms1024M dmbplayer.jar
:END	

echo Checking each 10 sec 
ping -n 10 127.0.0.1 > nul
del psid.txt
set dmbprocess=''
goto again
pause