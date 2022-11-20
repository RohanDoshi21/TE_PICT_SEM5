from socket import *
from threading import *

def func(clientsock, addr):
    while 1:
        data = clientsock.recv(1024)
        data = data.decode()
        print(f"Received {data} from {addr}")
        clientsock.send(bytes(data, encoding='utf8'))
        if data == 'exit':
            print('Closing connection to ', addr)
            clientsock.close()
            break

HOST = 'localhost'
PORT = 5555

sock = socket(AF_INET, SOCK_STREAM)
sock.bind((HOST, PORT))
sock.listen(5)

while 1:
    clientsock, clientaddr = sock.accept()
    print('Connection from ', clientaddr)
    Thread(target=func, args=(clientsock, clientaddr)).start()
