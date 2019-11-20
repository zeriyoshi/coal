# Coal

![](https://github.com/zeriyoshi/coal/workflows/CI/badge.svg)

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
- bash
- dash
- yash
- ksh
- ash (Alpine Busybox / 1.30.1)
- sh (Alpine Busybox / 1.30.1)
- zsh 

## Notes

* `readlink_f` BSD/GNU compatible implementation is NOT support dynamic importing.
