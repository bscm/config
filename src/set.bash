config_set()
{
    local name="${1}"
    local value="${2}"
    local filename="${3}"

    if [[ -z "${filename}" ]] || [[ ! -f "${filename}" ]]; then
        return 1
    fi

    echo "${name} ${value}" >> "${filename}"
}
