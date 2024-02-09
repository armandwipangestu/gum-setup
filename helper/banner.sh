#!/bin/env bash

function banner() {
    gum style \
        --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        'Linux Setup v1.0.0' 'by: github.com/armandwipangestu' "LOG FILE: log/${LOG_FILE}"
}
