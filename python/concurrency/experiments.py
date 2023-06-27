from threading import Thread, current_thread
from multiprocessing import Process as Thread, current_process as current_thread
# monkey patching thread with process and some other curious experiments...:)
# inspiration from:  Chandrashekar Babu (https://www.youtube.com/watch?v=fvaoT5P4aMk)

def foo():
    from time import sleep
    print(f'{current_thread()} going to sleep...')
    sleep(60)


if __name__ == '__main__':
    tasks = []
    for _ in range(10):
        t = Thread(target=foo)
        t.start()
        tasks.append(t)

    for task in tasks:
        print(f'Waiting for task: {task} {dir(task)}')
        task.join()
