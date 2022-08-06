###########################################################################

Instructions of Client_DeviceFinder:

###########################################################################




---------------------------------------------------------------------------
---------------------------------------------------------------------------
When you want this Raspberry Pi can be found by another device on the LAN ,
and then send the hostname,ip,mac back,you can use the "Install_Client.sh".



---------------------------------------------------------------------------
The Using Steps of "Install_Client.sh":

1: Open a terminal.

2: Input the "sudo sh" and the path of "Install_Client.sh".
   EXAMPLE: "sudo sh /home/pi/CDC_EE_DeviceFinder/install_Client.sh".

3: Press the "Enter" on the keyboard. 

4: When you are in office, the deafult prefix of ip is 10, you can use the 
   command "ifconfig" in another terminal to confirm. If you make sure
   that the "10" is correct, you can press anyt button except the 'y' or 
   'Y', and the program will run with the default ip_prefix '10'.you will 
   see the word"Keep the dafault prefix of IP: 10" 

5: If you want to change the default ip_prefix, you can follow instruction
   in the terminal, press 'y' or 'Y' to get the changing options.
   Tips: the ip_prefix is a number such like 10 ,192

6: The install will finish after you see the information "The program 
   'Device_Finder_clinent' is installed, please reboot " on the terminal.

7: Reboot the device. 

---------------------------------------------------------------------------
Attention:

1: To ensure the program running correctly, you should not change anything
   in the folder "CDC_EE_DeviceFinder"

2: At present, the program is designed for Raspberry Pi, the program will 
   cause errors on other types of devices.

3: The set of the prefix of ip can not be change, unless you use the 
   "Remove_Client.sh" to go back to the pre_installation situation, and 
   then install the program again. 

4: The program can automatically after the device is turned on, you do not 
   need to install it after you reboot every time. 

5: When you meet any unexcepted event during the installation process, you 
   can use the "Remove_Client.sh" to go back to the pre_installation 
   situation, and then installl the program from the beginning.



---------------------------------------------------------------------------
The tips:

After installation, you can find the install folder and the log of program
in the path"/home". You can also get the backups of rc.local in the 
install folder and its name is "rc_local_backups.txt"





---------------------------------------------------------------------------
---------------------------------------------------------------------------
When you want to removet the program and go back to the pre_installation 
situation, you can use the "remove_Client.sh".


The Using Steps of "Remove_Client.sh": 

1: Open a terminal.

2: Input the "sudo sh" and the path of "Remove_Client.sh".
   EXAMPLE: "sudo sh /home/pi/CDC_EE_DeviceFinder/Remove_Client.sh".

3: The uninstall will finish after you see the information "The program
   'Device_Finder_clinent' is removed from your device" on the terminal.














###########################################################################

Instructions of Host_DeviceFinder:

###########################################################################




---------------------------------------------------------------------------
---------------------------------------------------------------------------
When you want your Raspberry Pi can get hostname,ip,mac from other devices,
you can use the "Install_Host.sh".



---------------------------------------------------------------------------
The Using Steps of "Install_Host.sh":

1: Open a terminal.

2: Input the "sudo sh" and the path of "Install_Host.sh".
   EXAMPLE: "sudo sh /home/pi/CDC_EE_DeviceFinder/install_Host.sh".

3: Press the "Enter" on the keyboard. 

4: When you are in office, the deafult prefix of ip is 10, you can use the 
   command "ifconfig" in another terminal to confirm. If you make sure
   that the "10" is correct, you can press anyt button except the 'y' or 
   'Y', and the program will run with the default ip_prefix '10'.you will 
   see the word"Keep the dafault prefix of IP: 10" 

5: If you want to change the default ip_prefix, you can follow instruction
   in the terminal, press 'y' or 'Y' to get the changing options.
   Tips: the ip_prefix is a number such like 10 , 192 , 127

6: Installation will be fininshed after you see "The program 
   'Device_Finder_Host' is installed" in the treminal.





---------------------------------------------------------------------------
---------------------------------------------------------------------------
When you want to remove the Host_DeceiveFinder,you can use "Remove_Host.sh"

1: Open a terminal.

2: Input the "sudo sh" and the path of "Run_Host_DeviceFinder.sh".
   EXAMPLE: "sudo sh /home/Host_DeviceFinder/Run_Host_DeviceFinder.sh".

3: Press the "Enter" on the keyboard. 

4: The uninstall will finish after you see the information "The program
   'Device_Finder_host' is removed from your device" on the terminal.







#Eric 
#2022.8.2




