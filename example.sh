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

. "${SCRIPT_DIR}/components/writer.sh"
. "${SCRIPT_DIR}/components/parser.sh"
. "${SCRIPT_DIR}/components/command.sh"

coal_writer_short_import
coal_parser_import
coal_command_import

export_global_foo() ## Foo command
{
    echo "Hello." | s_bold | c_cyan | writeln
}

export_global_bar() ## Bar command
{
    echo "${@}"
    parser_parse "bar" "${@}"

    echo "option --bar : " | s_bold | c_cyan | write; echo "$(parser_option "bar" "bar")" | writeln
}

export_global_baz() ## Baz command
{
    export_baz_hoge() ## Hoge command
    {
        echo "hoge"
    }

    export_baz_fuga() ## Fuga command
    {
        echo "fuga"
    }

    export_baz_usage() ## Show baz usage
    {
        command_extract "baz" "${SCRIPT_PATH}" | while read -r COMMAND; do
            echo "${COMMAND}"
        done
    }

    parser_parse "baz" "${@}"

    while [ "${#}" -gt "0" ]; do
        command_call "baz" "${@}"
        shift
    done

    export_baz_usage
}


export_global_usage() ## Show usage
{
    command_extract "global" "${SCRIPT_PATH}" | while read -r COMMAND; do
        echo "${COMMAND}"
    done
}

parser_parse "global" "${@}"

while [ "${#}" -gt 0 ]; do
    command_call "global" "${@}"
    shift
done

export_global_usage
