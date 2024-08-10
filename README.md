# bo5o's dotfiles

Clone the repo into your home directory.

```sh
git clone --recurse-submodules https://github.com/boso/dotfiles ~/dotfiles
```

Enter the `dotfiles` directory.

```sh
cd ~/dotfiles
```

Use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to symlink the configuration for a specific tool into your home directory.

```sh
stow nvim
```
