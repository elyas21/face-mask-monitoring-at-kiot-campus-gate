from celery import Celery
from proj.app import create_app
class CeleryConfig:
    CELERY_IMPORTS = ('proj.tasks')
    CELERY_TASK_RESULT_EXPIRES = 30
    CELERY_ACCEPT_CONTENT = ['json', 'msgpack', 'yaml']
    CELERY_TASK_SERIALIZER = 'json'
    CELERY_RESULT_SERIALIZER = 'json'
    CELERY_TIMEZONE = 'Asia/Seoul'
    CELERY_ENABLE_UTC = False
# this is a place for scheduler with celery beat.
# so, you can change 'task' part whatever you want. 
CELERYBEAT_SCHEDULE = {
    "time_scheduler": {
        "task": "proj.tasks.what", 
        "schedule": 60.0 #set schedule time ! 
    }
}

def make_celery(app):
    # celery = Celery(app.import_name,
    #                 broker='amqp://<username>:<password>@localhost:5672/',
    #                 backend='amqp://<username>:<password>@localhost:5672/'
    #                 )

    celery = Celery(app.import_name, broker='redis://localhost', backend='redis://localhost')

    celery.conf.update(app.config)
    TaskBase = celery.Task
    class ContextTask(TaskBase):
        abstract = True
        def __call__(self, *args, **kwargs):
            with app.app_context():
                return TaskBase.__call__(self, *args, **kwargs)
    celery.Task = ContextTask
    celery.config_from_object(CeleryConfig)
    return celery
app = create_app('dev', register_blueprints=False)
celery = make_celery(app)