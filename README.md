# Coal

shell-script framework for POSIX environments.

```shell
$ ./example/example.sh usage
coal example version 1.0.0 (https://github.com/zeriyoshi/coal)

Copyright (C) 2018 zeriyoshi.

Usage:
    ./example/example.sh [command]

Commands:
    foo         foo - blah blah blah
    bar         bar - nested example
    baz         [--foo=|--bar=|--baz=] baz - option example
    version             [-V|--version] version - show version
    usage               usage - show available commands.

```

## Supported environments

Any POSIX standard environments.

* macOS (bash, ksh, yash)
* FreeBSD (sh)
* Linux
    * Ubuntu 17.04 LST (bash, zsh, dash)
* Windows Subsystem on for Linux (Not tested currently)

## Notes

* `readlink_f` BSD/GNU compatible implementation is NOT support dynamic importing.
