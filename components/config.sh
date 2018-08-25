#!/bin/sh

coal_config_import()
{
    alias "config_key_get"="coal_config_key_get"
    alias "config_key_set"="coal_config_key_set"
}

coal_config_short_import()
{
    coal_config_import

    alias "key_get"="config_key_get"
    alias "key_set"="config_key_set"
}

coal_config_key_get()
{
    if [ "${#}" -lt 2 ]; then
        return 1
    fi

    cat "${1}" | grep "^${2}" | sed "s/^${2}=//"
}

coal_config_key_set()
{
    if [ "${#}" -lt 3 ]; then
        return 1
    fi

    (
        TRUNCATED_DATA="$(cat "${1}" | sed "/^${2}=.*\$/d")"
        printf "%s\n%s\n" "${2}=${3}" "${TRUNCATED_DATA}" > "${1}"
    )
}
