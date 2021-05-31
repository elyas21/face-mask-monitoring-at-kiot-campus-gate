from flask import request, jsonify, make_response
from flask_restful import Api, Resource
from sqlalchemy.exc import IntegrityError
from marshmallow import ValidationError

from web.app.models import Employee, Device, db
from web.app.modles.user import User
from web.app.serializers import employee_schema, employees_schema, device_schema, devices_schema
from web.app.exceptions import ApiException
from web.app.mail import send_async_email


class IndexPageResource(Resource):
    def get(self):
        html_message = """<p>
            Welcome to flask-crud application. Refer README instructions here for documentation: 
            <a href="https://github.com/ashwani99/flask-crud">https://github.com/ashwani99/flask-crud</a>
        </p>"""
        headers={'Content-Type': 'text/html'}
        return make_response(html_message, 200, headers)


class EmployeeCollection(Resource):
    def get(self):
        """ Get all the employees """
        emps = Employee.query.all()
        users = User.query.all()
        return make_response(jsonify(employees_schema.dump(emps)), 200)
        
    def post(self):
        """ Create a new employee """
        try:
            emp = employee_schema.load(request.json)
        except ValidationError as e:
            raise ApiException(e.messages, 400)

        try:
            db.session.add(emp)
            db.session.commit()
        except IntegrityError:
            db.session.rollback()
            raise ApiException(dict(email="This email is already registered"), 409)
        
        return make_response(jsonify(employee_schema.dump(emp)), 201)


class EmployeeeResource(Resource):
    def get(self, id):
        """ Get all the employees """
        emp = Employee.query.get(id)
        if emp is None:
            raise ApiException(dict(message=[f"Not able to find any employee with id {id}"]),
                               404)

        return make_response(jsonify(employee_schema.dump(emp)), 200)
    
    def put(self, id):
        """ Update a employee's details """
        try:
            emp_new = employee_schema.load(request.json)
        except ValidationError as e:
            raise ApiException(e.messages, 400)
        
        emp = Employee.query.get(id)
        if emp is None:
            raise ApiException(dict(message=[f"Not able to find any employee with id {id}"]),
                               404)
        
        try:
            emp.__init__(**emp_new.__dict__)
            db.session.commit()
        except IntegrityError:
            db.session.rollback()
            raise ApiException(dict(email="This email is already registered"), 400)

        return make_response('', 204)


class EmployeeDeviceResource(Resource):
    def get(self, id):
        """ Get a device details """
        device = Device.query.get(id)
        if device is None:
            raise ApiException(dict(message=[f"Not able to find any device with id {id}"]),
                               404)
        return make_response(jsonify(device_schema.dump(device)), 200)

    def post(self):
        """ Create a new device """
        try:
            device = device_schema.load(request.json)
        except ValidationError as e:
            raise ApiException(e.messages, 400)

        db.session.add(device)
        db.session.commit()

        return make_response(jsonify(device_schema.dump(device)), 201)

    def put(self, id):
        """ Update device details """
        device = Device.query.get(id)
        if device is None:
            raise ApiException(dict(message=[f"Not able to find any device with id {id}"]),
                               404)

        try:
            device = device_schema.load(request.json)
        except ValidationError as e:
            raise ApiException(e.messages, 400)
        
        device.__init__(**device.__dict__)
        db.session.commit()
        return make_response('', 204)


class DeviceAssignmentAction(Resource):
    def put(self, device_id, emp_id):
        """ Assign device to an employee """
        device = Device.query.get(device_id)
        if device is None:
            raise ApiException(dict(message=[f"Not able to find any device with id {device_id}"]),
                               404)
        emp = Employee.query.get(emp_id)
        if emp is None:
            raise ApiException(dict(message=[f"Not able to find any employee with id {emp_id}"]),
                               404)
        if device.is_assigned and emp != device.device_assignee:
            raise ApiException(dict(message=[f"Device with id {device_id} is already assigned. Please un-assign it first before assigning again"]))

        try:
            is_notify = emp.assign_device(device)
            db.session.commit()
        except IntegrityError:
            db.session.rollback()
            raise ApiException()

        if is_notify:
            mail_subject = "New Device Assigned"
            recipients = [emp.email]
            mail_body = f"Hi {emp.firstname},\nYou have been assigned a new device {device.device_name}\nThanks,\nFlask CRUD Admin"
            send_async_email.delay(mail_subject, mail_body, recipients)

        return make_response(jsonify(success=True, status="assigned"), 204)


    def delete(self, device_id, emp_id):
        """ Un-assign device from an employee """
        device = Device.query.get(device_id)
        if device is None:
            raise ApiException(dict(message=[f"Not able to find any device with id {device_id}"]),
                               404)
        emp = Employee.query.get(emp_id)
        if device is None:
            raise ApiException(dict(message=[f"Not able to find any employee with id {emp_id}"]),
                               404)
        if device.is_assigned and emp != device.device_assignee:
            raise ApiException(dict(message=[f"Device with id {device_id} not assigned to employee with id {emp_id}"]),
                              404)

        try:
            is_notify = emp.unassign_device(device)
            db.session.commit()
        except IntegrityError:
            db.session.rollback()
            raise ApiException()

        if is_notify:
            mail_subject = "Device Unassigned"
            recipients = [emp.email]
            mail_body = f"Hi {emp.firstname},\nYour device {device.device_name} has been un-assigned from you\nThanks,\nFlask CRUD Admin"
            send_async_email.delay(mail_subject, mail_body, recipients)
        
        return make_response(jsonify(success=True, status="un-assigned"), 204)


api = Api()
api.add_resource(IndexPageResource, '/')
api.add_resource(EmployeeCollection, '/employees')
api.add_resource(EmployeeeResource, '/employee/<int:id>')
api.add_resource(EmployeeDeviceResource, '/device', '/device/<int:id>')
api.add_resource(DeviceAssignmentAction, '/device/<int:device_id>/assign/<int:emp_id>')
