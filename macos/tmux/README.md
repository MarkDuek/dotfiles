# macOS tmux config

tmux with mouse support, Catppuccin Mocha, TPM, and graphics passthrough.
Requires TPM at `~/.tmux/plugins/tpm`.

Link to `~/.tmux.conf` from the repository root:

```sh
stow --dir=macos --target="$HOME" tmux
```

Reload with `tmux source-file ~/.tmux.conf`. Install plugins with `Ctrl-B`, then `I`.
