mod? mise '~/.just/mise'
mod? yazi '~/.just/yazi'
mod? zsh '~/.just/zsh'
mod? docker '~/.just/docker'

packages := "zsh mise yazi tmux nvim lazygit git bat wezterm psql llm"

[private]
default:
    @just --list --unsorted

upgrade:
    -just mise upgrade
    -just yazi upgrade
    -just zsh upgrade

install:
    -just mise install
    -just yazi install
    -just docker install

stow *args=packages:
    stow -v {{ args }}

unstow *args=packages:
    just stow -D {{ args }}
