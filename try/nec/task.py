
from celery.schedules import crontab
from app import celery


@celery.task(bind=True, name='remind_appointment')
def remind_appointment(args):
    '''
     Get data from your database model such as
     User.query.all() and perform some operation
    '''
    pass


@celery.task(bind=True, name='send_email')
def send_email(args):
    '''
       Get data from your database model such as
       User.query.all() and perform some operation to
       send marketing campaigns
      '''
    pass


celery.conf.beat_schedule = {
    'appointment reminder in every 2 minutes': {
        'task': 'remind_appointment',
        'schedule': 120.0
    },
    'send email every 2 hours': {
        'task': 'send_email',
        'schedule': crontab(hour='*/2')
    }
}

# start celery worker
# celery -A tasks  worker --loglevel=info

# start celery beat
# celery -A tasks.celery beat --loglevel=info