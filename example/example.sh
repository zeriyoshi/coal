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

SCRIPT_PATH="$(readlink_f "${0}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"

. "${SCRIPT_DIR}/../framework.sh"

coal_framework_import

framework_init "${SCRIPT_DIR}/../components" "${SCRIPT_PATH}" "coal example" "1.0.0" "https://github.com/zeriyoshi/coal"

export_global_test() ## foobar
{
    echo "${@}"
}

framework_run "global" "${SCRIPT_PATH}" "${SCRIPT_DIR}/commands" "${@}"
