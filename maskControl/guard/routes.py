# import time
# time.localtime()
# time.struct_time(tm_year=2018, tm_mon=7, tm_mday=16, tm_hour=1, tm_min=51, tm_sec=39, tm_wday=0, tm_yday=197, tm_isdst=0)

from maskControl.guard.streamer import Streamer
from maskControl.utils import JsonResp
from maskControl import redis_client
import datetime
from flask import Response, render_template, url_for, flash, redirect, request, Blueprint

from maskControl.guard.forms import MemberRegistrationForm, UpdateMember, SearchMember, AddRecord
from maskControl import db
from maskControl.models import Member
from maskControl.models import Record
from flask_login import login_user, current_user, logout_user, login_required
from maskControl.users.utils import save_picture

guard = Blueprint('guard', __name__, template_folder='templates')


@guard.route("/dashboard")
def dashboard():
    return render_template('dashboard.html')


@guard.route("/stream/<camId>")
def stream(camId):
    print(camId)
    return render_template('stream.html', cameraId=camId)


@guard.route("/record-disobdient", methods=['POST', 'GET'])
@guard.route("/record-disobdient/<int:id>", methods=['POST', 'GET'])
def record_disobdient(id=None):
    if id is not None:
        records = Record.query.filter_by(member_id=id).all()

    addRecordForm = AddRecord()
    _note = request.form.get('note')
    _title = request.form.get('title')
    _form_member_id = request.form.get('member_id')
    _member_id = id if id is not None else _form_member_id
    print(_title)
    print(_note)
    print(_member_id )
    if addRecordForm.is_submitted() and _note and request.method == 'POST':
        record = Record(title=_title, note=_note, member_id=_member_id)
        print(record)
        db.session.add(record)
        db.session.commit()
        flash(
            f'record has been added succsesfuly', 'success')
        addRecordForm.title.data = ''
        addRecordForm.note.data = ''
        addRecordForm.member_id.data = ''

        # return redirect(url_for('gurad.registerrecord'))
        if id is None:
            records = Record.query.filter_by(member_id=_member_id).all()
        return render_template('record-disobdient.html', addRecordForm=addRecordForm, title='record-disobdient', records=records)

    if id is not None:
        return render_template('record-disobdient.html', addRecordForm=addRecordForm, title='record-disobdient', records=records)

    return render_template('record-disobdient.html', addRecordForm=addRecordForm, title='record-disobdient')


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
def view_members():
    page = request.args.get('page', 1, type=int)
    members = Member.query.order_by(
        Member.id.desc()).paginate(page=page, per_page=5)
    print(members)
    return render_template('view-members.html', members=members)


@guard.route("/view-member/<int:member_id>", methods=['GET', 'POST'])
@guard.route("/search-member",  methods=['GET', 'POST'])
@login_required
def view_member(member_id=None):

    form = UpdateMember()
    searchform = SearchMember()

    _fname = request.form.get('fname')
    _mname = request.form.get('mname')
    _lname = request.form.get('lname')
    _email = request.form.get('email')
    _searchemail = request.args.get('email')
    print(_searchemail)
    print(form)
    # _id = request.form.get('id')

    if form.validate_on_submit() and _fname and _mname and _lname and _email and member_id and request.method == 'POST':
        member = Member.query.filter_by(id=member_id).first()
        if form.picture.data:
            picture_file = save_picture(form.picture.data)
            member.image_file = picture_file
        member.fname = _fname
        member.mname = _mname
        member.lname = _lname
        member.email = _email
        db.session.commit()
        form.fname.data = ''
        form.mname.data = ''
        form.lname.data = ''
        form.email.data = ''
        form.email.data = ''
        flash('Your account has been updated!', 'success')
        return render_template('view-member.html', form=form, searchform=searchform, member_id=member_id)

    elif _searchemail and request.method == 'GET':
        print('in \n'*3)
        member = Member.query.filter_by(email=_searchemail).first()
        print(member)
        form.email.data = member.email
        member_id = member.id
        return render_template('view-member.html', form=form, searchform=searchform, member_id=member_id)

    elif request.method == 'GET' and member_id:
        member = Member.query.filter_by(id=member_id).first()
        print(member)
        form.fname.data = member.fname
        form.mname.data = member.mname
        form.lname.data = member.lname
        form.email.data = member.email

        return render_template('view-member.html', form=form, searchform=searchform, member_id=member_id)

    elif request.method == 'GET':
        print('out \n'*3)
        return render_template('view-member.html', form=form, searchform=searchform, member_id=member_id)

        # image_file = url_for(
        # 'static', filename='profile_pics/' + current_user.image_file)
        # return render_template('account.html', title='Account',
        #                 image_file=image_file, form=form)
    else:
        return render_template('internal-server-error.html')
