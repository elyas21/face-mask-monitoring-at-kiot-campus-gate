
import os

BASEDIR = os.path.abspath(os.path.dirname(__file__))


class Config:
    DEBUG = False
    
    # sqlalchemy configs
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://black:tikur@localhost/maskgate30'
    SQLALCHEMY_ECHO = True

    # flask-mail config
    MAIL_SERVER = os.environ.get("MAIL_SERVER") or "localhost"
    MAIL_PORT = os.environ.get("MAIL_PORT") or 8025
    ADMIN_EMAIL = "admin@example.com"

    # celery configs
    CELERY_BROKER_URL = 'redis://localhost:6379/0'
    CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'


