#!/bin/bash

# Please read doc:README.txt to see overall introduction.

clear

#........
# Change the prefix of ip in the python file
#........

# Find the path 
curPath=$(readlink -f "$(dirname "$0")")
cd $curPath

client_app=${curPath}/deviceFinder_Client.py
host_app=${curPath}/deviceFinder_Host.py


clear
echo "---        CDC EE Device Finder        ---"
echo "---                  Host_Setting  v1.0---"
echo "---                                Eric---"
echo " "
echo " Note: The default prefix of IP is 10 "
echo " "
echo " Enter 's' when IP is not '10.xxx' "
echo " Other input means skipping resetting IP prefix"

read -p ""  keyInput

#when enter 'Enter'
if [ -z "$keyInput" ]
then
	echo " Setting IP prefix: 10"
	ip_prefix='10'
# Make 's' and 'S' both ok	  	
elif [ $keyInput = "s" ] || [ $keyInput = "S" ]
then
	read -p " Please input the new prefix of ip: " ip_prefix

  	#ensure enter a number with a cyclic judgment structure
	#the following will set up when enter a number
  	until [ -n "$(echo ${ip_prefix}| sed -n "/^[0-9]\+$/p")" ]
  	do 

  	echo " "	
  	echo "Please Write an number" 
  	read -p "Input the new prefix of ip: " ip_prefix	
   
  	done 	

# The other input
else
  	echo " Setting IP prefix: 10"
	ip_prefix='10' 
fi


# Index of code line for the ip_prefix inside the py app
ip_host_LineNumber=83
ip_client_LineNumber=94

# Create the insert information of the python file
insertContent="ip_prefix = '${ip_prefix}'"

# Remove the orginal information of the ip_prefix and insert the new one 
sed -i "${ip_host_LineNumber}d"  ${host_app} && sed -i "${ip_host_LineNumber}i ${insertContent}" ${host_app}
sed -i "${ip_client_LineNumber}d"  ${client_app} && sed -i "${ip_client_LineNumber}i ${insertContent}" ${client_app}





#........
# Run the Host python file
#........

python ${host_app}



#Eric 
#2022.8.5

