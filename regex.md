Non capturing group, use `?:`

```python
r'(?:mul\([0-9]{1,3},[0-9]{1,3}\))|(?:do\(\))|(?:don\'t\(\))'
```

Repeating groups
`part_1_regex = re.compile(r"^(\d+)\1$")
    part_2_regex = re.compile(r"^(\d+)\1+$")`
