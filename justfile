mod mise
mod yazi
mod zsh

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

stow *args:
    stow -v {{ args }}

stow-all *args:
    just stow {{ args }} zsh mise yazi

unstow *args:
    just stow -D {{ args }}
