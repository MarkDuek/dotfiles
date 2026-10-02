# macOS Zsh config

Zsh configuration for macOS with shared history, case-insensitive completion,
arrow-key history search, colored `ls` aliases, and Neovim as the editor.

Zinit manages Powerlevel10k, syntax highlighting, extra completions, and
autosuggestions. Customize the prompt with `p10k configure`.

fzf provides history search (`Ctrl-R`), file selection (`Ctrl-T`), and directory
navigation (`Option-C`), using fd for searching and bat for file previews.

The `y` helper opens Yazi and changes to its final directory when quitting with `q`.

## Linking

Link to `~/.zshrc` from the repository root:

```sh
stow --dir=macos --target="$HOME" zsh
```
