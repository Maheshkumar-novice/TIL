# What's the difference between /usr/bin/bash and usr/bin/env bash?

I found this here: [Article](https://www.baeldung.com/linux/bash-shebang-lines)

When a script gets executed when the kernel sees `#!/usr/bin/bash` then a bash process will be created with an argument of the current script file name.

Example:

Contents of script.sh
```sh
#!/usr/bin/bash

echo "Hello"
```

```sh
chmod +x script.sh
./script.sh
```

What happens in the background?

```sh
bash ./script.sh
```

The same applies to `/usr/bin/env bash`

```sh
env bash ./script.sh
```

In this case `env` command gets two arguments `bash` and the script file name. It is because `env` command is capable of executing a command.

Another thing to note down is that the script was executed because it has a `/` in the name.

```sh
date
```

Program file in the `$PATH` will get executed because we don't see a `/` here.

```sh
./script.sh
```

Execute the given file because we have a `/` in the command name.

# Please create an Issue or a PR if you find a typo or something.
