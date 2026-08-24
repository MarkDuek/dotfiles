# tmux config

tmux config with mouse support, Catppuccin, and terminal graphics passthrough for Yazi previews.

## Files

| File | Purpose |
| --- | --- |
| `.tmux.conf` | Main tmux config |

## Preview support

Yazi image previews in Kitty-compatible terminals need tmux passthrough enabled and terminal environment variables preserved. After changing this config, restart tmux:

```sh
tmux kill-server
tmux
```

## Install

From the repo root:

```sh
stow --target="$HOME" tmux
```
