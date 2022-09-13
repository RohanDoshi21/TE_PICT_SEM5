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

serversock = socket(AF_INET, SOCK_STREAM)
serversock.bind(ADDR)
serversock.listen(5)

print('Server Live at port ' + str(PORT))
while 1:
    clientsock, addr = serversock.accept()
    print('Connection from: ', addr)
    threading.Thread(target=handler, args=(clientsock, addr)).start()
