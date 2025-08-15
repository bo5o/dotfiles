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

# setup mise
export MISE_DATA_DIR="$HOME/.local/share/mise"
export PATH="$MISE_DATA_DIR/shims:$PATH"

# Plugins
plugins=(
    # from ~/.oh-my-zsh/plugins
    git
    vi-mode
    docker
    docker-compose
    jira
    jj
    rsync
    yarn
    pip
    uv
    direnv
    ssh-agent
    pass
    genpass
    brew
    colored-man-pages
    extract
    gitignore
    tmuxinator
    fzf
    rust
    # from ~/.oh-my-zsh/custom/plugins
    bat
    hyperfine
    dive
    gh
    just
    tldr
    restic
    hcloud
    ruff
    bws
    rg
    fd
    dust
    xh
    mise
    zsh-syntax-highlighting
)

# completions
fpath=(${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src $fpath)
fpath=(${HOME}/.zfunc $fpath)

# ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding no
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent lifetime 6h

source $ZSH/oh-my-zsh.sh

# use `zoxide import --from=z "$HOME/.z"` to migrate from z
eval "$(zoxide init --cmd j zsh)"

# To customize prompt, run `p10k configure` or edit ~/.oh-my-zsh/custom/p10k.zsh.
[[ ! -f ~/.oh-my-zsh/custom/p10k.zsh ]] || source ~/.oh-my-zsh/custom/p10k.zsh
[[ ! -f ~/.oh-my-zsh/custom/p10k.mise.zsh ]] || source ~/.oh-my-zsh/custom/p10k.mise.zsh
