import inspect

# To get the caller of the function

curframe = inspect.currentframe()
calframe = inspect.getouterframes(curframe, 2)

print(f'Called: DB Engine, Caller Name: {calframe[1][3]}')
