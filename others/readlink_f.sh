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
