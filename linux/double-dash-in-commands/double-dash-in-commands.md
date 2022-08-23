Example,

Let's say we want to create a file named `--hello`

`touch --hello`

This will throw the error that says the option is not recognized.

To overcome this issue. We use the following format,

`touch -- --hello`

After creating this file for some reason you want to delete so we are using `rm` command.

`rm --hello`

Again this also throws the same error as with the touch command we've seen before.

To overcome this,

`rm -- --hello`

So what is the purpose of `--`?

This means the end of command options and the following things after the `--` are treated as positional arguments.

You can read more about this using the following links.

[Stack Exchange](https://unix.stackexchange.com/questions/11376/what-does-double-dash-mean)
[Baeldung](https://www.baeldung.com/linux/double-dash-in-shell-commands)
