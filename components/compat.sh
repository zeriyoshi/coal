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
