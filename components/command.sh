#!/bin/sh

coal_command_import()
{
    alias "command_call"="coal_command_coal"
    alias "command_extract"="coal_command_extract"
}

coal_command_short_import()
{
    coal_command_import

    alias "call"="command_call"
    alias "extract"="command_extract"
}

coal_command_call()
{
    (
        NAMESPACE="${1}"
        TARGET="${2}"
        COMMAND_CANDIDATE="export_${NAMESPACE}_${TARGET}"

        if [ ! "$(type -t "${COMMAND_CANDIDATE}")" = "function" ]; then
            return 1
        fi

        "${COMMAND_CANDIDATE}" "${@}"
    )
}

coal_command_extract()
{
    (
        NAMESPACE="${1}"
        FILE="${2}"
        TAB="$(printf "\t")"

        cat "${FILE}" | awk "/^export_${NAMESPACE}_.+()/{print \$0}" | while read -r COMMAND; do
            COMMAND_NAME="$(echo "${COMMAND}" | sed "s/^export_${NAMESPACE}_\(..*\)().*$/\1/")"
            COMMAND_INFO="$(echo "${COMMAND}" | sed "s/.* ## \(..*\)$/\1/" | sed 's/^export_.*$//')"
            printf "%s\t%s\n" "${COMMAND_NAME}" "${COMMAND_INFO}"
        done
    )
}
