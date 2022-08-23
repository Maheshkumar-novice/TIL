Consider a file named `script.sh` and it's contents as follows.

```sh
#!/usr/bin/env bash
echo 'hello, world'
```

Let's see we are executing the file using the script execution notation.

`./script.sh`

This will fail as the file currently don't have the execution permission.
To see the permissions use `ls -l script.sh`.

To make it executable use `chmod +x script.sh`. Now `./script.sh` will work.

Or alternatively, to execute the file without execution permission. Use the following command,

`bash script.sh`


It'll execute the script without the permission of execution. This is because we are directly passing the file 
to the interpreter.

Explained in detail [here](https://askubuntu.com/questions/25681/can-scripts-run-even-when-they-are-not-set-as-executable)

