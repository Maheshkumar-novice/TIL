import multiprocessing

print(f'Initializing...{multiprocessing.current_process().name}')

import module

def target(): print(f'I am the target :( ({multiprocessing.current_process().name})\n')

if __name__ == '__main__':
    print('Calling the children...\n')
    multiprocessing.Process(target=target).start()
    multiprocessing.Process(target=target).start()
