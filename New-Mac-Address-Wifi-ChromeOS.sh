sudo ifconfig wlan0 down
mac_address='echo fa:55:3d:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]'
sudo ifconfig wlan0 hw ether $mac_address
sudo ifconfig wlan0 up
echo "Changed"
