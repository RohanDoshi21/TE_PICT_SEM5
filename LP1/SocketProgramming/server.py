# echo-server.py

import socket

HOST = ""  # Standard loopback interface address (localhost)
PORT = 65432  # Port to listen on (non-privileged ports are > 1023)

data = ""

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print(f"Connected by {addr}")
        while data != 'exit':
            data = conn.recv(1024)
            data = data.decode()
            print(data)
            if not data:
                break
            conn.sendall(bytes(data, encoding='utf8'))
        s.close()
