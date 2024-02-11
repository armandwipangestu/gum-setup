#!/bin/env bash

DIRECTORYS=(
    ".oh-my-zsh" ".oh-my-posh"
    ".local/bin" "themes"
    ".config/neofetch"
)

FILES=(
    .aliases .zshrc .autostart omp.cache
)

for DIRECTORY in "${DIRECTORYS[@]}"; do
    rm -rf ~/"${DIRECTORY}"
done

for FILE in "${FILES[@]}"; do
    rm ~/"${FILE}"
done
