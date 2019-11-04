#!/bin/sh

readlink_f()
{
    (
        TARGET_PATH="${1}"
        if [ "${TARGET_PATH}" = "" ]; then return 1; fi
        while [ -L "${TARGET_PATH}" ]; do
            READLINK_PATH="$(readlink "${TARGET_PATH}")"
            TARGET_PATH="$(cd "$(dirname "${TARGET_PATH}")"; cd "$(dirname "${READLINK_PATH}")"; pwd)/$(basename "${READLINK_PATH}")"
        done
        echo "${TARGET_PATH}"
    )
}

SCRIPT_PATH="$(readlink_f "${0}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"

. "${SCRIPT_DIR}/../framework/framework.sh"

coal_framework_import

framework_init "${SCRIPT_DIR}/../framework/components" "${SCRIPT_PATH}" \
    "coal example" \
    "coal example application" \
    "1.0.0" \
    "https://github.com/zeriyoshi/coal"

export_global_foo() ## foo - blah blah blah
{
    while [ "${#}" -gt "0" ]; do
        echo "${1}"
        shift
    done
}

export_global_bar() ## bar - nest example
{
    framework_run "bar" "${SCRIPT_PATH}" "${@}"
}

export_bar_one() ## one
{
    echo "one"
}

export_bar_two() ## two
{
    echo "two"
}

export_bar_three() ## three
{
    echo "three"
}

export_global_baz() ## baz - external nest example
{
    . "${SCRIPT_DIR}/baz.source.sh"
    framework_run "baz" "${SCRIPT_DIR}/baz.source.sh" "${@}"
}

export_global_posix_getopt() ## posix_getopt - getopt sample (--test=<value>)
{
    parser_parse "posix_getopt" "${@}"
    parser_option "posix_getopt" "test"
}

export_global_argument_parser() ## argument_parser - argument parsing example
{
    parser_args "${@}" | xargs -IVALUE echo "arg: VALUE"
}

export_global_config() ## config - config example ([key] --set=<value>)
{
    if [ "${#}" -lt "1" ]; then
        echo "[ERROR] require key" | writer_s_bold | writer_c_red | writer_writeln
        return 1
    fi

    CONFIG_KEY="${1}"
    shift

    parser_parse "config" "${@}"
    if [ ! "$(parser_option "config" "set")" = "" ]; then
        config_key_set "${SCRIPT_DIR}/example.config" "${CONFIG_KEY}" "$(parser_option "config" "set")"
    fi

    config_key_get "${SCRIPT_DIR}/example.config" "${CONFIG_KEY}"
}

framework_run "global" "${SCRIPT_PATH}" "${@}"
