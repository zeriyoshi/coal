#!/bin/sh

___COAL_PARSER_PARSE_NAMESPACE_BUFFER=""
___COAL_PARSER_PARSE_OPTION_BUFFER=""
___COAL_PARSER_PARSE_VALUE_BUFFER=""

coal_parser_parse()
{
    if [ "${#}" -lt 2 ]; then
        return 1
    fi

    ___COAL_PARSER_PARSE_NAMESPACE_BUFFER="${1}"
    shift

    if [ "$(echo "${1}" | cut -c1)" = "-" ]; then
        ___COAL_PARSER_PARSE_OPTION_BUFFER="$(echo "${1}" | sed 's/=.*$//')"
        ___COAL_PARSER_PARSE_VALUE_BUFFER="$(echo "${1}" | sed 's/^.*=//')"
        if [ "${___COAL_PARSER_PARSE_OPTION_BUFFER}" = "${___COAL_PARSER_PARSE_VALUE_BUFFER}" ]; then
            ___COAL_PARSER_PARSE_VALUE_BUFFER="true"
        fi

        if [ "${___COAL_PARSER_PARSE_VALUE_BUFFER}" = "" ]; then
            ___COAL_PARSER_PARSE_VALUE_BUFFER="true"
        fi
        if [ "$(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c2)" = "-" ]; then
            ___COAL_BUFFER="___COAL_PARSER_PARSE_NAMESPACE_${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}_$(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c3-)"
            eval ${___COAL_BUFFER}="${___COAL_PARSER_PARSE_VALUE_BUFFER}"
        else
            for ___COAL_BUFFER in $(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c2- | grep -oE '.{1}'); do
                ___COAL_BUFFER="___COAL_PARSER_PARSE_NAMESPACE_${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}_${___COAL_BUFFER}"
                eval ${___COAL_BUFFER}="${___COAL_PARSER_PARSE_VALUE_BUFFER}"
            done
        fi
    else
        return 0
    fi

    shift
    coal_parser_parse "${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}" "${@}"
}

coal_parser_parse "global" "${@}"

set | grep COAL