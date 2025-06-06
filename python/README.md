Debugging resources,
* https://pypi.org/project/remote-pdb/ Remote debug multiprocess env like connector
* https://github.com/kmaork/madbg - To attach debugger to existing process

Finding a package before installing,

https://github.com/huggingface/accelerate/blob/main/src/accelerate/utils/imports.py#L49

```py
def _is_package_available(pkg_name, metadata_name=None):
    # Check we're not importing a "pkg_name" directory somewhere but the actual library by trying to grab the version
    package_exists = importlib.util.find_spec(pkg_name) is not None
    if package_exists:
        try:
            # Some libraries have different names in the metadata
            _ = importlib.metadata.metadata(pkg_name if metadata_name is None else metadata_name)
            return True
        except importlib.metadata.PackageNotFoundError:
            return False
```

```py
def is_rich_available():
    if _is_package_available("rich"):
        return parse_flag_from_env("ACCELERATE_ENABLE_RICH", False)
    return False
```

```py
if is_rich_available():
    from rich import get_console
    from rich.logging import RichHandler

    FORMAT = "%(message)s"
    logging.basicConfig(format=FORMAT, datefmt="[%X]", handlers=[RichHandler()])
```


Instead of using replace to replace chars in chain, try to use `maketrans` and `translate`.

```py
string.translate(str.maketrans("501", "SOI"))
```

`|` vs `+`

https://stackoverflow.com/questions/55498263/bitwise-or-versus-addition-for-positive-powers-of-two-in-python


```python
a = [1]
print(a[False])
print(False - True)
```
