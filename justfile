mod? mise '~/.just/mise'
mod? yazi '~/.just/yazi'
mod? zsh '~/.just/zsh'

packages := "zsh mise yazi tmux nvim lazygit direnv git bat ripgrep wezterm psql"

[private]
default:
    @just --list --unsorted

upgrade:
    -just mise upgrade
    just yazi upgrade
    just zsh upgrade

install:
    just mise install
    just yazi install

stow *args=packages:
    stow -v {{ args }}

unstow *args=packages:
    just stow -D {{ args }}
