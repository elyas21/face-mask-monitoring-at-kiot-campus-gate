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




server_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host_name  = socket.gethostname()
host_ip = 'localhost' # Enter the Drone IP address
print('HOST IP:',host_ip)
port = 10001
socket_address = (host_ip,port)
server_socket.bind(socket_address)
server_socket.listen()
print("Listening at",socket_address)

client_socket,addr = server_socket.accept()
print(f'ddddd{client_socket}dddddd')
print(f'ddddd{addr}dddddd')

def streamImage(p,frame):
    if p == 'inference/cru11.mp4':
        stream1(frame)
    elif p == '/home/black/Downloads/Video/3gnawkidan/part1.mp4':
        stream2(frame)
    else:
        print('wrong p')        

def stream1(frame):
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




server_socket1 = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host_name1  = socket.gethostname()
host_ip1 = 'localhost' # Enter the Drone IP address
print('HOST IP:',host_ip1)
port1 = 20001
socket_address1 = (host_ip1,port1)
server_socket1.bind(socket_address1)
server_socket1.listen()
print("Listening at",socket_address1)

client_socket1,addr1 = server_socket1.accept()
print(f'ddddd{client_socket1}dddddd')
print(f'ddddd{addr1}dddddd')

def stream2(frame):
    try:
        print('CLIENT {} CONNECTED!'.format(addr1))
        if client_socket1:

            frame  = imutils.resize(frame,width=320)
            a = pickle.dumps(frame)
            message = struct.pack("Q",len(a))+a
            client_socket1.sendall(message)
            # cv2.imshow("TRANSMITTING TO CACHE SERVER",frame)

    except Exception as e:
        print(f"CACHE SERVER {addr1} DISCONNECTED")
        pass

