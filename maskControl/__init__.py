from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_mail import Mail
from maskControl.config import Config
import redis

db = SQLAlchemy()
bcrypt = Bcrypt()
login_manager = LoginManager()
login_manager.login_view = 'users.login'
login_manager.login_message_category = 'info'
mail = Mail()

redis_client = redis.Redis(host='localhost', port=6379)

def create_app(config_class=Config):
    app = Flask(__name__ )
    app.config.from_object(Config)

    db.init_app(app)
    bcrypt.init_app(app)
    login_manager.init_app(app)
    mail.init_app(app)

    from maskControl.users.routes import users
    from maskControl.main.routes import main
    from maskControl.guard.routes import guard

    app.register_blueprint(guard)
    app.register_blueprint(users)
    app.register_blueprint(main)

    return app