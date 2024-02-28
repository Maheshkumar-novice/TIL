I have found on behaviour that was new to me. When a parent process goes to exit, it waits for the children to join before completely exit.

https://github.com/python/cpython/blob/3.12/Lib/multiprocessing/util.py#L358

This is the expected behaviour as we don't want to terminate the parent when the children are still actively running. We don't want make orphaned processes.

This behaviour is registered in `atexit` that is done when we import multiprocessing.

https://github.com/python/cpython/blob/3.12/Lib/multiprocessing/util.py#L14

https://github.com/python/cpython/blob/3.12/Lib/multiprocessing/util.py#L365
