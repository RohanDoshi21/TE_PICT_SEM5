from socket import *

HOST = 'localhost'
PORT = 5555

# AF_INET refers to the address family ipv4
# SOCK_STREAM means connection oriented TCP protocol
server_socket = socket(AF_INET, SOCK_STREAM)
server_socket.connect((HOST,PORT))


data = ""

while data != "exit":
    input_str = input()
    server_socket.sendall(bytes(input_str, encoding='utf8'))
    data = server_socket.recv(1024)
    data = data.decode()
    print(f'Received: {data}')

server_socket.close()


