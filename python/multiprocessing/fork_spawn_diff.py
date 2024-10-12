from multiprocessing import Process, set_start_method
import sys
print("here")

if sys.argv[1] == "fork":
    set_start_method('fork')
elif sys.argv[1] == "spawn":
    set_start_method("spawn") #default

def foo():
    print('hello')

p = Process(target=foo)
p.start()
