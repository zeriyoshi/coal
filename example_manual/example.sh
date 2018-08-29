#!/bin/sh

coal_compat_import()
{
    alias "compat_readlink_f"="coal_compat_readlink_f"
}

coal_compat_short_import()
{
    coal_compat_import

    alias "readlink_f"="compat_readlink_f"
}

coal_compat_readlink_f()
{
    (
        TARGET_PATH="${1}"
        while [ -L "${TARGET_PATH}" ]; do
            TARGET_PATH="$(cd "$(dirname "${TARGET_PATH}")"; cd "$(dirname "$(readlink "${TARGET_PATH}")")"; pwd)/$(basename "$(readlink "${TARGET_PATH}")")"
        done
        echo "${TARGET_PATH}"
    )
}

# Note : compat readlink_f does not support dynamic importing.

coal_compat_short_import

SCRIPT_PATH="$(readlink_f "${0}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"
SCRIPT_INIT_ARGS="${@}"
SCRIPT_VERSION="1.0.0"
SCRIPT_UPSTREAM_URI="https://github.com/zeriyoshi/coal"

. "${SCRIPT_DIR}/../framework/components/writer.sh"
. "${SCRIPT_DIR}/../framework/components/parser.sh"
. "${SCRIPT_DIR}/../framework/components/config.sh"
. "${SCRIPT_DIR}/../framework/components/command.sh"

coal_writer_short_import
coal_parser_import
coal_config_import
coal_command_import

export_global_foo() ## foo - blah blah blah
{
    echo "Hello " | s_bold | c_cyan | write; echo "World" | s_blink | s_bold | c_yellow | writeln
}

export_global_bar() ## bar - nested example
{
    . "${SCRIPT_DIR}/commands/bar.source.sh"
}

export_global_baz() ## [--foo=|--bar=|--baz=] baz - option example
{
    parser_parse "baz" "${@}"

    (
        for OPTION in "foo" "bar" "baz"; do
            echo "Option" | write; echo " ${OPTION} " | s_bold | c_magenta | write; echo " : " | write; parser_option "baz" "${OPTION}" | s_bold | c_yellow | writeln
        done
    )
}

export_global_version() ## [-V|--version] version - show version
{
    parser_parse "version" "${@}"

    if [ ! "$(parser_option "version" "version")" = "" ] || [ ! "$(parser_option "version" "V")" = "" ]; then
        echo "${SCRIPT_VERSION}"
        return 0
    fi

    echo "coal example" | s_bold | c_cyan | write; echo " version " | write; echo "${SCRIPT_VERSION}" | s_bold | c_yellow | write; echo " (${SCRIPT_UPSTREAM_URI})" | writeln
    echo
    echo "Copyright (C) 2018 zeriyoshi."
}

export_global_usage() ## usage - show available commands.
{
    export_global_version

    (
        echo
        echo "Usage:" | s_bold | c_yellow | writeln
        echo "    ${SCRIPT_PATH} [command]"
        echo
        echo "Commands:" | s_bold | c_yellow | writeln
        command_extract "global" "${SCRIPT_PATH}" | while read -r COMMAND; do
            echo "${COMMAND}" | sed "s/^\(.*\)$(printf "\t").*\$/    \1/" | c_magenta | write
            echo "${COMMAND}" | sed "s/^.*$(printf "\t")\(.*\)\$/$(printf "\t\t")\1/" | writeln
        done
    )
}

parser_parse "global" "${@}"

while [ "${#}" -gt "0" ]; do
    command_call "global" "${@}"
    shift
done

echo "[ERROR]" | s_bold | c_red | write; echo " Invalid command : " | write; echo "${SCRIPT_INIT_ARGS}" | c_magenta | writeln

export_global_usage
