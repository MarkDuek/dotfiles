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
- Task body text and checklists are shown by default (up to five lines).
  `g D E` toggles this display; `g r` rebuilds the current agenda.
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
- `M-x org-roam-ui-open`: open the interactive graph at
  `http://127.0.0.1:35901/`. It starts on demand, requires no Graphviz, and
  listens only on localhost. `M-x org-roam-ui-mode` toggles the server off/on.
- `M-x org-cite-insert`: insert a citation; `M-x citar-open-files`: open an
  attached PDF using the bibliography's `file` field.
- `C-c C-c`: finish capture; `C-c C-k`: cancel.
- `C-c C-t`: change task state; `C-c C-s` / `C-c C-d`: schedule / deadline.
- `C-c C-w`: refile; `C-c C-x C-a`: archive a subtree.
- `:w` / `:q`: save / close buffer; `C-x C-c`: quit Emacs.

## Google Calendar

Main, School, and Work import into `org/02-areas/calendar/{main,school,work}.org`.
These files are included in the agenda. Imported appointments use active
timestamps, not scheduled tasks, so they appear on their calendar dates but
not in the overdue/upcoming task blocks. Recurring occurrences are nested.

Keep the Google Desktop OAuth client JSON at `~/.local/share/org-gcal/client.json`
with directory permissions `700` and file permissions `600`. OAuth tokens are
encrypted with GnuPG in `~/.local/share/org-gcal/oauth2.plist`; use a nonempty
passphrase when prompted. Emacs caches it for the session. Neither file belongs
in Git. The calendar directory is excluded locally in the notes repo's
`.git/info/exclude`; repeat that exclusion on other machines.

1. Restart Emacs after `doom sync`, then run `M-x org-gcal-fetch` and authorize
   your Gmail account (authorization may repeat for each calendar).
2. In a calendar file, add a disposable heading and run
   `M-x org-gcal-post-at-point`; select its calendar, start time, and duration.
   Confirm it appears in Google, edit its title in Org, and test `org-gcal-sync`.
3. Save the calendar buffers, then enable `M-x +org-gcal-auto-sync-mode`.
   It syncs every ten minutes and remembers your choice across restarts.
   Run the same command to disable it. Emacs must be running and awake.

`org-gcal-sync` imports changes and publishes edits to linked events;
`org-gcal-fetch` only imports and may overwrite unpublished event edits.
New Org events require one initial `org-gcal-post-at-point`. Save fetched
changes normally (`C-x s`) and refresh the agenda with `g r`. No automatic
archiving or deletion is enabled; Google cancellations become `CANCELED`.
Keep series-wide recurrence edits in Google initially. OAuth clients in
Google's Testing mode may require reauthorization after seven days.

Run the offline setup/timer check with
`emacs --batch -Q -l macos/doom/test-gcal.el`.

## Archives

Set a project-specific destination with a file header, relative to its directory:

```org
#+ARCHIVE: ../../04-archive/anomaly-detection/anomaly-detection-archive.org::
```

Create the destination folder first. `C-c C-x C-a` moves the selected heading
and its children; Org creates the archive file on first use and records source
context. Parent headings are recreated or reused by their full outline path
(e.g. `Tasks / Kernel PCA`); only their titles are copied, not bodies or IDs.
Existing archived items are not reorganized. Nothing is archived automatically.
Without a destination header, Org
uses a sibling `<filename>.org_archive` file rather than a unified archive.

Files ending in `-archive.org` are excluded from Org-roam; completed project
files keep their nodes even under `04-archive/`. To retire an entire project,
move its file there without changing its ID and update its header to the local
`#+ARCHIVE: anomaly-detection-archive.org::`. Do not overwrite its task-history
file. Reload the config to refresh agenda files, then run `SPC n r s` to refresh
Roam. The agenda does not scan `04-archive/`.

Check native archive routing with `emacs --batch -Q -l macos/doom/test-archive.el`.
