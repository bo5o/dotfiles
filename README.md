```
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

## Distro

I use Parabola GNU/Linux-libre.

## Programs

* compton - compositor
* feh - image viewer
* htop - system monitor
* i3-gaps - tiling window manager
* iceweasel - web browser
* keybase - private git repositories
* mpc - cli music client
* mpd - music server
* mps-youtube - youtube player
* mpv - media player
* ncmpcpp - mpc front-end
* neomutt - mail client
* neovim - text editor
* networkmanager - network connection manager
* newsbeuter - rss reader
* papis - bibliography management
* polybar - bar
* ranger - file browser
* rofi - dmenu replacement
* stow - dotfile management
* tmux - terminal multiplexer
* urxvt - terminal emulator
* w3m - cli web browser
* zathura - pdf viewer
* zsh - shell
* many little scripts...

## Installation

1. Make sure you are in your home directory and clone this repo.

```
cd ~
git clone https://github.com/cbows/dotfiles
```

2. Enter `dotfiles` directory and use [GNU Stow](https://www.gnu.org/software/stow/) to create the necessary symlinks for each program. For example:

```
stow nvim
```
