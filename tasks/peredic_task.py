"""myapp.py

Usage::

   # The worker service reacts to messages by executing tasks.
   (window1)$ python peredic_task.py worker -l INFO

   # The beat service sends messages at scheduled intervals.
   (window2)$ python peredic_task.py beat -l INFO

   # XXX To diagnose problems use -l debug:
   (window2)$ python myapp.py beat -l debug

   # XXX XXX To diagnose calculated runtimes use C_REMDEBUG envvar:
   (window2) $ C_REMDEBUG=1 python myapp.py beat -l debug


You can also specify the app to use with the `celery` command,
using the `-A` / `--app` option::

    $ celery -A myapp worker -l INFO

With the `-A myproj` argument the program will search for an app
instance in the module ``myproj``.  You can also specify an explicit
name using the fully qualified form::

    $ celery -A myapp:app worker -l INFO

"""

from celery import Celery

app = Celery(
    # XXX The below 'myapp' is the name of this module, for generating
    # task names when executed as __main__.
    'myapp',
    broker='redis://localhost:6379',
    # ## add result backend here if needed.
    # backend='rpc'
)

app.conf.timezone = 'UTC'


@app.task
def say(what):
    print('\nwhat\n'*2)

import csv
@app.task
def write_csv(sett):
    print('\csv write\n'*2)
    with open('some.csv', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerows(sett)
    print('\csv write\n'*2)

@app.on_after_configure.connect
def setup_periodic_tasks(sender, **kwargs):
    # Calls say('hello') every 10 seconds.
    sender.add_periodic_task(2.0, say.s('hello'), name='add every 4')
    sender.add_periodic_task(2.0, write_csv.s(['hello','sfa']), name='write 2')

    # See periodic tasks user guide for more examples:
    # http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html


if __name__ == '__main__':
    app.start()
