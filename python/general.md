TIL: Python dictionaries do maintain key insertion order. Atleast from python version `3.7`

TIL: `re.split` 

```python
>>> import re
>>> re.split(r'#|-', 'ab=')
['ab=']
>>> re.split(r'#', 'ab=')
['ab=']
>>> re.split(r'=|-', 'ab=')
['ab', '']
>>> re.split(r'=|-', 'ab-')
['ab', '']
>>> re.split(r'=|-', 'ab#')
['ab#']
>>> re.split(r'=|-', 'ab=3')
['ab', '3']
>>> 
```
