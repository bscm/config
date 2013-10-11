#!/usr/bin/env bats

load ../source

setup()
{
    cat > "${BATS_TMPDIR}/config.conf" <<EOF
Key1 ThisIsTheValue1
Key2    ThisIsTheValue2
Key-3 ThisIsTheValue3
Key_4 ThisIsTheValue4
Key5 This Is The Value 5
Key6 This Is The Value 6

# Comments Are Cool
Key6 ThisIsTheOtherValue6
EOF
}

teardown()
{
    rm "${BATS_TMPDIR}/config.conf"
}

@test "Read a config" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key1"

    [[ "${output}" = "ThisIsTheValue1" ]]
}

@test "Read a config with spaces in the begging of the ThisIsThevalue" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key2"

    [[ "${output}" = "ThisIsTheValue2" ]]
}

@test "Read a config with '-' char in the key" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key-3"

    [[ "${output}" = "ThisIsTheValue3" ]]
}

@test "Read a config with '_' char in the key" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key_4"

    [[ "${output}" = "ThisIsTheValue4" ]]
}

@test "Read a config with spaces in the value" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key5"

    [[ "${output}" = "This Is The Value 5" ]]
}

@test "Read the last config the the key repeat" {
    run config_read "${BATS_TMPDIR}/config.conf" "Key6"

    [[ "${output}" = "ThisIsTheOtherValue6" ]]
}
