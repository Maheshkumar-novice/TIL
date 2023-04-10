from celery import Celery
from celery.signals import task_revoked

app = Celery(...)

# called when `app.control.revoke(task_id, terminate=True, signal='SIGKILL')`
@task_revoked.connect
def callback(request, **kwargs):
  pass

@app.task(name='task')
def callback():
  pass
