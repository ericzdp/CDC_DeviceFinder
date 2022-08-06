#!/bin/bash

# Please read doc:README.txt to see overall introduction.

clear

# Remove the auto_running information from rc.local 
sed -i '\/home\/Client_DeviceFinder\/Auto.sh/d' /etc/rc.local

# Remove the install folder
rm -rf /home/Client_DeviceFinder

# Kill the py program in the background
pid=`ps aux | grep "deviceFinder_Client.py" | sed -n '1p' | awk '{print $2}'`
kill $pid

echo "The program 'Device_Finder_clinent' is removed from your device"




#Eric 
#2022.8.5