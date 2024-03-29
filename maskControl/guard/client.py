# Welcome to PyShine
# lets make the client code
# Welcome to PyShine
# www.pyshine.com
import socket,cv2, pickle,struct

# create socket
client_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host_ip = 'localhost' # Here Require CACHE Server IP
port = 9992
client_socket.connect((host_ip,port)) # a tuple
payload_size = struct.calcsize("Q")
data = b""

def recver_stream():
    

    while True:
        while len(data) < payload_size:
            packet = client_socket.recv(4*1024) # 4K
            if not packet: break
            data+=packet
        packed_msg_size = data[:payload_size]
        data = data[payload_size:]
        msg_size = struct.unpack("Q",packed_msg_size)[0]
        
        while len(data) < msg_size:
            data += client_socket.recv(4*1024)
        frame_data = data[:msg_size]
        data  = data[msg_size:]
        frame = pickle.loads(frame_data)
        cv2.imshow("RECEIVING VIDEO FROM CACHE SERVER",frame)
        key = cv2.waitKey(1) & 0xFF
        if key  == ord('q'):
            break
        ret, jpeg = cv2.imencode('.jpg', frame)
        jpeg = jpeg.tobytes()

        yield (b'--frame\r\n'b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')

    client_socket.close()
    
    return 'noimage'        
