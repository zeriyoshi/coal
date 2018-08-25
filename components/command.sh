#!/bin/sh

___COAL_COMMAND_CALL_CANDIDATE=""

coal_command_import()
{
    alias "command_call"="coal_command_call"
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
    ___COAL_COMMAND_CALL_CANDIDATE="export_${1}_${2}"

    if ! type "${___COAL_COMMAND_CALL_CANDIDATE}" > /dev/null 2>&1; then
        return 1
    fi

    shift
    shift

    "${___COAL_COMMAND_CALL_CANDIDATE}" "${@}"
    exit
}

coal_command_extract()
{
    (
        NAMESPACE="${1}"
        FILE="${2}"

        cat "${FILE}" | awk "/export_${NAMESPACE}_.+\(\)/{print \$0}" | while read -r COMMAND; do
            COMMAND_NAME="$(echo "${COMMAND}" | sed "s/export_${NAMESPACE}_\(..*\)().*$/\1/")"
            COMMAND_INFO="$(echo "${COMMAND}" | sed "s/.* ## \(..*\)$/\1/" | sed 's/^export_.*$//')"
            printf "%s\t%s\n" "${COMMAND_NAME}" "${COMMAND_INFO}"
        done
    )
}
