# coding=UTF-8 
import socket, struct, fcntl,os,psutil,time

def Get_ip_mac(prefix):
    
    localIP = ''
    mac = ''
    #use psutil to get the internet card states,equal to 'ifconfig'
    dict_ifconfig = psutil.net_if_addrs()
    #internet_card are the key of the dictionary
    for internet_card in dict_ifconfig:#class <dict>
        #divide information by internet card
        #each internet card can have 3 snicaddress as usual
        snicList = dict_ifconfig[internet_card]
        #divide information by snicaddress
        for snic in snicList:
            ip = snic.address
            if ip.startswith(prefix):
                localIP = ip
                #0 is the ip ,1 is the ipv6 mac,2 is ipv4 mac
                mac = dict_ifconfig[internet_card][2].address

    result_ip_mac = [localIP, mac]
    return result_ip_mac
    '''
    dict_ifconfig---internet_card_1---snicaddr_ip
                                   ---snicaddr_ipv6
                                   ---snicaddr_ipv4_mac
                                   
                 ---internet_card_2---snicaddr_ip
                                   ---snicaddr_ipv6
                                   ---snicaddr_ipv4_mac
                
                 ............
                 
                 

    '''



def Listen():
    #mac can not change ,put it ouf of circulation
    [ip, mac] = Get_ip_mac(ip_prefix)
    
    print('   Cline ip:' + ' ' + ip)
    print('   Listen on port:' + ' ' + str(port_Listen))
    print(' ')

    # Define socket for listening & sending
    socket_Client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    # Bind listen port to socket
    socket_Client.bind(('', port_Listen))

    # Get data from this socket
    recv_msg = socket_Client.recvfrom(1024)
    ip_Remote = recv_msg[1][0]
    port_Remote = recv_msg[1][1]
    data_Rev = recv_msg[0].decode("utf-8")  # str
    socket_Client.close()

    # second step ,when we receive the right password,send information to it
    if data_Rev == token:
        [ip, mac] = Get_ip_mac(ip_prefix)
        print('   Get the message:' + ' ' + data_Rev)
        print('   From host:' + ' ' + ip_Remote + ' @ ' + str(port_Remote))

        # make all the information in one list
        basic_information = (hostname + ' / ' + ip + ' / ' + mac).encode('utf-8')

        print('   Send:' + ' ' + str(basic_information.decode('utf-8')))
        socket_Send = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        # send this basic_information
        socket_Send.sendto(basic_information, (ip_Remote, port_Send_to))
        print('   Send to:' + ip_Remote + ' @ ' + str(port_Send_to))

        socket_Send.close()
 

def Show_in_beginning():
    
    os.system('clear')
    print('--    CDC EE Device Finder    --')
    print('--                Client v1.0 --')
    print('--                       Eric --')
    print('-- MAC:' + ' ' + mac)
    print('-- HostName:' + ' ' + hostname)
    print(' ')
    print(' ')




ip_prefix = '10'

hostname = socket.gethostname()
mac = Get_ip_mac(ip_prefix)[1]

token = 'whostheree?'

port_Send_to = 8081
port_Listen = 8082

Show_in_beginning()


# the variable used to count
i = 1

while True:
    print('--Waiting message from Host--')
    Listen()

    print('   Index: ' + str(i))
    print(' ')
    i = i + 1
