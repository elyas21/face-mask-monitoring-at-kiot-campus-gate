from config import Config
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

app = Flask(__name__)

# initialising Flask
app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    image_file = db.Column(db.String(20), nullable=False,
                           default='default.jpg')
    password = db.Column(db.String(60), nullable=False)

    def get_reset_token(self, expires_sec=1800):
        s = Serializer(app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    @staticmethod
    def verify_reset_token(token):
        s = Serializer(app.config['SECRET_KEY'])
        try:
            user_id = s.loads(token)['user_id']
        except:
            return None
        return User.query.get(user_id)

    def __repr__(self):
        return f"User('{self.username}', '{self.email}', '{self.image_file}')"


class Member(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(20), unique=False, nullable=False)
    mname = db.Column(db.String(20), unique=False, nullable=False)
    lname = db.Column(db.String(20), unique=False, nullable=False)
    email = db.Column(db.String(120), unique=False, nullable=False)
    image_file = db.Column(db.String(20), nullable=False,
                           default='default.jpg')
    records = db.relationship('Record', backref='member', lazy=True)
  
    def __repr__(self):
        return f"Member('{self.id}', '{self.fname}', '{self.lname}')"


class Record(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(60), nullable=False)
    note = db.Column(db.String(150), nullable=False)

    member_id = db.Column(db.Integer, db.ForeignKey(
        'member.id'), nullable=False)

    def __repr__(self):
        return f"Record('{self.title}', '{self.note}')"
