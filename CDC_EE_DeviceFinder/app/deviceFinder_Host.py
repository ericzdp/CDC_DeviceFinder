# coding=UTF-8 
import socket, struct, fcntl,os,psutil,time


# use the prefix of ip to choose the internet card
def Get_broadcast_ip(prefix):
    
    localIP = ''
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
                broadcast_ip = dict_ifconfig[internet_card][0].broadcast
                
    return broadcast_ip
    '''
    dict_ifconfig---internet_card_1---snicaddr_ip
                                   ---snicaddr_ipv6
                                   ---snicaddr_ipv4_mac
                                   
                 ---internet_card_2---snicaddr_ip
                                   ---snicaddr_ipv6
                                   ---snicaddr_ipv4_mac
                
                 ............
                 

    '''
    

#  first step,send the message
def Send():

    # socket.AF_INET - ipv4  ,  socket.SOCK_DGRAM -  udp
    socket_send = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    #make a broadcast ip and port
    ip_port_sending_to = (broadcast_ip, port_Send_to)
    #solve the permission problem
    socket_send.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
    socket_send.setsockopt(socket.SOL_SOCKET,socket.SO_BROADCAST,1)
    #bind the send port(the host)
    socket_send.bind(('',8085))
    # msg is the information you send
    msg = 'whostheree?'
    # send the information
    socket_send.sendto(msg.encode('utf-8'),ip_port_sending_to)
    socket_send.close()



def Show_in_beginning():
    
    os.system('clear')
    print('--    CDC EE Device Finder    --')
    print('--                  Host v1.0 --')
    print('--                       Eric --')
    print('--Broadcast ip:' + ' ' + broadcast_ip)
    print('--Sending port:' + ' ' + str(port_Send_to))
    print(' ')


def Align_ResultTitle(information_str):
    #split the information
    information_split = information_str.split('/')
    # caculate the number of ' '
    name_long = int(len(information_split[0])-len('hostname'))
    ip_long =int(len(information_split[1])-len(' Ip addresss '))
    #aligning the information
    showing='Hostname'+' '*name_long+'/ Ip addresss '+' '*ip_long+'/ Mac address'
    
    return showing


ip_prefix = '10'

port_Listen = 8081  
port_Send_to = 8082




broadcast_ip = Get_broadcast_ip(ip_prefix)
Show_in_beginning()



while True:
    print(' ')
    print('--Wait message from Client--')


    # Define socket for listening & sending
    socket_listen = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
     # '' is the ip ,when you want to receive ,it can be empty
     # when it ''is empty,it will receive information from all the ip
     # port must set 
    local_addr = (('', port_Listen))

    # Bind listen port to socket
    socket_listen.bind(local_addr)
    # set the time_out time ,3 means 3 seconds
    socket_listen.settimeout(3)


    Send()

    try:
        # define time
        now = time.time()

        recv_msg = socket_listen.recvfrom(2048)
        # 1024 can control how much information it can receive
        # most of tiem ,2048 is enough,you can also set it at 2048
        showing_basic = Align_ResultTitle(recv_msg[0].decode('utf-8'))
        
        print('----------------------------')
        print('Get the information:')
        print('   ' + str(showing_basic))
        #print('   ' + 'Hostname / Ip addresss / Mac address')
        print('   ' + recv_msg[0].decode('utf-8'))
        print(' ')

        socket_listen.close()


    except socket.timeout:
        print('Time out')

    x = input('Write "r" to restart,or "c" to close \n')

    if x == 'r':
        continue
    elif x == 'c':
        break
