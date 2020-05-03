# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins (can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    git
    vi-mode
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
    zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting.git
    extract
    gitignore
    timewarrior # https://github.com/svenXY/timewarrior
    tmuxinator
    z
    fd
    fzf
    tldr # https://github.com/tldr-pages/tldr-node-client#zsh
    zsh-completions # https://github.com/zsh-users/zsh-completions.git
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit -i
