# dotfiles

Personal dotfiles managed with Git and GNU Stow.

## Layout

Packages are grouped by platform; AI skills are shared:

```text
linux/      # nvim, tmux, yazi, zsh
macos/      # aerospace, borders, ghostty, nvim, tmux, yazi, zsh
ai/
  skills/
    .agents/skills/
```

## Install

Run from the repository root with an explicit home target. Select packages from
one platform; do not link Linux and macOS versions of the same tool together.

```sh
# Linux
stow --dir=linux --target="$HOME" nvim tmux yazi zsh

# macOS
stow --dir=macos --target="$HOME" nvim tmux yazi zsh aerospace borders ghostty

# Shared Codex and OpenCode skills
stow --dir=ai --target="$HOME" skills
```

Each package has its own README with dependencies and usage. Shared skills are
documented in [ai/skills/README.md](ai/skills/README.md).

Before linking, back up conflicting real files; never use `--adopt` blindly.
For older Linux installs, inspect and remove only symlinks pointing at the old
top-level packages, then run the Linux Stow command above.
