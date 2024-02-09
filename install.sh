#!/bin/env bash

HELPERS=(
    "interrupt" "banner" "log" "setup"
)

# load all helper function
for HELPER in "${HELPERS[@]}"; do
    # shellcheck disable=SC1090
    source helper/"${HELPER}".sh
done

trap 'interrupt' INT
banner
setup
