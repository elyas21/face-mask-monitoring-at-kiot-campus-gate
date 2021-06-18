import os

class Config:
    SECRET_KEY = 'dsjalkfhfdklajdfhalskjdfhaklsj'
    SQLALCHEMY_DATABASE_URI =  'mysql+pymysql://black:tikur@localhost/maskgate0'
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ.get('EMAIL_USER')
    MAIL_PASSWORD = os.environ.get('EMAIL_PASS')