# Server Side
# 5 Steps
# 1) Socket Creation
# 2) Bind()
# 3) Listen()
# 4) Accept()
# 5) Close()

from socket import *
import threading
import time


def handler(clientsock, addr):
    while 1:
        time.sleep(2)
        data = clientsock.recv(1024)
        if not data:
            break
        msg = data.decode()
        print(msg + " from ", addr)
        clientsock.send(bytes(msg, encoding='utf8'))
    clientsock.close()


HOST = ''
PORT = 5555
ADDR = (HOST, PORT)

# SOCK_STREAM -> TCP     SOCK_DGRAM -> UDP
serversock = socket(AF_INET, SOCK_STREAM)
serversock.bind(ADDR)
serversock.listen(5)

print('Server Live at port ' + str(PORT))
while 1:
    clientsock, addr = serversock.accept()
    print('Connection from: ', addr)
    threading.Thread(target=handler, args=(clientsock, addr)).start()
