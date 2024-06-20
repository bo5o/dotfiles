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

# asdf + direnv settings
export ASDF_DIR="$HOME/.asdf"
export DIRENV_LOG_FORMAT=""

# Plugins (can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    git
    vi-mode
    docker
    docker-compose
    jira
    rsync
    yarn
    pip
    poetry
    ssh-agent
    pass
    genpass
    brew
    colored-man-pages
    zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting.git
    extract
    gitignore
    timewarrior # https://github.com/svenXY/timewarrior
    tmuxinator
    z
    ripgrep
    fd
    fzf
    rust
    tldr # https://github.com/tldr-pages/tldr-node-client#zsh
    taskwarrior
    zsh-asdf-direnv
    just # https://github.com/casey/just/issues/618#issuecomment-601824467
    restic # https://restic.readthedocs.io/en/stable/020_installation.html#autocompletion
    hcloud # https://github.com/hetznercloud/cli?tab=readme-ov-file#zsh
)

# completions
# https://github.com/zsh-users/zsh-completions/issues/603
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)
fpath=(${ASDF_DIR}/completions $fpath)

# ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding no
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent lifetime 6h

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.oh-my-zsh/custom/p10k.zsh.
[[ ! -f ~/.oh-my-zsh/custom/p10k.zsh ]] || source ~/.oh-my-zsh/custom/p10k.zsh
