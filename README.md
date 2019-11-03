# Coal

shell-script framework for POSIX environments.

```shell
$ ./example/example.sh usage
coal example - coal example application version 1.0.0 (https://github.com/zeriyoshi/coal)

Usage:
    ./example/example.sh [command]

Commands:
    foo                 foo - blah blah blah
    bar                 bar - nest example
    baz                 baz - external nest example
    posix_getopt        posix_getopt - getopt sample (--test=<value>)
    argument_parser     argument_parser - argument parsing example
    config              config - config example ([key] --set=<value>)
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
