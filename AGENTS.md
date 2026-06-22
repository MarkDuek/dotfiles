## Layout

Each top-level directory is a Stow package. For example:

```text
nvim/
  .config/
    nvim/
zsh/
  .zshrc
```

## Packages

| Package | Docs | Target |
| --- | --- | --- |
| `nvim` | [nvim/README.md](nvim/README.md) | `~/.config/nvim` |
| `zsh` | [zsh/README.md](zsh/README.md) | `~/.zshrc` |

## Install

From this repo:

```sh
stow nvim
stow zsh
```

That links `nvim/.config/nvim` to `~/.config/nvim`.
It also links `zsh/.zshrc` to `~/.zshrc`.

If a real file or directory already exists at the target path, move it out of the way first or import it into this repo before running `stow`.
