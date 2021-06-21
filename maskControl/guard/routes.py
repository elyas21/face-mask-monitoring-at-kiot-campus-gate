from flask import render_template, request, Blueprint, Response
# from maskControl.guard.client import recver_stream

guard = Blueprint('guard', __name__, template_folder='templates')

@guard.route("/dashboard")
def dashboard():
    return render_template('dashboard.html')


@guard.route("/stream/<camId>")
def stream(camId):
    print(camId)
    return render_template('stream.html' ,cameraId=camId)


@guard.route("/record-disobdient")
def record_disobdient():
    return render_template('record-disobdient.html', title='record-disobdient')

from maskControl.guard.streamer import Streamer


def gen(camId):
  streamer = Streamer(camId)
  streamer.start()

  while True:
    if streamer.streaming:  
      yield (b'--frame\r\n'b'Content-Type: image/jpeg\r\n\r\n' + streamer.get_jpeg() + b'\r\n\r\n')

@guard.route('/video_feed/<camId>')
def video_feed(camId):
  return Response(gen(camId), mimetype='multipart/x-mixed-replace; boundary=frame')
