```
      _                          __  _       _    __ _ _           
  ___| |__   _____      _____   / /_| | ___ | |_ / _(_) | ___  ___ 
 / __| '_ \ / _ \ \ /\ / / __| / / _` |/ _ \| __| |_| | |/ _ \/ __|
| (__| |_) | (_) \ V  V /\__ \/ / (_| | (_) | |_|  _| | |  __/\__ \
 \___|_.__/ \___/ \_/\_/ |___/_/ \__,_|\___/ \__|_| |_|_|\___||___/
```

## Distro

I use [Parabola GNU/Linux-libre](https://www.parabola.nu/).

## Installation

The easiest way to install the configuration for a specific package is as follows:

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

4. Use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to create symlinks for each package. For example:

```
stow nvim
```
