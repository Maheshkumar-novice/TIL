Logging to find notices and slow queries in postgres. I haven't experimented with stderr and all but for now this is enough for me.

In psql,

`show data_directory;`

My configs for my need (`postgresql.conf`),

```
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_rotation_age = 1d
log_rotation_size = 0
log_min_messages = notice
log_min_duration_statement = 250
log_timezone = 'Asia/Kolkata'
```
