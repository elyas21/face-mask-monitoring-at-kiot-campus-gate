import cv2
import numpy
import socket
import struct
import threading
from io import BytesIO
import socket,cv2, pickle,struct

class Streamer(threading.Thread):

    def __init__(self, hostname='localhost', port=9977):
        threading.Thread.__init__(self)

        self.hostname = hostname
        self.port = port
        self.running = False
        self.streaming = False
        self.jpeg = None

    def run(self):

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print('Socket created')

        s.connect((self.hostname, self.port))
        print('Socket bind complete')

        payload_size = struct.calcsize("Q")

        # s.listen(10)
        # print('Socket now listening')

        self.running = True

        while self.running:

            # print('Start listening for connections...')

            # s, addr = s.accept()
            # print("New connection accepted.")
            data = b''
            while True:

        

                while len(data) < payload_size:
                    packet = s.recv(4*1024) # 4K
                    if not packet: break
                    data+=packet
                packed_msg_size = data[:payload_size]
                data = data[payload_size:]
                msg_size = struct.unpack("Q",packed_msg_size)[0]



                while len(data) < msg_size:
                    data += s.recv(4*1024)
                frame_data = data[:msg_size]
                data  = data[msg_size:]
                frame = pickle.loads(frame_data)


                ret, jpeg = cv2.imencode('.jpg', frame)
                self.jpeg = jpeg

                self.streaming = True
        
            s.close()
            print('Closing connection...')
            # self.streaming = False
            self.jpeg = None
            break

        print('Exit thread.')

    def stop(self):
        self.running = False

    def get_jpeg(self):
        return self.jpeg.tobytes()
