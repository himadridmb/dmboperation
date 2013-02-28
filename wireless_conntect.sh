#! /bin/bash
#--------------------variable parameter ---------------------
#------------------------------------------------------------
INTERFACE=eth1
SSID=UNOapp
PSK=4166288553
#---------------------Fixed parameter -----------------------
#------------------------------------------------------------
WPAFILE=/etc/wpa_supplicant.conf

#--------------------- App command to execute --------------
#---- Check if wpa configuration file exists or not --------

if [ -f $WPAFILE ];
then
	echo "WPA file already exists no need to create new"
else
	echo "Create a new WPA configuration file"
	sudo -s wpa_passphrase $SSID $PSK > /etc/wpa_supplicant.conf
fi

while true
do
	ping -c 1 google.com | grep -i '1 packets transmitted'

	if [ $? -eq 1 ]
	then
		echo "No internet connection"
		echo "connecting to network ------>>>>>>>>>"
		sudo -s ifconfig $INTERFACE down
		sudo -s ifconfig $INTERFACE up
		sudo -s iwlist $INTERFACE scan
		sudo -s wpa_supplicant -B -D wext -i $INTERFACE  -c $WPAFILE
		sudo -s dhclient -r $INTERFACE
		sudo -s ifconfig  $INTERFACE up
		sudo -s dhclient $INTERFACE

#------- ------------- checking internet connection -----------

		ping -c 1 google.com | grep -i '1 packets transmitted'
		if [ $? -eq 1 ]
		then
			echo "---Failed to connect to internet :("
		else
			echo "connected to internet :)"
		fi

	else
		echo "already connected to internet"
	fi

echo "checking every thirty minutes"
sleep  1800
done

