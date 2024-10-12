from multiprocessing import Pool

def f(x):
    import os; print(os.getpid(), x)
    return x*x

if __name__ == '__main__':
    with Pool(5) as p:
        print(p.map(f, range(50)))
