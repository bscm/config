#!/usr/bin/env bats

load ../source

teardown()
{
    if [[ -f "${BATS_TMPDIR}/config.conf" ]]; then
        rm "${BATS_TMPDIR}/config.conf"
    fi
}

@test "Define a config" {
    run config_set 'KeyName' 'KeyValue' "${BATS_TMPDIR}/config.conf"

    [[ ${status} -eq 0 ]]

    actual=$(cat "${BATS_TMPDIR}/config.conf")
    expected="KeyName KeyValue"


    [[ "${actual}" = "${expected}"  ]]
}
