config_get()
{
    local name="${1}";
    local filename="${2}";
    local filename_fallback="${3}";

    config_read "${filename}" "${name}" ||
        config_read "${filename_fallback}" "${name}"
}
