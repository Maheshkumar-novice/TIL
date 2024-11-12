Screen Freezing Solution: https://askubuntu.com/questions/4408/what-should-i-do-when-ubuntu-freezes

While holding Alt and the SysReq (Print Screen) keys, type REISUB

R:  Switch to XLATE mode
E:  Send Terminate signal to all processes except for init
I:  Send Kill signal to all processes except for init
S:  Sync all mounted file-systems
U:  Remount file-systems as read-only
B:  Reboot

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

To view thread info (https://unixhealthcheck.com/blog?id=465)

Finding folder size

```sh
du -sh $(ls -A)
```

```sh
ps -T -p <pid>
```

To replace a piece of text using `sed` in a file,
```sh
sed -i '' -e s/old/new/g <file>
```

In vim,

```sh
:%s/old/new/g - global
:s/old/new/g - current line
```
