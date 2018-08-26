#!/bin/sh

export_bar_hoge() ## hoge - example command
{
    echo "hoge"
}

export_bar_fuga() ## [--piyo=] fuga - example command
{
    parser_parse "bar_fuga" "${@}"
    echo "fuga (--piyo : $(parser_option "bar_fuga" "piyo"))"
}

export_bar_usage() ## usage - show available bar sub-commands
{
    export_global_version

    (
        echo
        echo "Usage:" | s_bold | c_yellow | writeln
        echo "    ${SCRIPT_PATH} bar [command]"
        echo
        echo "Commands:" | s_bold | c_yellow | writeln
        command_extract "bar" "${SCRIPT_DIR}/commands/bar.source.sh" | while read -r COMMAND; do
            echo "${COMMAND}" | sed "s/^\(.*\)$(printf "\t").*\$/    \1/" | c_magenta | write
            echo "${COMMAND}" | sed "s/^.*$(printf "\t")\(.*\)\$/$(printf "\t\t")\1/" | writeln
        done
    )
}

(
    SCRIPT_INIT_ARGS="${@}"

    parser_parse "bar" "${@}"
    while [ "${#}" -gt "0" ]; do
        command_call "bar" "${@}"
        shift
    done

    echo "[ERROR]" | s_bold | c_red | write; echo " Invalid command : " | write; echo "${SCRIPT_INIT_ARGS}" | c_magenta | writeln
    export_bar_usage
)
