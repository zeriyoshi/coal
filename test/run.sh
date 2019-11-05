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

. "${SCRIPT_DIR}/../framework/framework.sh"

coal_framework_init "${SCRIPT_DIR}/../framework/components" "${SCRIPT_PATH}" \
    "coal test kit" \
    "coal compatibility test script" \
    "1.0.0" \
    "https://github.com/zeriyoshi/coal"

___TEST_SHELL="unknown"

techoinit()
{
    ___TEST_SHELL="${1}"
}

techo()
{
    echo "[${___TEST_SHELL}] " | writer_s_bold | writer_write
    echo "${1}" | writer_writeln
}

tcheck()
{
    echo "[${___TEST_SHELL}] " | writer_s_bold | writer_write
    echo "testing: " | writer_write
    echo "${1}" | writer_s_bold | writer_write
    echo "..." | writer_write
    if [ ! "${2}" = "${3}" ]; then
        echo "FAILED" | writer_c_red | writer_s_bold | writer_writeln
        exit 1
    else
        echo "SUCCESS" | writer_c_green | writer_s_bold | writer_writeln
    fi
}

texec()
{
    (
        EXEC_SHELL="${1}"
        shift
        echo "$("${EXEC_SHELL}" "$(framework_app_path)" ${@} 2> /dev/null)" 
    )
}

export_global_run() ## run all tests.
{
    for SHELL in bash dash yash zsh sh ash ksh; do
        techoinit "${SHELL}"
        if type "${SHELL}" >/dev/null 2>&1; then
            techo "found ${SHELL}."
            (command_call "test" "initialize")

            tcheck "simple command call" "$(texec "${SHELL}" "test" "simplecommandcall")" "OK"
            tcheck "nested command call" "$(texec "${SHELL}" "test" "nestedcommandcall")" "OK"
            tcheck "nested framework run" "$(texec "${SHELL}" "test" "nestedframeworkrun" "run" "OK")" "OK"
            tcheck "parse arguments" "$(texec "${SHELL}" "test" "parseargument" "V" "A" "L" "I" "D")" "OK"
            tcheck "POSIX getopt" "$(texec "${SHELL}" "test" "posixgetopt" "--foo=bar" "--bar" "-abc")" "OK"
            tcheck "config get" "$(texec "${SHELL}" "test" "configget")" "OK"
            tcheck "config set" "$(texec "${SHELL}" "test" "configset")" "OK"
            tcheck "writer stdout / err" "$(texec "${SHELL}" "test" "writerstdouterr")" "OK"
        else
            techo "$(echo "SKIP" | writer_c_red | writer_write) not found ${SHELL}."
        fi
    done
}

export_global_docker() ## run test on docker.
{
    framework_run "docker" "${SCRIPT_PATH}" "${@}"
}

export_docker_alpine() ## run test on alpine with docker.
{
    if type docker > /dev/null 2>&1; then
        docker run --rm -it -v"$(cd "$(framework_app_dir)/.." && pwd):/work" zeriyoshi/shell:alpine /work/test/run.sh run
    else
        echo "Docker not found." | writer_c_red | writer_s_bold | writer_writeln
    fi
}

export_docker_debian() ## run test on debian with docker.
{
    if type docker > /dev/null 2>&1; then
        docker run --rm -it -v"$(cd "$(framework_app_dir)/.." && pwd):/work" zeriyoshi/shell:debian /work/test/run.sh run
    else
        echo "Docker not found." | writer_c_red | writer_s_bold | writer_writeln
    fi
}

export_global_test() ## run testcase.
{
    framework_self_run "test" "${@}"
}

export_test_initialize() ## initializing test environment.
{
    echo "foo=bar
bar=baz" > "$(framework_app_dir)/config.conf"
}

export_test_simplecommandcall() ## simple command call.
{
    echo "OK"
}

export_test_nestedcommandcall() ## nested command call.
{
    command_call "test" "nestedcommandcallinvoke"
}

export_test_nestedcommandcallinvoke() ## nested command call. (invoke)
{
    echo "OK"
}

export_test_nestedframeworkrun() ## nested framework run.
{
    framework_self_run "nested" "${@}"
}

export_nested_run() ## nested framework run.
{
    echo "${@}"
}

export_test_parseargument() ## parse arguments.
{
    (
        RESULT=""
        for ARG in $(parser_args "${@}"); do
            RESULT="${RESULT}${ARG}"
        done
        if [ "${RESULT}" = "VALID" ]; then
            echo "OK"
        fi
    )
} 

export_test_posixgetopt() ## POSIX getopt.
{
    parser_parse "posixgetopt" "${@}"
    if [ "$(parser_option "posixgetopt" "foo")" = "bar" ] && \
       [ "$(parser_option "posixgetopt" "bar")" = "true" ] && \
       [ "$(parser_option "posixgetopt" "a")" = "true" ] && \
       [ "$(parser_option "posixgetopt" "b")" = "true" ] && \
       [ "$(parser_option "posixgetopt" "c")" = "true" ]; then
       echo "OK"
    fi
}

export_test_configget() ## config get.
{
    if [ "$(config_key_get "$(framework_app_dir)/config.conf" "foo")" = "bar" ] &&
       [ "$(config_key_get "$(framework_app_dir)/config.conf" "bar")" = "baz" ]; then
       echo "OK"
    fi
}

export_test_configset() ## config set.
{
    config_key_set "$(framework_app_dir)/config.conf" "baz" "OK"
    config_key_get "$(framework_app_dir)/config.conf" "baz"
}

export_test_writerstdouterr() ## writer stderr.
{
    echo "DUMMY" | writer_writeln
    echo "OK"
    echo "DUMMY" | writer_write
}

framework_self_run "global" "${@}"
