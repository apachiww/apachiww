# Config files located at /etc/NetworkManager/system-connections
#
# Root privilege required
#
#!/usr/bin/bash

echo "
	#################################
	#                               #
	# Configure your NetworkManager #
	# for eduroam at UoB            #
	#                               #
	#################################
"

if [ $UID -ne 0 ]
then
	echo "Please run as root"
	exit 1
fi
echo "Interfaces found: "
ls /sys/class/net
read -p "Your wireless interface (full name): " W_INTERFACE
read -p "Your email (xxxxxx@student.bham.ac.uk): " LOG_EMAIL
read -p "Your password: " LOG_PASSWD

nmcli con add \
	type wifi \
	con-name "eduroam" \
	ifname $W_INTERFACE \
	ssid "eduroam" \
	wifi-sec.key-mgmt "wpa-eap" \
	802-1x.identity $LOG_EMAIL \
	802-1x.password $LOG_PASSWD \
	802-1x.system-ca-certs "yes" \
	802-1x.domain-suffix-match "wifi.bham.ac.uk" \
	802-1x.eap "peap" \
	802-1x.phase2-auth "mschapv2"
