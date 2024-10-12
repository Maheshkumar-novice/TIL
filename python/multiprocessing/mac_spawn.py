from multiprocessing import Process

def f(name):
    import os; print(os.getpid())
    print(os.getpid(), 'hello', name)

if __name__ == '__main__':
    p = Process(target=f, args=('bob',))
    import os; print(os.getpid())
    p.start()
    p.join()

    pid = os.fork()
    f("danekshal")
    if pid:
        os.waitpid(pid, 0)
