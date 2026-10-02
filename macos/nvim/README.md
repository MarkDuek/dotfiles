# macOS Neovim config

Lua configuration with relative line numbers, four-space indentation, clipboard
keybindings, and diagnostic toggles. Leader is `Space`; local leader is `\`.

Plugins are managed with lazy.nvim; the theme is Catppuccin Mocha.

Editor and floating-window backgrounds are transparent; opacity comes from the terminal.

Telescope provides file search (`Ctrl-P`) and live grep (`Ctrl-F`), using fd and
ripgrep.

Harpoon marks files (`Space a`), opens its menu (`Ctrl-E`), and cycles marks
(`Space hp` / `Space hn`). `Ctrl-H/J/K/L` jump to marks 1–4.

Yazi opens at the current file (`Space e`) or working directory (`Space E`).
Resume the last session with `Space fr`.

Blink provides completion: `Ctrl-N/P` select, `Ctrl-Y` accepts, and `Ctrl-E`
dismisses. `Ctrl-K` toggles signature help in insert mode.

Python uses basedpyright for types/navigation and Ruff for linting/formatting.
`gd` goes to definitions, `K` shows hover, `grn` renames, and `gra` shows code
actions. `gld` formats; `Space oi` organizes imports. Neither runs on save.
The interpreter is the project's `.venv`, an active virtual environment, or
uv's Python 3.13, in that order. Restart the LSP after creating a `.venv`.

Install Python tools (with `~/.local/bin` on `PATH`):

```sh
brew install uv
uv python install 3.13
uv tool install --python 3.13 basedpyright
uv tool install --python 3.13 ruff
```

In an existing uv project, run `uv sync` to create its `.venv`, and use `uv run`
to run Python commands.

Link to `~/.config/nvim` from the repository root:

```sh
stow --dir=macos --target="$HOME" nvim
```
