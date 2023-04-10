from celery import Celery

# https://docs.celeryq.dev/en/stable/userguide/routing.html#id12
app = Celery(...)

app.conf.task_acks_late = True # This makes the worker to execute one task and won't prefetch any tasks but the executing task will be unacked.
app.conf.broker_transport_options = {
  'priority_steps': list(range(10)), # priority number range (0-9)
  'sep': ':', # queue name separator
  'queue_order_strategy': 'priority',
  'visibility_timeout': 3600 # default value, broker wait till this time to re-send the task to another worker
}

# Now the tasks will be sent to workers based on the priority. In redis 0 is higher priority and 9 is lower priority.
