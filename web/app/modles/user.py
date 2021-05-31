from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, String, Integer, ForeignKey, Enum
from sqlalchemy.orm import relationship


db = SQLAlchemy()


class User(db.Model):
    id = Column(Integer, primary_key=True)
    firstname = Column(String(255), nullable=False)
    lastname = Column(String(255), nullable=False)
    email = Column(String(254), unique=True, nullable=False)
    mobile_number = Column(String(15), nullable=False)
    role = Column(Enum['d', 'df'], nullable=False)
    
    def __init__(self, firstname, lastname, email, mobile_number, **kwargs):
        """ Initiate a `User` object """
        db.Model.__init__(self, firstname=firstname, lastname = lastname,
                                email=email, mobile_number=mobile_number)

    def __repr__(self):
        """ Represent `User` instance as a unique string """
        return "<User({email!r})>".format(email=self.email)

    def assign_device(self, device):
        """ Assign a device to an `User` """
        if device not in self.devices:
            self.devices.append(device)
            return True
        return False

    def unassign_device(self, device):
        """ Un-assign a device to an `User` """
        if device in self.devices:
            self.devices.remove(device)
            return True
        return False


