https://stackoverflow.com/a/78534060

`/opt/homebrew/Cellar/postgresql@16/16.3/bin/pg_upgrade -b /opt/homebrew/Cellar/postgresql@14/14.12/bin -B /opt/homebrew/Cellar/postgresql@16/16.3/bin -d /opt/homebrew/var/postgresql@14 -D /opt/homebrew/var/postgresql@16`

https://stackoverflow.com/a/57326013

Remove data directory and install if symlink not created then use `brew link postgresql@15`

Finding locks,

```sql
SELECT a.datname,
     c.relname,
     l.transactionid,
     l.mode,
     l.GRANTED,
     a.usename,
     a.query, 
     a.query_start,
     age(now(), a.query_start) AS "age", 
     a.pid 
FROM  pg_stat_activity a
 JOIN pg_locks         l ON l.pid = a.pid
 JOIN pg_class         c ON c.oid = l.relation
ORDER BY a.query_start;
```

For psycopg issues with broken symlinks,
`ln -s /opt/homebrew/opt/postgresql@14/lib/postgresql@14/libpq.5.dylib /opt/homebrew/opt/postgresql/lib/libpq.5.dylib`
