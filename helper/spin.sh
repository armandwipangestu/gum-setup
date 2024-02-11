#!/bin/env bash

function spin() {
    gum spin --spinner minidot --title "$1" -- "$2"
}

function spinner() {
    local message="$1"
    local command="$2"

    if spin "$message" "$command"; then
        log info "${message} success " package "${DEPENDENCY_PACKAGE}"
    else
        log error "${message} failed " package "${DEPENDENCY_PACKAGE}"
    fi
}
