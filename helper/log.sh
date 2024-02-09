#!/bin/env bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="log_${TIMESTAMP}.txt"

function log() {
    local log_args=("--time" "rfc822" "--structured" "--level" "$1" "$2")

    if [ -n "$3" ]; then
        log_args+=("$3")
    fi

    if [ -n "$4" ]; then
        log_args+=("$4")
    fi

    gum log "${log_args[@]}"

    if [ -n "$3" ] && [ -n "$4" ]; then
        echo -e "$(date '+%d %b %y %H:%M %Z') $1 $2 $3=${4}" >>log/"${LOG_FILE}"
    else
        echo -e "$(date '+%d %b %y %H:%M %Z') $1 $2" >>log/"${LOG_FILE}"
    fi
}
