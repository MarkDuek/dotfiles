# macOS tmux config

tmux with mouse support, Catppuccin Mocha, TPM, and graphics passthrough.
Requires TPM at `~/.tmux/plugins/tpm`.

Panes and the status-bar background inherit terminal transparency; window tabs
retain their Catppuccin colors.

Link to `~/.tmux.conf` from the repository root:

```sh
stow --dir=macos --target="$HOME" tmux
```

Reload with `tmux source-file ~/.tmux.conf`. Install plugins with `Ctrl-B`, then `I`.
