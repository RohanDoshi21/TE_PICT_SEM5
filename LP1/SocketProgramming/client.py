# echo-client.py

import socket

HOST = "127.0.0.1"  # The server's hostname or IP address
PORT = 65432  # The port used by the server

data = ""

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    while data != "exit":
        input_String = input()
        s.sendall(bytes(input_String, encoding='utf8'))
        data = s.recv(1024)
        data = data.decode()
        print(f"Received {data}")
