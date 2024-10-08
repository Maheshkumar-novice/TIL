https://medium.com/@jordan.l.edmunds/how-to-time-your-code-correctly-time-monotonic-e730dce49006
https://luminousmen.com/post/how-to-not-leap-in-time-using-python
https://docs.python.org/3/library/time.html#time.monotonic
https://github.com/redis/redis-py/blob/master/redis/lock.py#L215

We should use `time.monotonic` to calculate time diffs and all. Because usual `time.time()` is susceptible to be vulnerable if system time changes. Given blogs and resources explaining it very well.
