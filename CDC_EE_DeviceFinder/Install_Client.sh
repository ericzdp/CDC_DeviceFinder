#!/bin/bash 

# Please read doc:README.txt to see overall introduction.

#........
# change the prefix of ip in the py
#........

# Find the path of this shell program 
curPath=$(readlink -f "$(dirname "$0")")
cd $curPath

client_app=${curPath}/app/deviceFinder_Client.py
host_app=${curPath}/app/deviceFinder_Host.py


clear
echo "---        CDC EE Device Finder        ---"
echo "---                  Installation  v1.0---"
echo "---                                Eric---"
echo " "
echo " Note: The default prefix of IP is 10 "
echo " "
echo " Enter 's' when IP is not '10.xxx' "
echo " Other input means skipping resetting IP prefix"
 
read -p ""  keyInput

# when enter 'Enter'
if [ -z "$keyInput" ]
then
	echo " Setting IP prefix: 10"
	ip_prefix='10'
#make 'y' and 'Y' both ok	  	
elif [ $keyInput = "s" ] || [ $keyInput = "S" ]
then
	read -p " Please input the new prefix of ip: " ip_prefix

  	#ensure enter a number with a cyclic judgment structure
	#the following will set up when enter a number
  	until [ -n "$(echo ${ip_prefix}| sed -n "/^[0-9]\+$/p")" ]
  	do 

  	echo " "	
  	echo "Please input as an number" 
  	read -p " Please input the new prefix of ip: " ip_prefix	
   
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
# Copy the install folder to install
#........


source_folder=${curPath}/app
target_folder=/home/Client_DeviceFinder

# Create the install folder
mkdir -p ${target_folder}

cd ${source_folder}
# Copy the python file into destination folder
for file in `ls | find ${source_folder} -name '*.py'` ; do
	cp -r $file ${target_folder}
done  

# Copy the sh that can enable the program to run automatically 
cp -r ${curPath}/install_part/Auto.sh ${target_folder}
# Copy the uninstall part 
cp -r ${curPath}/install_part/Remove_Client_Instruction.txt ${target_folder}
cp -r ${curPath}/Remove_Client.sh ${target_folder}





#........
# Backup the rc.local
#........


# Backup the rc.local
# Can use"sudo nano etc/rc.local"to recover manually 
cp /etc/rc.local ${target_folder}/rc.local.backup






#........
# Change the rc.local to enable the py program run automatically after boot
#........


# Find the line number, where has 'exit 0' 
n=`grep -n  "exit 0" /etc/rc.local | sed -n '2p' | cut -d ':'  -f 1`
# Make the program running automatically after boot
insertContent='/home/Client_DeviceFinder/Auto.sh \nexit 0'
# Delete the 'exit 0' and  insert the rc.local,two steps because of the system
sed -i "${n}d"  /etc/rc.local && sed -i "${n}i ${insertContent}" /etc/rc.local



# Grant permissions to the program

chmod +x ${target_folder}/Auto.sh

# Run the Client of py program
sh ${target_folder}/Auto.sh


echo " "
echo "The program 'Device_Finder_Clinent' is installed"
echo "You can find the install folder in ${target_folder}"





#Eric 
#2022.8.5




