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

Tested shells
- bash (macOS / 5.0.11, macOS / 3.2.57)
- dash (macOS)
- yash (macOS / 2.49)
- ksh (macOS / 93u 2012-08-01)
- ash (Alpine Busybox / 1.30.1)
- sh (Alpine Busybox / 1.30.1)

## Notes

* `readlink_f` BSD/GNU compatible implementation is NOT support dynamic importing.
