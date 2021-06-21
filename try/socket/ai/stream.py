import cv2
import numpy as np
import socket
import struct
from io import BytesIO

# Capture frame

# client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# client_socket.connect(('localhost', 8081))

# This code will run the drone side, it will send video to cache server
# Lets import the libraries
# Welcome to PyShine
# www.pyshine.com
import socket, cv2, pickle, struct
import imutils
import cv2




# server_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
# host_name  = socket.gethostname()
# host_ip = 'localhost' # Enter the Drone IP address
# print('HOST IP:',host_ip)
# port = 9978
# socket_address = (host_ip,port)
# server_socket.bind(socket_address)
# server_socket.listen()
# print("Listening at",socket_address)

# client_socket,addr = server_socket.accept()

port = [9976]
server_socket = [socket.socket(socket.AF_INET,socket.SOCK_STREAM) for _ in range(len(port))]
host_name  = socket.gethostname()
host_ip = 'localhost' # Enter the Drone IP address
print('HOST IP:',host_ip)
socket_address = [( host_ip, p ) for p in port]
[ss.bind(socket_address[i]) for i, ss in enumerate(server_socket)]
[ ss.listen() for ss in server_socket]
[print("Listening at",ss) for ss in socket_address]

client_socket,addr =[ ss.accept() for ss in server_socket]


def streamImage(frame):
    try:
        print('CLIENT {} CONNECTED!'.format(addr))
        if client_socket:

            frame  = imutils.resize(frame,width=320)
            a = pickle.dumps(frame)
            message = struct.pack("Q",len(a))+a
            client_socket.sendall(message)
            # cv2.imshow("TRANSMITTING TO CACHE SERVER",frame)

    except Exception as e:
        print(f"CACHE SERVER {addr} DISCONNECTED")
        pass

