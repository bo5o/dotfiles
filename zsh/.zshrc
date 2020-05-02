# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="spaceship"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Path to custom folder.
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins (can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    git
    asdf
    direnv
    docker
    docker-compose
    django
    jira
    rsync
    yarn
    pip
    brew
    colored-man-pages
    vi-mode
    zsh-syntax-highlighting
    extract
    gitignore
    tmuxinator
    z
    fd
    fzf
    tldr
    zsh-completions
)

# disable default vi-mode prompt
export RPS1="%{$reset_color%}"

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit -i
