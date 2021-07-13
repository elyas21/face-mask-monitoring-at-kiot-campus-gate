# import time
# time.localtime()
# time.struct_time(tm_year=2018, tm_mon=7, tm_mday=16, tm_hour=1, tm_min=51, tm_sec=39, tm_wday=0, tm_yday=197, tm_isdst=0)

from maskControl.guard.streamer import Streamer
from maskControl.utils import JsonResp
from maskControl import redis_client
import datetime
from flask import Response, render_template, url_for, flash, redirect, request, Blueprint

from maskControl.guard.forms import MemberRegistrationForm
from maskControl import db
from maskControl.models import Member
from flask_login import login_user, current_user, logout_user, login_required


guard = Blueprint('guard', __name__, template_folder='templates')


@guard.route("/dashboard")
def dashboard():
    return render_template('dashboard.html')


@guard.route("/stream/<camId>")
def stream(camId):
    print(camId)
    return render_template('stream.html', cameraId=camId)


@guard.route("/record-disobdient")
def record_disobdient():
    return render_template('record-disobdient.html', title='record-disobdient')


def gen(camId):
    streamer = Streamer(camId)
    streamer.start()

    while True:
        if streamer.streaming:
            yield (b'--frame\r\n'b'Content-Type: image/jpeg\r\n\r\n' + streamer.get_jpeg() + b'\r\n\r\n')


@guard.route('/video_feed/<camId>')
def video_feed(camId):
    return Response(gen(camId), mimetype='multipart/x-mixed-replace; boundary=frame')


@guard.route('/live-update/sec')
def liveUpdateSec():

    # the loop itterate 60 times untile in that sec set is found
    # no_set = True
    # for i in range(0, 60):
    #   last_sec = int(str(datetime.datetime.now())[-9:-7]) - i
    #   now_time_stmp = str(datetime.datetime.now())[0:-9] + str(last_sec)
    #   full_string = 'no_mask_list_'+now_time_stmp+'_'+str(0)
    #   curent_count = redis_client.smembers(full_string)
    #   print(full_string)

    #   if len(full_string) > 0:
    #     break

    last_sec = int(str(datetime.datetime.now())[-9:-7]) - 1
    now_time_stmp = str(datetime.datetime.now())[0:-9] + str(last_sec)
    full_string = 'no_mask_list_'+now_time_stmp+'_'+str(0)
    curent_count = redis_client.smembers(full_string)
    print(full_string)

    # if len(full_string) > 0:
    #   curent_count = None

    return JsonResp({"status": len(curent_count)}, 200)


@guard.route("/registerMember", methods=['GET', 'POST'])
@login_required
def registerMember():
    form = MemberRegistrationForm()
    if form.validate_on_submit():
        member = Member(fname=form.fname.data, email=form.email.data,
                        mname=form.mname.data, lname=form.lname.data)
        db.session.add(member)
        db.session.commit()
        flash(
            f'{form.fname.data} {form.lname.data} has been succsesfuly registerd ', 'success')
        form.fname.data = ''
        form.mname.data = ''
        form.lname.data = ''
        form.email.data = ''
        # return redirect(url_for('gurad.registerMember'))

    return render_template('member-registration-form.html', tilte='Register Member', form=form)


@guard.route("/view-members", methods=['GET'])
@login_required
def view_member():
    return render_template('view-members.html')
