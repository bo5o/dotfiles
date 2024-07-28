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
    tmuxinator
    z
    fd # curl https://raw.githubusercontent.com/sharkdp/fd/master/contrib/completion/_fd --output ~/.oh-my-zsh/custom/plugins/fd/_fd
    rg # rg --generate complete-zsh > ~/.oh-my-zsh/custom/plugins/rg/_rg
    fzf
    rust
    tldr # curl https://raw.githubusercontent.com/tldr-pages/tlrc/main/completions/_tldr --output ~/.oh-my-zsh/custom/plugins/tldr/_tldr
    taskwarrior
    zsh-asdf-direnv
    just # just --completions zsh > ~/.oh-my-zsh/custom/plugins/just/_just
    restic # restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic
    hcloud # hcloud completion zsh > ~/.oh-my-zsh/custom/plugins/hcloud/_hcloud
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
