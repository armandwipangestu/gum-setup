#!/bin/env bash

DEPENDENCY_PACKAGES=(
    git fzf zsh bat exa neofetch unzip
)

REPOSITORY_LINK=(
    "https://github.com/robbyrussell/oh-my-zsh"
    "https://github.com/zsh-users/zsh-syntax-highlighting"
    "https://github.com/zsh-users/zsh-autosuggestions"
    "https://github.com/joshskidmore/zsh-fzf-history-search"
)

OMZ_PATH="${HOME}/.oh-my-zsh"

REPOSITORY_PATH=(
    "${OMZ_PATH}"
    "${OMZ_PATH}/custom/plugins/zsh-syntax-highlighting"
    "${OMZ_PATH}/custom/plugins/zsh-autosuggestions"
    "${OMZ_PATH}/custom/plugins/zsh-fzf-history-search"
)

DOTFILES=(
    .zshrc .aliases .autostart
)

function installDependecyPackage() {
    gum format <markdown/zsh-oh-my-posh/dependency-packages.md
    echo -e ""
    # shellcheck disable=SC2068
    for DEPENDENCY_PACKAGE in ${DEPENDENCY_PACKAGES[@]}; do
        if gum spin --spinner minidot --title "Installing ${DEPENDENCY_PACKAGE}" -- sudo apt install -y "$DEPENDENCY_PACKAGE"; then
            # if spin "Installing ${DEPENDENCY_PACKAGE}" "sudo apt install -y ${DEPENDENCY_PACKAGE}"; then
            log info "Installing success" package "${DEPENDENCY_PACKAGE}"
        else
            log error "Installing failed" package "${DEPENDENCY_PACKAGE}"
        fi
    done
}

function cloneRepositoryZsh() {
    gum format <markdown/zsh-oh-my-posh/repository.md
    echo -e ""
    for ((i = 0; i < ${#REPOSITORY_LINK[@]}; i++)); do
        if gum spin --spinner minidot --title "Cloning ${REPOSITORY_LINK[i]} to ${REPOSITORY_PATH[i]}" -- git clone "${REPOSITORY_LINK[i]}" "${REPOSITORY_PATH[i]}"; then
            log info "Cloning success" repository "${REPOSITORY_LINK[i]}"
        else
            log error "Cloning failed" repository "${REPOSITORY_LINK[i]}"
        fi
    done
}

function installOhMyPosh() {
    gum format <markdown/zsh-oh-my-posh/ohmyposh.md
    echo -e ""
    if [ ! -d "$HOME"/.local/bin ]; then
        mkdir -p "$HOME"/.local/bin
    fi

    sudo ln -s /usr/bin/batcat ~/.local/bin/bat

    # if gum spin --spinner minidot --title "Downloading oh-my-posh" -- curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin; then
    #     log info "Downloading success" package "oh-my-posh"
    # else
    #     log error "Downloading failed" package "oh-my-posh"
    # fi

    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

    if [ ! -d "$HOME"/.oh-my-posh ]; then
        mkdir -p "$HOME"/.oh-my-posh/themes
    fi

    cp devnull.omp.json "$HOME/.oh-my-posh/themes/devnull.omp.json"
}

function installDotfiles() {
    gum format <markdown/zsh-oh-my-posh/dotfiles.md
    echo -e ""
    for DOTFILE in "${DOTFILES[@]}"; do
        if gum spin --spinner minidot --title "Installing ${DOTFILE}" -- cp "${DOTFILE}" "$HOME/${DOTFILE}"; then
            log info "Installing success" dotfile "${DOTFILE}"
        else
            log error "Installing failed" dotfile "${DOTFILE}"
        fi
    done

    if [ ! -d ~/.config ]; then
        mkdir ~/.config
    fi

    cp -R config/neofetch ~/.config/
}

function changeShellToZsh() {
    log info "Change Shell to ZSH!" current-shell "${SHELL}"
    log warn "Please fill the password to change shell"
    chsh -s "$(which zsh)"
    exec zsh
}

function zshOhMyPosh() {
    installDependecyPackage
    cloneRepositoryZsh
    installOhMyPosh
    installDotfiles
    changeShellToZsh
}
