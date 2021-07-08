from __future__ import absolute_import, unicode_literals

from celery import Celery

app = Celery('task', broker='redis://localhost', backend='redis://localhost', include=['tasks'])
import cv2




# Optional configuration, see the eApplication user guide.
app.conf.update(
result_expires=3600,
)







@app.task
def add(x, y):
    return x + y

@app.task
def mul(x, y):
    return x * y

@app.task
def xsum(numbers):
    return sum(numbers)

@app.task
def save_to_csv():
    pass

@app.task
def save_to_video():
    pass

@app.task
def send_to_web():
    pass

@app.task
def show_img(p, img):
    return cv2.imshow(p, img)
    # if cv2..turn  StopIteration
