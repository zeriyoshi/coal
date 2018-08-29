#!/bin/sh

# ------------------------------------------------
# Coal - shell script command line framework.
#
# https://github.com/zeriyoshi/coal
# ------------------------------------------------

___COAL_PARSER_PARSE_NAMESPACE_BUFFER=""
___COAL_PARSER_PARSE_OPTION_BUFFER=""
___COAL_PARSER_PARSE_VALUE_BUFFER=""

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
    if [ "${#}" -lt 2 ]; then
        return 1
    fi

    ___COAL_PARSER_PARSE_NAMESPACE_BUFFER="${1}"
    shift

    if [ "$(echo "${1}" | cut -c1)" = "-" ]; then
        ___COAL_PARSER_PARSE_OPTION_BUFFER="$(echo "${1}" | sed 's/=.*$//')"
        ___COAL_PARSER_PARSE_VALUE_BUFFER="$(echo "${1}" | sed 's/^.*=//')"
        if [ "${___COAL_PARSER_PARSE_OPTION_BUFFER}" = "${___COAL_PARSER_PARSE_VALUE_BUFFER}" ] || [ "${___COAL_PARSER_PARSE_VALUE_BUFFER}" = "" ]; then
            ___COAL_PARSER_PARSE_VALUE_BUFFER="true"
        fi
        if [ "$(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c2)" = "-" ]; then
            ___COAL_BUFFER="___COAL_PARSER_PARSE_NAMESPACE_${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}_$(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c3-)"
            eval ${___COAL_BUFFER}="\"${___COAL_PARSER_PARSE_VALUE_BUFFER}\""
        else
            for ___COAL_BUFFER in $(echo "${___COAL_PARSER_PARSE_OPTION_BUFFER}" | cut -c2- | grep -oE '.{1}'); do
                ___COAL_BUFFER="___COAL_PARSER_PARSE_NAMESPACE_${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}_${___COAL_BUFFER}"
                eval ${___COAL_BUFFER}="\"${___COAL_PARSER_PARSE_VALUE_BUFFER}\""
            done
        fi
    else
        return 0
    fi

    shift
    coal_parser_parse "${___COAL_PARSER_PARSE_NAMESPACE_BUFFER}" "${@}"
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
