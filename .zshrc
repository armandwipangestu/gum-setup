# If you come from bash you might have to change your $PATH.
PATH="/usr/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git bgnotify
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-fzf-history-search
)

export EDITOR=/usr/bin/vim

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.autostart
