# Doom Emacs

Minimal Doom with Evil, Org Agenda, and Org Capture. Requires Emacs 29.1–31.1,
Git, ripgrep, and a Doom installation at `~/.config/emacs`.

```sh
git clone --depth 1 https://github.com/doomemacs/core ~/.config/emacs
stow --dir=macos --target="$HOME" doom
doom install --no-config --no-env
emacs -nw
```

Inspect any existing Emacs config first: `~/.emacs.d` takes precedence over
`~/.config/emacs`. Run `doom sync` after changing modules or packages.

Org files live in `~/03-Resources/notes/mark-notes/org/`. Agenda scans `.org`
files directly inside inbox, projects, and areas; resources and archive are
excluded. See `org/index.org` in the notes repo for the workflow.

- `SPC n a`: agenda (`a` for the week, `t` for all tasks).
- `SPC X`: capture (`t` task, `n` note, `p` project).
- `SPC n i`: inbox.
- `C-c C-c`: finish capture; `C-c C-k`: cancel.
- `C-c C-t`: change task state; `C-c C-s` / `C-c C-d`: schedule / deadline.
- `C-c C-w`: refile; `C-c C-x C-a`: archive a subtree.
- `:w` / `:q`: save / close buffer; `C-x C-c`: quit Emacs.
