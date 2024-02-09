#!/bin/env bash

function interrupt() {
    echo -e "\n"
    gum log --time rfc822 --structured --level fatal "Press any key to exit " signal interrupt
    read -n 1 -s -r -p ""
    exit 1
}
