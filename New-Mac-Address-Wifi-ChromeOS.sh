sudo ifconfig wlan0 down
echo fa:55:3d:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10] | sudo ifconfig wlan0 hw ether tee
sudo ifconfig wlan0 up
