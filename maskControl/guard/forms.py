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

 
