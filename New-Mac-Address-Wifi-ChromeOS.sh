hexchars="0123456789ABCDEF"
end=$( for i in {1..6} ; do echo -n ${hexchars:$(( $RANDOM % 16 )):1} ; done | sed -e 's/\(..\)/:\1/g' )
MAC=fa-55-3d$end

ifconfig wlan0 down
ifconfig wlan0 hw ether $MAC
ifconfig wlan0 up
 
echo $MAC
echo "Changed"
