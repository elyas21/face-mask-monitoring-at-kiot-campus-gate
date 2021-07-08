import numpy as np
import cv2 as cv
from task import show_img


cap = cv.VideoCapture(0)
if not cap.isOpened():
    print("Cannot open camera")
    exit()
while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    # Our operations on the frame come here
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    # Display the resulting frame
    # cv.imshow('frame', gray)
    # apply_async
    show_img.apply_async(args=('param1', gray), countdown=60) 
    # show_img.async_delay('fram' , gray)
    if cv.waitKey(1) == ord('q'):
        break
# When everything done, release the capture
cap.release()