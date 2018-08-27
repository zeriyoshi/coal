#!/bin/sh

___COAL_FRAMEWORK_INIT_COMPONENTS_DIR=""
___COAL_FRAMEWORK_INIT_APP_PATH=""
___COAL_FRAMEWORK_INIT_APP_NAME=""
___COAL_FRAMEWORK_INIT_APP_VERSION=""
___COAL_FRAMEWORK_INIT_APP_URI=""
___COAL_FRAMEWORK_INIT_APPENDIX=""
___COAL_FRAMEWORK_RUN_NAMESPACE=""
___COAL_FRAMEWORK_RUN_PATH=""
___COAL_FRAMEWORK_RUN_CHILDREN_DIR=""
___COAL_FRAMEWORK_RUN_ARGS=""

coal_framework_import()
{
    alias "framework_init"="coal_framework_init"
    alias "framework_components_dir"="coal_framework_components_dir"
    alias "framework_app_path"="coal_framework_app_path"
    alias "framework_app_name"="coal_framework_app_name"
    alias "framework_app_version"="coal_framework_app_version"
    alias "framework_app_uri"="coal_framework_app_uri"
    alias "framework_generate_usage"="coal_framework_generate_usage"
    alias "framework_run"="coal_framework_run"
}

coal_framework_short_import()
{
    coal_framework_import

    alias "init"='framework_init'
    alias "components_dir"="framework_components_dir"
    alias "app_path"="framework_app_path"
    alias "app_name"="framework_app_name"
    alias "app_version"="framework_app_version"
    alias "app_uri"="framework_app_uri"
    alias "generate_usage"="framework_generate_usage"
    alias "run"="framework_run"
}

coal_framework_init()
{
    ___COAL_FRAMEWORK_INIT_COMPONENTS_DIR="${1}"
    ___COAL_FRAMEWORK_INIT_APP_PATH="${2}"
    ___COAL_FRAMEWORK_INIT_APP_NAME="${3}"
    ___COAL_FRAMEWORK_INIT_APP_VERSION="${4}"
    ___COAL_FRAMEWORK_INIT_APP_URI="${5}"
    ___COAL_FRAMEWORK_INIT_APPENDIX="${6}"

    if [ ! -f "${___COAL_FRAMEWORK_INIT_APP_PATH}" ]; then
        return 1
    fi

    if [ ! -d "${___COAL_FRAMEWORK_INIT_COMPONENTS_DIR}" ]; then
        return 1
    fi

    coal_framework_import

    for ___COAL_BUFFER in $(find "${___COAL_FRAMEWORK_INIT_COMPONENTS_DIR}" -maxdepth 1 -mindepth 1 -type f); do
        . "${___COAL_BUFFER}"
        "coal_$(basename "${___COAL_BUFFER}" | sed 's/\.sh$//')_import"
    done

    coal_writer_short_import

    export_global_version()
    {
        if [ ! "$(coal_parser_option "version" "version")" = "" ] || [ ! "$(coal_parser_option "version" "V")" = "" ]; then
            echo "${___COAL_FRAMEWORK_INIT_APP_VERSION}"
            return 0
        fi

        echo "${___COAL_FRAMEWORK_INIT_APP_NAME}" | coal_writer_style_bold | coal_writer_color_cyan | coal_writer_write; echo " version " | coal_writer_write; echo "${___COAL_FRAMEWORK_INIT_APP_VERSION}" | coal_writer_style_bold | coal_writer_color_yellow | coal_writer_write
        if [ ! "${___COAL_FRAMEWORK_INIT_APP_URI}" = "" ]; then
            echo " (${___COAL_FRAMEWORK_INIT_APP_URI})"
        fi
        echo | coal_writer_write

        if [ ! "${___COAL_FRAMEWORK_INIT_APPENDIX}" = "" ]; then
            echo
            echo "${___COAL_FRAMEWORK_INIT_APPENDIX}"
        fi
    }
}

coal_framework_components_dir()
{
    echo "${___COAL_FRAMEWORK_INIT_COMPONENTS_DIR}"
}

coal_framework_app_path()
{
    echo "${___COAL_FRAMEWORK_INIT_APP_PATH}"
}

coal_framework_app_name()
{
    echo "${___COAL_FRAMEWORK_INIT_APP_NAME}"
}

coal_framework_app_version()
{
    echo "${___COAL_FRAMEWORK_INIT_APP_VERSION}"
}

coal_framework_app_uri()
{
    echo "${___COAL_FRAMEWORK_INIT_APP_URI}"
}

coal_framework_generate_usage()
{
    (
        NAMESPACE="${1}"
        SCRIPT_PATH="${2}"

        if [ "$(coal_command_extract "${NAMESPACE}" "${SCRIPT_PATH}")" = "" ]; then
            return
        fi

        export_global_version

        echo
        echo "Usage:" | coal_writer_style_bold | coal_writer_color_yellow | coal_writer_writeln
        echo "    ${SCRIPT_PATH} " | coal_writer_write
        if [ ! "${NAMESPACE}" = "global" ]; then
            echo "${NAMESPACE} " | coal_writer_write
        fi
        echo "[command]" | coal_writer_writeln
        echo
        echo "Commands:" | coal_writer_style_bold | coal_writer_color_yellow | coal_writer_writeln
        coal_command_extract "${NAMESPACE}" "${SCRIPT_PATH}" | while read -r COMMAND; do
            echo "${COMMAND}" | sed "s/^\(.*\)$(printf "\t").*\$/    \1/" | coal_writer_color_magenta | coal_writer_write
            echo "${COMMAND}" | sed "s/^.*$(printf "\t")\(.*\)\$/$(printf "\t\t")\1/" | coal_writer_writeln
        done
    )
}

coal_framework_run()
{
    ___COAL_FRAMEWORK_RUN_NAMESPACE="${1}"
    ___COAL_FRAMEWORK_RUN_PATH="${2}"
    ___COAL_FRAMEWORK_RUN_CHILDREN_DIR="${3}"
    shift
    shift
    shift

    ___COAL_FRAMEWORK_RUN_ARGS="${@}"
    coal_parser_parse "${___COAL_FRAMEWORK_RUN_NAMESPACE}" "${___COAL_FRAMEWORK_RUN_ARGS}"

    while [ "${#}" -gt "0" ]; do
        if coal_command_exists "${___COAL_FRAMEWORK_RUN_NAMESPACE}" "${@}"; then
            coal_parser_parse "${___COAL_FRAMEWORK_RUN_NAMESPACE}" "${@}"
            coal_command_call "${___COAL_FRAMEWORK_RUN_NAMESPACE}" "${@}"
        fi
        shift
    done

    set "${___COAL_FRAMEWORK_RUN_ARGS}"

    while [ "${#}" -gt "0" ]; do
        if [ -f "${___COAL_FRAMEWORK_RUN_CHILDREN_DIR}/${1}.coal.sh" ]; then
            . "${___COAL_FRAMEWORK_RUN_CHILDREN_DIR}/${1}.coal.sh"
            exit
        fi
        shift
    done

    if [ ! "${___COAL_FRAMEWORK_RUN_ARGS}" = "" ];then
        echo "[ERROR]" | coal_writer_style_bold | coal_writer_color_red | coal_writer_write; echo " Invalid command : " | coal_writer_write; echo "${___COAL_FRAMEWORK_RUN_ARGS}" | coal_writer_color_magenta | coal_writer_writeln
    fi

    coal_framework_generate_usage "${___COAL_FRAMEWORK_RUN_NAMESPACE}" "${___COAL_FRAMEWORK_RUN_PATH}"

    return 1
}