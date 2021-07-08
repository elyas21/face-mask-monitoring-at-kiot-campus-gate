from celery import Celery
celery = Celery()


@celery.task()
def add(x, y):
    return x + y


@celery.task()
def mul(x, y):
    return x * y


@celery.task()
def xsum(numbers):
    return sum(numbers)


@celery.task()
def what():
    return 'awesome! it works :)'