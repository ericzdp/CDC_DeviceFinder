#!/bin/bash

# Please read doc:README.txt to see overall introduction.


#........
# Make sure the default ip_prefix in python file is 10
#........


clear

# Find the path of this shell program 
curPath=$(readlink -f "$(dirname "$0")")
cd $curPath

client_app=${curPath}/app/deviceFinder_Client.py
host_app=${curPath}/app/deviceFinder_Host.py

# The default prefix of IP is 10 
ip_prefix="10"

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
target_folder=/home/Host_DeviceFinder

# Create the install folder
mkdir -p ${target_folder}

cd ${source_folder}
# Copy the python file into destination folder
for file in `ls | find ${source_folder} -name '*.py'` ; do
	cp -r $file ${target_folder}
done  

# Copy the sh that can enable the Host of program to run 
cp -r ${curPath}/install_part/Run_Host_DeviceFinder.sh ${target_folder}
# Copy the instruction file
cp -r ${curPath}/install_part/Host_Instruction.txt ${target_folder}
# Copy the remove shell program
cp -r ${curPath}/Remove_Host.sh ${target_folder}




echo "The program 'Device_Finder_Host' is installed"
echo "You can find the install folder in ${target_folder}"







#Eric 
#2022.8.5


