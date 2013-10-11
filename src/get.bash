# @depends config_read
config_get()
{
    local name="${1}";

    shift

    if [[ ${#} -eq 0 ]]; then
        return 1
    fi

    while [[ ! -z "${1}" ]]; do
        config_read "${1}" "${name}"
        if [[ ${?} -eq 0 ]]; then
            return 0
        else
            shift
        fi
    done

    return 2
}
