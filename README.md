# dotfiles

Personal dotfiles managed with Git and GNU Stow.

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
| `tmux` | [tmux/README.md](tmux/README.md) | `~/.tmux.conf` |
| `yazi` | [yazi/README.md](yazi/README.md) | `~/.config/yazi/yazi.toml` |
| `zsh` | [zsh/README.md](zsh/README.md) | `~/.zshrc` |
| `codex` | - | `~/.codex/skills/process-library-inbox` |

## Install

From this repository directory, use an explicit target. The Git repository is
nested under `Projects/Dotfiles`, so Stow's default target would not be your
home directory.

```sh
stow --target="$HOME" nvim
stow --target="$HOME" tmux
stow --target="$HOME" yazi
stow --target="$HOME" zsh
stow --target="$HOME" codex
```

That links `nvim/.config/nvim` to `~/.config/nvim`.
It links `tmux/.tmux.conf` to `~/.tmux.conf`.
It links `yazi/.config/yazi/yazi.toml` to `~/.config/yazi/yazi.toml`.
It also links `zsh/.zshrc` to `~/.zshrc`.

If a real file or directory already exists at the target path, import it into
this repo before running `stow`. After it matches the package, use
`stow --target="$HOME" --restow <package>` to replace it with Stow links.
