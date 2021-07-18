from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, SubmitField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from maskControl.models import Member
# id
# fname
# mname
# lname
# email
# image_file


class MemberRegistrationForm(FlaskForm):
    fname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    mname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    lname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    submit = SubmitField('Sign Up')
class AddRecord(FlaskForm):
    title = StringField('title',
                        validators=[DataRequired(), Length(min=2, max=60)])
    note = StringField('note',
                        validators=[DataRequired(), Length(min=2, max=150)])
    member_id = StringField('member_id',
                        validators=[DataRequired()])
    submit = SubmitField('Record')



class UpdateMember(FlaskForm):
    fname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    mname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    lname = StringField('Username',
                        validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    picture = FileField('Update Profile Picture', validators=[
                        FileAllowed(['jpg', 'png'])])
    submit = SubmitField('Update')

    # def validate_username(self, username):
    #     if username.data != current_user.username:
    #         user = User.query.filter_by(username=username.data).first()
    #         if user:
    #             raise ValidationError(
    #                 'That username is taken. Please choose a different one.')

    # def validate_email(self, email):
    #     if email.data != current_user.email:
    #         user = Member.query.filter_by(email=email.data).first()
    #         if user:
    #             raise ValidationError(
    #                 'That email is taken. Please choose a different one.')
    # def validate_id(self, id):
    #     if id.data != current_user.id:
    #         user = Member.query.filter_by(id=id.data).first()
    #         if user:
    #             raise ValidationError('That id is taken. Please choose a different one.')


class SearchMember(FlaskForm):
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    submit = SubmitField('Submit')
    # def validate_email(self, email):
    #     if email.data != current_user.email:
    #         user = Member.query.filter_by(email=email.data).first()
    #         if user:
    #             raise ValidationError(
    #                 'That email is not exist. Please choose a different one.')
