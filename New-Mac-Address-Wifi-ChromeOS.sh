#sudo ifconfig wlan0 down
#sudo ifconfig wlan0 hw ether echo fa:55:3d:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]
#sudo ifconfig wlan0 up
current_date=$(date)
echo "Today is $current_date"
