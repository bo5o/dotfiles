[private]
default:
    @just --list mise --unsorted

# upgrade mise tools
upgrade:
    mise up --bump --interactive

# install mise tools
install *args:
    mise i {{ args }}
