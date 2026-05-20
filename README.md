# dotfiles

Personal dotfiles managed with Git and GNU Stow.

## Layout

Each top-level directory is a Stow package. For example:

```text
nvim/
  .config/
    nvim/
```

## Install

From this repo:

```sh
stow nvim
```

That links `nvim/.config/nvim` to `~/.config/nvim`.

If a real file or directory already exists at the target path, move it out of the way first or import it into this repo before running `stow`.
