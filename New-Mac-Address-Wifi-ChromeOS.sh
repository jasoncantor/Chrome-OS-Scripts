sudo ifconfig wlan0 down
sudo ifconfig wlan0 hw ether 'printf 'fa-55-3d-%02X-%02X-%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]'
sudo ifconfig wlan0 up
