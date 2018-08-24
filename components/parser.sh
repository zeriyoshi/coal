#!/bin/sh

___COAL_PARSER_PARSE_OPTION_BUFFER=""

coal_parser_import()
{
    alias "parser_parse"="coal_parser_parse"
    alias "parser_option"="coal_parser_option"
    alias "parser_args"="coal_parser_args"
}

coal_parser_short_import()
{
    coal_parser_import

    alias "parse"="parser_parse"
    alias "option"="parser_option"
    alias "args"="parser_args"
}

coal_parser_parse()
{
    ___COAL_PARSER_PARSE_NAMESPACE_BUFFER="${1}"
    shift

    if [ ! "${___COAL_PARSER_PARSE_OPTION_BUFFER}" = "" ]; then
        ___COAL_BUFFER="$(echo "___COAL_PARSER_PARSE_NAMESPACE_${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}_${___COAL_PARSER_PARSE_OPTION_BUFFER}")"
        if [ ! "${1}" = "" ]; then
            eval ${___COAL_BUFFER}="${1}"
        else
            eval ${___COAL_BUFFER}="true"
        fi
        ___COAL_PARSER_PARSE_OPTION_BUFFER=""
    fi
    if [ "$(echo ${1} | cut -c1)" = "-" ]; then
        if [ "$(echo ${1} | cut -c2)" = "-" ]; then
            ___COAL_PARSER_PARSE_OPTION_BUFFER="$(echo "${1}" | cut -c3-)"
            coal_parser_parse "${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}" "${2}"
        else
            for ___COAL_BUFFER in $(echo "${1}" | cut -c2- | grep -oE ".{1}"); do
                ___COAL_PARSER_PARSE_OPTION_BUFFER="${___COAL_BUFFER}"
                coal_parser_parse "${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}" "${2}"
            done
        fi
    fi

    if [ ! "$(echo "${2}" | cut -c1)" = "-" -a ! "$(echo "${1}" | cut -c1)" = "-" ] || [ ! "$(echo "${1}" | cut -c1)" = "-" ]; then
        return
    fi

    if [ ! "${2}" = "" ]; then
        shift
        coal_parser_parse "GLOBAL" "${@}"
    fi
}

coal_parser_option()
{
    if [ ! "${#}" = "2" ]; then
        return 1
    fi

    eval echo '$___COAL_PARSER_PARSE_NAMESPACE_'"${1}"'_'"${2}"
}

coal_parser_args()
{
    (
        ARGUMENT_CANDIDATE="${1}"
        shift

        if [ ! "$(echo "${1}" | cut -c1)" = "-" -a ! "$(echo "${ARGUMENT_CANDIDATE}" | cut -c1)" = "-" ] || [ ! "$(echo "${ARGUMENT_CANDIDATE}" | cut -c1)" = "-" ]; then
            echo "${ARGUMENT_CANDIDATE}"
            for ARGUMENT in "${@}"; do
                echo "${ARGUMENT}"
            done
            return
        fi
        coal_parser_args "${@}"
    )
}
