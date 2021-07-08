from __future__ import absolute_import, unicode_literals


from celery import Celery

app = Celery(
  name= 'tasks',
  broker='redis://localhost:6379',
  backend = 'db+sqlite:///db.sqlite3')

@app.task
def absoluteSub(a, b):
    return abs(a-b)