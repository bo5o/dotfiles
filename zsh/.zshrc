# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="zeta"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Path to custom folder.
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins (can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    git
    docker
    docker-compose
    jira
    rsync
    pip
    virtualenvwrapper
    colored-man-pages
    vi-mode
    zsh-syntax-highlighting
    extract
    fzf
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

eval "$(pyenv init -)"

autoload -Uz compinit && compinit -i
