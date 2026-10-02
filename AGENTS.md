## Layout

Stow packages live in `linux/`, `macos/`, and `ai/`:

```text
linux/nvim/.config/nvim/
macos/nvim/.config/nvim/
ai/skills/.agents/skills/
```

Keep platform-specific configurations separate. Skills in `ai/skills/` are
shared by Codex and OpenCode on both platforms. Package READMEs describe
dependencies and usage; keep them concise.

## Install

From this repo:

```sh
stow --dir=linux --target="$HOME" nvim
stow --dir=macos --target="$HOME" nvim
stow --dir=ai --target="$HOME" skills
```

Choose one platform for each tool. Inspect existing targets before linking;
preserve real files and unrelated symlinks. Use Stow simulation before applying.

Keep commits focused on one change and preserve unrelated user work.
