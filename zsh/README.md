# Zsh config

Personal Zsh setup managed with Zinit, Powerlevel10k, fzf, and a few shell helpers.

## Files

| File | Purpose |
| --- | --- |
| `.zshrc` | Main interactive shell config |

Not tracked:

| File | Reason |
| --- | --- |
| `.zsh_history` | Shell history can contain private commands and machine-specific paths |
| `.local/share/zinit/` | Downloaded plugin manager and plugins; recreated automatically |
| `.cache/p10k-*` | Generated Powerlevel10k instant prompt cache |

## Features

| Area | Details |
| --- | --- |
| Plugin manager | Bootstraps `zdharma-continuum/zinit` into `$XDG_DATA_HOME` or `~/.local/share` |
| Prompt | Loads `romkatv/powerlevel10k`; sources `~/.p10k.zsh` when present |
| Plugins | `zsh-syntax-highlighting`, `zsh-completions`, `zsh-autosuggestions` |
| Completion | Case-insensitive matching and LS_COLORS-aware completion colors |
| History | Shared history, duplicate cleanup, and ignored space-prefixed commands |
| fzf | Enables Zsh integration when `fzf` is installed |
| Editor | Sets `EDITOR=nvim` |
| Yazi | Adds the `y` helper to exit Yazi into the selected directory |

## Keybinds

| Key | Action |
| --- | --- |
| `Ctrl-Space` | Accept autosuggestion |
| `Ctrl-f` | Clear autosuggestion |
| `Up` | Search backward through matching history |
| `Down` | Search forward through matching history |

## fzf

The config enables fzf only when the `fzf` command exists.

Useful default bindings from `fzf --zsh`:

| Key | Action |
| --- | --- |
| `Ctrl-r` | Fuzzy search shell history |
| `Ctrl-t` | Fuzzy search files and paste the selected path |
| `Alt-c` | Fuzzy change directory |

`Ctrl-t` is configured to:

| Option | Behavior |
| --- | --- |
| `--walker-skip .git,node_modules,target` | Skip noisy directories |
| `--height 80%` | Use most of the terminal height |
| `--preview 'bat -n --color=always {}'` | Preview selected files with `bat` |
| `ctrl-/` | Toggle the preview window layout/visibility |

## Install

From the repo root:

```sh
stow zsh
```

That links `zsh/.zshrc` to `~/.zshrc`.
