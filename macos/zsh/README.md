# macOS Zsh config

Zsh configuration for macOS with shared history, case-insensitive completion,
arrow-key history search, colored `ls` aliases, and Neovim as the editor.

Zinit manages Powerlevel10k, syntax highlighting, extra completions, and
autosuggestions. Customize the prompt with `p10k configure`.

## Linking

Link to `~/.zshrc` from the repository root:

```sh
stow --dir=macos --target="$HOME" zsh
```
