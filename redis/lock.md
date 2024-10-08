I've explored `redis locking` mechanism in the redis-py. As far as I read, it should work for my use case with single host. But for multiple hosts and master-slave structures I'm not sure. Anyhow I'll attach the resources here.

* https://codedamn.com/news/backend/distributed-locks-with-redis
* https://github.com/redis/redis-py/blob/master/redis/lock.py
* https://github.com/redis/redis-py/blob/master/tests/test_lock.py
* https://redis.readthedocs.io/en/stable/lock.html
* https://medium.com/@anil.goyal0057/distributed-locking-mechanism-using-redis-26c17d9f3d5f
* https://dzone.com/articles/distributed-lock-implementation-with-redis
* https://redis.io/docs/latest/develop/use/patterns/distributed-locks/
* https://redis.io/glossary/redis-lock/
* https://redis.io/docs/latest/commands/set/
