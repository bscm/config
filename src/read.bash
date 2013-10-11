config_read()
{
    local filename="${1}";
    local name="${2}"
    local pattern="^[A-Za-z0-9_-]+ +(.+)"
    local content

    if [[ ! -f "${filename}" ]]; then
        return 1
    fi

    content=$(grep "^${name}" "${filename}" | tail -n1)

    if [[ -z "${content}" ]]; then
        return 2
    fi

    echo "${content}" | egrep -q "${pattern}"

    if [[ ${?} -eq 0 ]]; then
        echo "${content}" |
            sed -E "s/${pattern}/\1/g"
    fi
}
