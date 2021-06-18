import cv2
import numpy as np
import socket
import struct
from io import BytesIO

# Capture frame
cap = cv2.VideoCapture(0)

# client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# client_socket.connect(('localhost', 8081))

def streamImage(frame):

    memfile = BytesIO()
    np.save(memfile, frame)
    memfile.seek(0)
    data = memfile.read()

    # print(f'a\n\\n\n\n\n\n\n' {len(frame)} + '\n'  {frame}  '\n\n\n\n\n\n\n\n')

    # Send form byte array: frame size + frame content
    client_socket.sendall(struct.pack("L", len(data)) + data)
    # print('a\n\\n\n\n\n\n\n' + len(data) + '\n' + data + '\n\n\n\n\n\n\n\n')
    # print(f'{data} \n\n\n\n\n {len(data)} \n\n\n\n\n')
    print(f' \n\n\n\n\n\ {client_socket} \n\n\n\n\n')