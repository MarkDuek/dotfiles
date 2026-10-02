# macOS Neovim config

Lua configuration with relative line numbers, four-space indentation, clipboard
keybindings, and diagnostic toggles. Leader is `Space`; local leader is `\`.

Plugins are managed with lazy.nvim; the theme is Catppuccin Mocha.

Telescope provides file search (`Ctrl-P`) and live grep (`Ctrl-F`), using fd and
ripgrep.

Harpoon marks files (`Space a`), opens its menu (`Ctrl-E`), and cycles marks
(`Space hp` / `Space hn`). `Ctrl-H/J/K/L` jump to marks 1–4.

Yazi opens at the current file (`Space e`) or working directory (`Space E`).
Resume the last session with `Space fr`.

Link to `~/.config/nvim` from the repository root:

```sh
stow --dir=macos --target="$HOME" nvim
```
