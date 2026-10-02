# macOS AeroSpace config

Automatic window tiling, workspaces 1–9, and 8-pixel gaps. Workspaces group app
windows; they are separate from macOS Spaces and tmux sessions. Launch-at-login
is disabled. Other settings use AeroSpace defaults.

Use AeroSpace workspaces on a single macOS desktop per monitor. Native macOS
fullscreen creates a separate Space; AeroSpace fullscreen stays in the workspace.

Link from the repository root:

```sh
stow --dir=macos --target="$HOME" aerospace
```

Open AeroSpace and grant access in **System Settings → Privacy & Security →
Accessibility**. Reload with `aerospace reload-config` or `Option-Shift-R`.
The linked config is `~/.config/aerospace/aerospace.toml`.

`alt` in the config means macOS **Option**. Shortcuts are global while AeroSpace
is enabled, including in Ghostty. Option-C remains unbound for fzf.

| Shortcut | Action |
| --- | --- |
| Option-H/J/K/L | Focus left/down/up/right |
| Option-Shift-H/J/K/L | Move the window left/down/up/right |
| Option-1–9 | Switch workspace |
| Option-Shift-1–9 | Send window to workspace, without following |
| Option-Tab | Return to previous workspace |
| Option-Shift-Tab | Move workspace to next monitor |
| Option-/ | Tiled layout; toggle horizontal/vertical |
| Option-, | Accordion layout; toggle horizontal/vertical |
| Option-minus / Option-equal | Shrink / grow window |
| Option-Shift-Space | Toggle floating / tiling |
| Option-Shift-F | Toggle AeroSpace fullscreen (not macOS fullscreen) |
| Option-Shift-R | Reload config |

Tiles share the available space; accordion windows overlap, with the focused
window in front. Floating windows can be positioned manually.

Pause tiling with `aerospace enable off`; resume with `aerospace enable on`.
