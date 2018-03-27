```
      _                          __  _       _    __ _ _           
  ___| |__   _____      _____   / /_| | ___ | |_ / _(_) | ___  ___ 
 / __| '_ \ / _ \ \ /\ / / __| / / _` |/ _ \| __| |_| | |/ _ \/ __|
| (__| |_) | (_) \ V  V /\__ \/ / (_| | (_) | |_|  _| | |  __/\__ \
 \___|_.__/ \___/ \_/\_/ |___/_/ \__,_|\___/ \__|_| |_|_|\___||___/
```

## Distro

I use Parabola GNU/Linux-libre.

## Programs

* compton - compositor
* feh - image viewer
* htop - system monitor
* i3wm - tiling window manager (with i3-gaps)
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

1. Make sure you are in your home directory.

```
cd ~
```

2. Clone this repo.

```
git clone https://github.com/cbows/dotfiles
```

3. Enter the `dotfiles` directory.

```
cd dotfiles
```

4. Use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to create the necessary symlinks for each program. For example:

```
stow nvim
```
