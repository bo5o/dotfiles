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
    zsh-asdf-direnv # Fork at https://github.com/cbows/zsh-asdf-direnv
)

# global tool versions
export PATH="$(asdf where direnv)/bin:$PATH"
export PATH="$(asdf where neovim)/bin:$PATH"
export PATH="$(asdf where ripgrep)/bin:$PATH"
export PATH="$(asdf where bat)/bin:$PATH"
export PATH="$(asdf where dotenv-linter)/bin:$PATH"
export PATH="$(asdf where hadolint)/bin:$PATH"
export PATH="$(asdf where shellcheck)/bin:$PATH"
export PATH="$(asdf where shfmt)/bin:$PATH"
export PATH="$(asdf where fd)/bin:$PATH"
export PATH="$(asdf where lazygit)/bin:$PATH"
export PATH="$(asdf where yq)/bin:$PATH"
export PATH="$(asdf where nodejs)/bin:$PATH"
export PATH="$(asdf where lazydocker)/bin:$PATH"
export PATH="$(asdf where azure-cli)/bin:$PATH"
tldr() { asdf exec tldr "$@"; }
tmuxinator() { asdf exec tmuxinator "$@"; }
neovide() { asdf exec neovide "$@"; }

# completions
# https://github.com/zsh-users/zsh-completions/issues/603
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)
fpath=(${ASDF_DIR}/completions $fpath)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.oh-my-zsh/custom/p10k.zsh.
[[ ! -f ~/.oh-my-zsh/custom/p10k.zsh ]] || source ~/.oh-my-zsh/custom/p10k.zsh
