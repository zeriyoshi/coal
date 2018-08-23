#!/bin/sh

coal_polyfill_import()
{
    alias "readlink_f"="coal_polyfill_readlink_f"
}

coal_polyfill_readlink_f()
{
    ___COAL_BUFFER="${1}"
    while [ -L "${___COAL_BUFFER}" ]; do
        ___COAL_BUFFER="$(cd "$(dirname "${___COAL_BUFFER}")"; cd "$(dirname "$(readlink "${___COAL_BUFFER}")")"; pwd)/$(basename "$(readlink "${___COAL_BUFFER}")")"
    done
    echo "${___COAL_BUFFER}"
}

