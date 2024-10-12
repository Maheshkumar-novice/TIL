import os
import time

for i in range(2):
    print(os.getpid(),"I'm about to be a dad!")
    time.sleep(5)
    pid = os.fork()
    if pid == 0:
        print(os.getpid(),"I'm {}, a newborn that knows to write to the terminal!".format(os.getpid()))
    else:
        print(os.getpid(), "I'm the dad of {}, and he knows to use the terminal!".format(pid))
        print(os.getpid(), "Waiting for", pid)
        os.waitpid(pid, 0)
    print(os.getpid(), " Loop ", i, "ends")
