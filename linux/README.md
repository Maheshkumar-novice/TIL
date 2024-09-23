To read from stdin and write to file

```sh
cat > myspider.py <<EOF
```

Find in subfolder with a particular text,

```sh
find <folder> -type f -name something.json -exec grep -l -P '^\s*\{\s*\}\s*$' {} \; | wc -l
```
This is to match files contains `{}`, if we use `-L` in grep we will get opposite results.

Gpustat

```sh
gpustat -cp

watch -n 0.5 -c gpustat -cp --color

gpustat -cp --watch
```

To exit or exit hung up ssh connection,

```sh
~.
```
