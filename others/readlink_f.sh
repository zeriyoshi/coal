#!/bin/sh

readlink_f()
{
    (
        if [ "${1}" = "" ]; then
            return 1
        fi

        TARGET_PATH="${1}"

        while [ -L "${TARGET_PATH}" ]; do
            READLINK_PATH="$(readlink "${TARGET_PATH}")"
            TARGET_PATH="$(cd "$(dirname "${TARGET_PATH}")"; cd "$(dirname "${READLINK_PATH}")"; pwd)/$(basename "${READLINK_PATH}")"
        done
        echo "${TARGET_PATH}"
    )
}
