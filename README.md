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

## mise

The `pipx:` tools pin their dependencies with hash-locked requirements files in
`mise/.config/mise/pipx/`. mise expands templates in tool options before writing
`mise.lock`, so referencing them via `{{ xdg_config_home }}` would bake the
current machine's home directory into the lockfile. Instead `uvx_args` points at
the machine-independent path `/usr/local/share/dotfiles/mise/pipx`, which each
machine links once:

```sh
just stow mise
just mise link-pipx
```

## GNOME

### Keybindings

Window navigation (PaperWM, vim-style):

| Key                                   | Action                                 |
| ------------------------------------- | -------------------------------------- |
| `super` + `h` / `l`                   | Focus window left / right              |
| `super` + `j` / `k`                   | Focus window down / up                 |
| `super` + `shift` + `h` / `l`         | Move window left / right               |
| `super` + `shift` + `j` / `k`         | Move window down / up                  |
| `super` + `ctrl` + `j` / `k`          | Switch workspace down / up             |
| `super` + `alt` + `shift` + `h` / `l` | Move workspace to monitor left / right |
| `super` + `n`                         | New window                             |
| `super` + `return`                    | Toggle maximize                        |

Workspace switching (GNOME defaults preserved):

| Key                                          | Action                   |
| -------------------------------------------- | ------------------------ |
| `super` + `alt` + `left` / `right`           | Switch workspace         |
| `super` + `shift` + `alt` + `left` / `right` | Move window to workspace |

### Apply settings on a new machine

After stowing the `gnome` package, load the dconf settings:

```sh
just stow gnome
just gnome load
```

This applies PaperWM settings from `paperwm.conf` to `/org/gnome/shell/extensions/paperwm/`
and GNOME keybinding overrides from `keybinds.conf` to `/org/gnome/desktop/wm/keybindings/`.

To capture current settings back into the repo:

```sh
just gnome dump
```
