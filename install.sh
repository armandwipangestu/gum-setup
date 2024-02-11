#!/bin/env bash

HELPERS=(
    interrupt banner log setup
    zsh nvchad spin
)

# load all helper function
for HELPER in "${HELPERS[@]}"; do
    # shellcheck disable=SC1090
    source helper/"${HELPER}".sh
done

trap 'interrupt' INT
banner
setup

# Check and execute selected setups
IFS=$'\n'
# shellcheck disable=SC2153
for SELECTED_SETUP in $SELECTED_SETUPS; do
    case $SELECTED_SETUP in
    "ZSH + Oh My Posh")
        zshOhMyPosh
        ;;
    "NvChad")
        nvChad
        ;;
    # Add more setups as needed...
    *)
        log warn "Unknown setup: $SELECTED_SETUP"
        ;;
    esac
done
