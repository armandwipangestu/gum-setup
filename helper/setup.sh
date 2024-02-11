#!/bin/env bash

SETUPS=(
    "ZSH + Oh My Posh" "NvChad"
)

function setup() {
    gum format <markdown/setup.md
    echo ""
    SELECTED_SETUPS=$(gum choose --no-limit "${SETUPS[@]}")

    # Handle Interrupt
    if [[ $? -eq 130 ]]; then
        log fatal "Press any key to exit" signal interrupt
        read -n 1 -s -r -p ""
        exit 1
    fi

    if [ -z "$SELECTED_SETUPS" ]; then
        log fatal "Please choose minimun 1 setup"
        exit 1
    fi

    NUM_SELECTED_SETUPS=$(echo "$SELECTED_SETUPS" | wc -l)

    if [ "$NUM_SELECTED_SETUPS" -gt 1 ]; then
        echo "# Confirm selected setups" >run/selected_setups.md
    else
        echo "# Confirm selected setup" >run/selected_setups.md
    fi

    IFS=$'\n' # Mengatur Internal Field Separator (IFS) agar pemisahnya menjadi baris baru

    for SETUP in $SELECTED_SETUPS; do
        # echo "- \`$SETUP\`" >>run/selected_setups.md
        echo "- $SETUP" >>run/selected_setups.md
    done

    gum format <run/selected_setups.md

    gum confirm
    GUM_CONFIRM_EXIT_CODE=$?

    if [ ! $GUM_CONFIRM_EXIT_CODE -eq 0 ]; then
        # Handle Interrupt
        if [ $GUM_CONFIRM_EXIT_CODE -eq 130 ]; then
            log fatal "Press any key to exit" signal interrupt
            read -n 1 -s -r -p ""
            exit 1
        fi

        log info "Not sure to run setup. Got cancel by user" confirm no
        exit 1
    fi
}
