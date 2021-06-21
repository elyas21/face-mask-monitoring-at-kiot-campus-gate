import socket
import struct
from io import BytesIO

import config

import yaml
import numpy as np
import cv2
import imutils
import pickle
from threading import Thread



if isinstance('config/cam.yaml', str):  # *.yaml file
    with open('config/cam.yaml') as f:
        config.data_dict = yaml.load(f, Loader=yaml.SafeLoader)  # model dict


# class MultiStreamer(threading.Thread):

#     def __init__(self, portId):
#         threading.Thread.__init__(self)

#         self.hostname = 'localhost'
#         self.port = config.data_dict['ports'][portId][0]
#         self.running = False
#         self.streaming = False
#         self.jpeg = None
#         self.portId= portId
#         self.frame = None
#         self.server_socket = [socket.socket(socket.AF_INET, socket.SOCK_STREAM) for _ in range (len(config.data_dict['ports']))]


#     def run(self):
#         [s.bind((self.hostname, self.port)) for s in self.server_socket]
#         print(f'aaa{self.hostname, {{self.port}}}aaa')
#         [s.listen() for s in self.server_socket]
#         client_socket,addr = [s.accept() for i, s in enumerate(self.server_socket)]
#         print(addr)
#         # thread = threading.Thread(target=self.serve_client, args=(addr[self.portId],client_socket[self.portId]))
#         thread.start()
#         print("TOTAL CLIENTS ",threading.activeCount() - 1) 
#         # edited here because one thread is already started before


#     def serve_client(self, addr,client_socket):
        
#         try:
#             print('CLIENT {} CONNECTED!'.format(addr))
#             if client_socket:
#                 while True:
#                     a = pickle.dumps(self.frame)
#                     message = struct.pack("Q",len(a))+a
#                     client_socket.sendall(message)
                    
#         except Exception as e:
#             print(f"CLINET {addr} DISCONNECTED")
#             pass




#         return 0


class MStreams:  # multiple IP or RTSP cameras
    # def __init__(self, sources='streams.txt', img_size=640, stride=32):
    def __init__(self):
                
        if isinstance('config/cam.yaml', str):  # *.yaml file
            with open('config/cam.yaml') as f:
                config.data_dict = yaml.load(f, Loader=yaml.SafeLoader)  # model dict
        n = len(config.data_dict['ports'])
        self.client_socket = n * [None]
        self.addr = n * [None]
        self.hostname = 'localhost'
        self.port = [config.data_dict['ports'][i][0] for i, _ in enumerate(config.data_dict['ports'])]
        self.server_socket = [socket.socket(socket.AF_INET, socket.SOCK_STREAM) for _ in range (len(config.data_dict['ports']))]
        self.im0 =  [None] * n

        [s.bind((self.hostname, self.port[i])) for i, s in enumerate(self.server_socket)]
        [s.listen() for s in self.server_socket]
        print(f'\n\n\n\n\n\n\n\n\n')
        print(self.client_socket)
        print(f'\n\n\n\n\n\n\n\n\n')
        
        for i,p in enumerate(config.data_dict['ports']):
            img = self.im0[i]     
            thread = Thread(target=self.update, args=([i, self.port[i]]), daemon=True)
            thread.start()
        print('')

     
    def update(self, i, port):
        # self.client_socket ,self.addr = [s.accept() for s in self.server_socket]

        if self.client_socket[i]:
            print(f'dddddddddudate{self.im0[i]}')
            if self.im0[i]:
                frame  = imutils.resize(self.im0[i],width=320)
                a = pickle.dumps(frame)
                message = struct.pack("Q",len(a))+a
                self.client_socket[i].sendall(message)
                cv2.imshow(f"TRANSMITTING TO CACHE SERVER{i}",frame)

    def setter(self,i, img):
        self.client_socket ,self.addr = [s.accept() for s in self.server_socket]
        self.im0[i] = img
    
        if self.client_socket[i]:
            print(f'dddddddddddddd{self.im0[i]}')
        
            frame  = imutils.resize(self.im0[i],width=320)
            a = pickle.dumps(frame)
            message = struct.pack("Q",len(a))+a
            self.client_socket[i].sendall(message)
            cv2.imshow(f"TRANSMITTING TO CACHE SERVER{i}",frame)

