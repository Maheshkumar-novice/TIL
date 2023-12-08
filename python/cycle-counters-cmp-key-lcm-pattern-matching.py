from math import lcm
# lcm(*args)

from collections import Counter
# Counter(iterable)

# callback body example for cmp_to_key
if v1 < v2:
		return -1
	elif v1 > v2:
		return 1
	else:
		return 0

from functools import cmp_to_key
sorted(iterable, key=cmp_to_key(callback))

from itertools import cycle
# https://github.com/oliver-ni/advent-of-code/blob/master/py/2023/day08.py


# Also refere `match..case` from the documentation those are cool for parsing values.
# https://github.com/oliver-ni/advent-of-code/blob/master/py/2023/day07.py

