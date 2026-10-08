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
files recursively inside inbox, projects, and areas; resources and archive are
excluded. See `org/index.org` in the notes repo for the workflow.

- `SPC n a`: agenda (`a` for the week, `t` for all tasks).
- The `a` view shows unfinished past deadlines/schedules first, the week on
  assigned dates only, then unfinished deadlines/schedules after the displayed
  week through 30 days from today.
- Scheduled intervals use `SCHEDULED: <start>--<end>` (no spaces around `--`),
  appear every day in the interval, and become overdue only after the end date.
  An explicit `DEADLINE`, if present, determines when a task is overdue.
- All agenda views share theme-based colors for category, planning dates/labels,
  time, breadcrumbs and progress markers; Org's status and tag faces are preserved.
- `SPC X`: capture (`t` task, `n` note, `l` project log).
- `SPC X l`: project log in the current Org file. Tag any log section `:LOG:`;
  its name is unrestricted, and a file can have several. Capture uses the
  containing log or the only log automatically; otherwise it asks which log.
  Entry date/time is automatic, then enter a title and write the body.
- `SPC n i`: inbox.
- `SPC n b`: select any entry from `org/references.bib` and create/open its
  Org-roam literature note in `org/03-resources/references/`. Notes are created
  on demand, not whenever the bibliography updates.
- `SPC n r f` / `SPC n r i`: find/link existing Org-roam nodes.
- New regular Org-roam notes go into `org/00-inbox/nodes/`; existing notes
  remain where they are.
- `M-x org-cite-insert`: insert a citation; `M-x citar-open-files`: open an
  attached PDF using the bibliography's `file` field.
- `C-c C-c`: finish capture; `C-c C-k`: cancel.
- `C-c C-t`: change task state; `C-c C-s` / `C-c C-d`: schedule / deadline.
- `C-c C-w`: refile; `C-c C-x C-a`: archive a subtree.
- `:w` / `:q`: save / close buffer; `C-x C-c`: quit Emacs.
