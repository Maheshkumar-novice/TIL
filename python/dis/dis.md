`dis` module used for disassembling the python code.

for example,

```python
import dis

def hello():
    print('hello')

dis.dis(hello)
```

This will print the bytecode operations of the function.

More on this [here](https://docs.python.org/3/library/dis.html) 
