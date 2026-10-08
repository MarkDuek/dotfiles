;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "MarkDuek"
      user-mail-address "duekmark@gmail.com"
      org-directory (expand-file-name "~/03-Resources/notes/mark-notes/org/"))

(after! org
  ;; Org scans these directories, not the Markdown tree, resources, or archive.
  (setq org-agenda-files
        (mapcar (lambda (directory) (expand-file-name directory org-directory))
                '("00-inbox/" "01-projects/" "02-areas/"))
        org-default-notes-file (expand-file-name "00-inbox/inbox.org" org-directory)
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces '(("NEXT" . org-todo) ("WAIT" . warning))
        org-log-done 'time
        org-log-into-drawer t
        org-agenda-span 'week
        org-agenda-start-on-weekday 1
        org-agenda-start-day nil
        org-refile-targets '((org-agenda-files :maxlevel . 3))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-archive-location
        (concat (expand-file-name "04-archive/archive.org" org-directory)
                "::* Archived")
        org-capture-templates
        `(("t" "Task" entry
           (file+headline ,org-default-notes-file "Tasks")
           "* TODO %?\n%U\n" :empty-lines 1)
          ("n" "Note" entry
           (file+headline ,org-default-notes-file "Notes")
           "* %?\n%U\n" :empty-lines 1)
          ("p" "Project" entry
           (file+headline ,(expand-file-name "01-projects/projects.org" org-directory)
                          "Projects")
           "* %^{Project name}\n** TODO %?\n" :empty-lines 1))))

(map! :leader
      :desc "Org inbox" "n i"
      (cmd! (find-file (expand-file-name "00-inbox/inbox.org" org-directory))))

(setq catppuccin-flavor 'latte)
(setq doom-theme 'catppuccin)

(add-to-list 'default-frame-alist '(alpha-background . 92))
(when (display-graphic-p)
  (set-frame-parameter nil 'alpha-background 92))
