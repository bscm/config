#!/usr/bin/env bats

load ../source

setup()
{
    cat > "${BATS_TMPDIR}/config_1.conf" <<EOF
Key1    Config1Key1
Key2    Config1Key2
EOF
    cat > "${BATS_TMPDIR}/config_2.conf" <<EOF
Key1    Config2Key1
Key2    Config2Key2
Key3    Config2Key3
EOF
    cat > "${BATS_TMPDIR}/config_3.conf" <<EOF
Key1    Config3Key1
Key2    Config3Key2
Key3    Config3Key3
Key4    Config3Key4
Key5    Config3Key5
EOF
}

teardown()
{
    rm "${BATS_TMPDIR}/config_1.conf"
    rm "${BATS_TMPDIR}/config_2.conf"
    rm "${BATS_TMPDIR}/config_3.conf"
}

@test "Finish with 1 when there is no config file" {
    run config_get "Key1"

    [[ ${status} -eq 1 ]]
}

@test "Finish with 2 when config was not found" {
    run config_get "Key3" "${BATS_TMPDIR}/config_1.conf"

    [[ ${status} -eq 2 ]]

    run config_get "Key3" "${BATS_TMPDIR}/config_4.conf"

    [[ ${status} -eq 2 ]]
}

@test "Get config of a simple file" {
    run config_get "Key1" "${BATS_TMPDIR}/config_1.conf"

    [[ "${output}" = "Config1Key1" ]]
    run config_get "Key1" "${BATS_TMPDIR}/config_2.conf"

    [[ "${output}" = "Config2Key1" ]]
    run config_get "Key1" "${BATS_TMPDIR}/config_3.conf"
}

@test "Get config using multiple files" {
    run config_get "Key5" "${BATS_TMPDIR}/config_1.conf" "${BATS_TMPDIR}/config_2.conf" "${BATS_TMPDIR}/config_3.conf"

    [[ "${output}" = "Config3Key5" ]]
}
