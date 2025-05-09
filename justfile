mod? mise '~/.just/mise'
mod? yazi '~/.just/yazi'
mod? zsh '~/.just/zsh'

stowables := "zsh mise yazi"

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

stow *args=stowables:
    stow -v {{ args }}

unstow *args=stowables:
    just stow -D {{ args }}
