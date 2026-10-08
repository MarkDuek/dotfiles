;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "MarkDuek"
      user-mail-address "duekmark@gmail.com"
      org-directory (expand-file-name "~/03-Resources/notes/mark-notes/org/")
      default-directory org-directory)

(setq org-roam-directory org-directory)

(setq completion-ignore-case t)

(after! orderless
  (setf (alist-get 'org-roam-node completion-category-overrides)
        '((styles flex))))

(defun +org-capture-project-log-target ()
  (set-buffer (org-capture-get :original-buffer))
  (unless (and (derived-mode-p 'org-mode) buffer-file-name)
    (user-error "Open the project's Org file before capturing a log entry"))
  (org-capture-put-target-region-and-position)
  (widen)
  (goto-char
   (or (save-excursion
         (unless (org-before-first-heading-p)
           (org-back-to-heading t)
           (while (and (not (member "LOG" (org-get-tags nil t)))
                       (org-up-heading-safe)))
           (when (member "LOG" (org-get-tags nil t)) (point))))
       (let ((logs (delq nil
                         (org-map-entries
                          (lambda ()
                            ;; Ignore inherited tags on individual log entries.
                            (when (member "LOG" (org-get-tags nil t))
                              (cons (format "%s (line %d)"
                                            (org-get-heading t t t t)
                                            (line-number-at-pos))
                                    (point))))))))
         (cond ((null logs)
                (user-error "Add a :LOG: tag to a log section in this file first"))
               ((= (length logs) 1) (cdar logs))
               (t (cdr (assoc (completing-read "Log section: " logs nil t) logs))))))))

(defun +org-agenda-scheduled-timestamp ()
  (save-excursion
    (org-back-to-heading t)
    (org-element-property :scheduled (org-element-at-point))))

(defun +org-agenda-planning-dates ()
  (let ((deadline (org-entry-get nil "DEADLINE"))
        (scheduled (org-element-property :raw-value (+org-agenda-scheduled-timestamp))))
    (concat (if deadline (concat "Deadline: " deadline) "")
            (if (and deadline scheduled) "  " "")
            (if scheduled (concat "Scheduled: " scheduled) ""))))

(defun +org-agenda-style-view ()
  (when org-agenda-with-colors
    (let ((inhibit-read-only t))
      (with-silent-modifications
        (save-excursion
          (save-match-data
            (goto-char (point-min))
            (while (not (eobp))
              (let* ((start (point))
                     (end (line-end-position))
                     (heading (text-property-any start end 'org-heading t))
                     (marker (get-text-property start 'org-hd-marker)))
                (when (and heading (markerp marker) (marker-buffer marker))
                  (let* ((done (member (get-text-property start 'todo-state)
                                       org-done-keywords-for-agenda))
                         (overdue (org-with-point-at marker
                                    (and (derived-mode-p 'org-mode)
                                         (not (org-before-first-heading-p))
                                         (null (+org-agenda-skip-not-overdue)))))
                         (planning-face
                          (cond (done 'org-agenda-done)
                                (overdue 'org-warning)
                                ((member (get-text-property start 'type)
                                         '("deadline" "upcoming-deadline"))
                                 'org-upcoming-deadline)
                                ((equal (get-text-property start 'type) "block") 'shadow)
                                (t 'org-scheduled))))
                    ;; Style only prefix fields, leaving Org's status/title/tag faces intact.
                    (dolist (field `((org-category . font-lock-function-name-face)
                                     (breadcrumbs . shadow)
                                     (time . org-date)
                                     (extra . ,planning-face)))
                      (let ((text (get-text-property start (car field))))
                        (when (and (stringp text) (not (string-empty-p text)))
                          (goto-char start)
                          (when (search-forward text heading t)
                            (put-text-property (- (point) (length text)) (point)
                                               'face (cdr field))))))
                    (goto-char start)
                    (while (re-search-forward "Deadline:\\|Scheduled:" heading t)
                      (put-text-property
                       (match-beginning 0) (match-end 0) 'face
                       (cond (done 'org-agenda-done)
                             (overdue 'org-warning)
                             ((equal (match-string 0) "Deadline:") 'org-upcoming-deadline)
                             (t 'org-scheduled))))
                    (goto-char start)
                    (while (re-search-forward org-ts-regexp heading t)
                      (put-text-property (match-beginning 0) (match-end 0) 'face
                                         (cond (done 'org-agenda-done)
                                               (overdue 'org-warning)
                                               (t 'org-date))))
                    (goto-char heading)
                    (while (re-search-forward "\\[[0-9]+\\(?:/[0-9]+\\|%\\)\\]" end t)
                      (put-text-property (match-beginning 0) (match-end 0) 'face 'shadow))))
                (goto-char end)
                (forward-line 1)))))))))

(defun +org-agenda-assigned-date-only (entry)
  ;; Org's `dotime' flag distinguishes actual occurrences from reminders.
  (let ((type (get-text-property 0 'type entry)))
    (unless (or (and (member type '("scheduled" "past-scheduled" "deadline" "upcoming-deadline"))
                     (null (get-text-property 0 'dotime entry)))
                ;; Org already displays ranges as daily blocks; avoid a duplicate start.
                (and (member type '("scheduled" "past-scheduled"))
                     (org-with-point-at (get-text-property 0 'org-hd-marker entry)
                       (eq (org-element-property :type (+org-agenda-scheduled-timestamp))
                           'active-range))))
      entry)))

(defun +org-agenda-skip-not-overdue ()
  (let* ((scheduled (+org-agenda-scheduled-timestamp))
         (deadline (org-entry-get nil "DEADLINE"))
         (end (if deadline (org-time-string-to-time deadline)
                (and scheduled (org-timestamp-to-time scheduled t)))))
    (unless (and end (not (org-entry-is-done-p))
                 (< (time-to-days end) (org-today)))
      (save-excursion (outline-next-heading) (point)))))

(defun +org-agenda-upcoming-match ()
  ;; Calendar dates keep the full last day included across DST changes.
  (let* ((today (org-today))
         (start (format-time-string "%Y-%m-%d"
                                    (org-time-from-absolute
                                     (max (1+ today) (+ org-starting-day 7)))))
         (end (format-time-string "%Y-%m-%d" (org-time-from-absolute (+ today 31)))))
    (format "DEADLINE>=\"<%s>\"&DEADLINE<\"<%s>\"|SCHEDULED>=\"<%s>\"&SCHEDULED<\"<%s>\""
            start end start end)))

(after! org
  ;; Scan these Org trees, not the Markdown tree, resources, or archive.
  (setq org-agenda-files
        (apply #'append
               (mapcar (lambda (directory)
                         (directory-files-recursively
                          (expand-file-name directory org-directory) "\\.org\\'"))
                       '("00-inbox/" "01-projects/" "02-areas/")))

        org-default-notes-file
        (expand-file-name "00-inbox/inbox.org" org-directory)

        org-todo-keywords
        '((sequence
           "BACKLOG(b)"
           "TODO(t)"
           "ON_HOLD(h)"
           "|"
           "DONE(d)"
           "CANCELED(c)"))

        org-tag-alist
        '(("MILESTONE" . ?m)
          ("LOG" . ?l))

        org-todo-keyword-faces
        '(("ON_HOLD" . warning))

        org-log-done 'time
        org-log-into-drawer t

        org-agenda-span 'week
         org-agenda-start-on-weekday 1
         org-agenda-start-day nil

         org-agenda-prefix-format
         '((agenda . "  %-12:c%?-12t% s%b")
           (todo . "  %-12:c%(+org-agenda-planning-dates) %b")
           (tags . "  %-12:c%(+org-agenda-planning-dates) %b")
           (search . "  %-12:c%(+org-agenda-planning-dates) %b"))

         org-agenda-custom-commands
         '(("m" "Milestones"
            tags "MILESTONE")
           ("a" "Past planning dates + week + upcoming planning dates"
            ((tags "DEADLINE<\"<today>\"|SCHEDULED<\"<today>\""
                   ((org-agenda-overriding-header "Overdue Tasks")
                    (org-agenda-skip-function #'+org-agenda-skip-not-overdue)))
             (agenda "" ((org-agenda-span 'week)
                         (org-deadline-warning-days 0)
                         (org-agenda-before-sorting-filter-function
                          #'+org-agenda-assigned-date-only)))
             (tags (+org-agenda-upcoming-match)
                   ((org-agenda-overriding-header "Upcoming deadlines/schedules (next 30 days)")
                    (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done)))))))

        org-refile-targets
        '((org-agenda-files :maxlevel . 3))

        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil

        org-archive-location
        (concat
         (expand-file-name "04-archive/archive.org" org-directory)
         "::* Archived")

        org-capture-templates
        `(("t" "Task" entry
           (file+headline ,org-default-notes-file "Tasks")
           "* TODO %?\n%U\n"
           :empty-lines 1)

          ("n" "Note" entry
           (file+headline ,org-default-notes-file "Notes")
           "* %?\n%U\n"
           :empty-lines 1)

          ("l" "Project log" entry
           (function +org-capture-project-log-target)
           "* %U %^{Entry title}\n%?\n"
           :empty-lines 1))))

(after! org
  (add-hook 'org-agenda-finalize-hook #'+org-agenda-style-view 'append))

(map! :leader
      :desc "Org inbox"
      "n i"
      (cmd! (find-file
             (expand-file-name "00-inbox/inbox.org" org-directory))))

(setq catppuccin-flavor 'latte)
(setq doom-theme 'catppuccin)

(add-to-list 'default-frame-alist '(alpha-background . 92))
(when (display-graphic-p)
  (set-frame-parameter nil 'alpha-background 92))
