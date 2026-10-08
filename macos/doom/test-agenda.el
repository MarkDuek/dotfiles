;;; test-agenda.el -*- lexical-binding: t; -*-
;; Run: emacs --batch -Q -l macos/doom/test-agenda.el

(require 'cl-lib)
(require 'org-agenda)

;; Load the configuration without starting Doom or changing any notes.
(defmacro after! (_feature &rest body) `(progn ,@body))
(defmacro map! (&rest _bindings) nil)
(load (expand-file-name ".config/doom/config.el"
                        (file-name-directory load-file-name)) nil t)

(let* ((today (org-today))
       (weekday (calendar-day-of-week (calendar-current-date)))
       (monday (- today (mod (1- weekday) 7)))
       (next-monday (+ monday 7))
       (directory (make-temp-file "doom-agenda-test-" t))
       (file (expand-file-name "tasks.org" directory))
       (org-agenda-files (list file))
       (org-agenda-window-setup 'current-window)
       (org-agenda-show-future-repeats t))
  (unwind-protect
      (progn
        (with-temp-file file
          (dolist (item `(("TODO Old schedule" "SCHEDULED" ,(1- today) "")
                          ("ON_HOLD Old deadline" "DEADLINE" ,(1- today) "")
                          ("DONE Finished schedule" "SCHEDULED" ,(1- today) "")
                          ("CANCELED Finished deadline" "DEADLINE" ,(1- today) "")
                          ("TODO Today schedule" "SCHEDULED" ,today "")
                          ("TODO Today deadline" "DEADLINE" ,today "")
                          ("TODO Future warning" "DEADLINE" ,next-monday " -14d")
                          ("TODO Next schedule" "SCHEDULED" ,next-monday " 12:00")
                          ("DONE Finished future task" "SCHEDULED" ,next-monday "")
                          ("Next milestone :MILESTONE:" "DEADLINE" ,(+ next-monday 6) " 23:00")
                          ("TODO Tomorrow task" "SCHEDULED" ,(1+ today) "")
                          ("TODO Day thirty deadline" "DEADLINE" ,(+ today 30) " 23:59")
                          ("TODO Day thirty schedule" "SCHEDULED" ,(+ today 30) " 23:59")
                          ("TODO Too far away" "DEADLINE" ,(+ today 31) "")
                          ("TODO Schedule too far away" "SCHEDULED" ,(+ today 31) "")
                          ("Recurring meeting" "SCHEDULED" ,(1- monday) " +1w")))
            (pcase-let ((`(,heading ,kind ,day ,suffix) item))
              (insert (format "* %s\n%s: <%s%s>\n"
                              heading kind
                              (format-time-string "%Y-%m-%d %a"
                                                  (org-time-from-absolute day))
                              suffix))))
          (dolist (item `(("TODO Ongoing task" ,(+ today 2))
                          ("TODO Ends today" ,today)
                          ("TODO Ended task" ,(1- today))
                          ("DONE Finished interval" ,(1- today))))
            (insert (format "* %s\nSCHEDULED: <%s> DEADLINE: <%s>\n"
                            (car item)
                            (format-time-string "%Y-%m-%d %a"
                                                (org-time-from-absolute (- today 3)))
                            (format-time-string "%Y-%m-%d %a"
                                                (org-time-from-absolute (cadr item))))))
          (dolist (item `(("TODO Whole week interval" ,(1- monday) ,(1- next-monday))
                          ("TODO Ends today interval" ,(- today 3) ,today)
                          ("TODO Expired interval" ,(- today 4) ,(1- today))
                          ("DONE Finished range" ,(- today 4) ,(1- today))
                          ("TODO Next interval" ,next-monday ,(+ next-monday 2))
                          ("TODO Overlapping interval" ,(1- monday) ,(+ next-monday 2))))
            (insert (format "* %s\nSCHEDULED: <%s>--<%s>\n"
                            (car item)
                            (format-time-string "%Y-%m-%d %a"
                                                (org-time-from-absolute (cadr item)))
                            (format-time-string "%Y-%m-%d %a"
                                                (org-time-from-absolute (caddr item))))))
          (insert "* TODO No date\n"
                  "* Styled parent\n** ON_HOLD Styled task [0/2] :MILESTONE:\n"
                  (format "SCHEDULED: <%s 12:00> DEADLINE: <%s>\n"
                          (format-time-string "%Y-%m-%d %a" (org-time-from-absolute today))
                          (format-time-string "%Y-%m-%d %a" (org-time-from-absolute next-monday)))))
        (org-agenda nil "a")
        (with-current-buffer org-agenda-buffer-name
          (let* ((text (buffer-string))
                 (week-start (string-match "Week-agenda" text))
                 (upcoming-start (string-match "Upcoming deadlines/schedules" text))
                 (past (substring text 0 week-start))
                 (week (substring text week-start upcoming-start))
                 (upcoming (substring text upcoming-start)))
            (cl-assert (string-match-p "Overdue Tasks" past))
            (dolist (name '("Old schedule" "Old deadline" "Ended task" "Expired interval"))
              (cl-assert (string-match-p name past)))
            (dolist (name '("Finished schedule" "Finished deadline" "No date" "Today schedule"
                           "Ongoing task" "Ends today" "Finished interval"
                           "Whole week interval" "Ends today interval" "Finished range"
                           "Next interval" "Overlapping interval"))
              (cl-assert (not (string-match-p name past))))
            (dolist (name '("Today schedule" "Today deadline" "Recurring meeting"))
              (cl-assert (string-match-p name week)))
            (dolist (name '("Old schedule" "Old deadline"))
              (cl-assert (= (length (split-string week (regexp-quote name)))
                            (if (>= (1- today) monday) 2 1))))
            (dolist (name '("Whole week interval" "Overlapping interval"))
              (save-excursion
                (goto-char (point-min))
                (let (dates)
                  (while (search-forward name nil t)
                    (push (calendar-absolute-from-gregorian
                           (get-text-property (match-beginning 0) 'date)) dates))
                  (cl-assert (equal (nreverse dates) (number-sequence monday (1- next-monday)))))))
            (dolist (name '("Future warning" "Next schedule" "Next milestone" "Sched."))
              (cl-assert (not (string-match-p (regexp-quote name) week))))
            (cl-assert (string-match-p "(next 30 days)" upcoming))
            (dolist (name '("Future warning" "Next schedule" "Next milestone"
                           "Next interval" "Day thirty deadline" "Day thirty schedule"))
              (cl-assert (string-match-p name upcoming)))
            (cl-assert (eq (not (null (string-match-p "Tomorrow task" upcoming)))
                           (>= (1+ today) next-monday)))
            (dolist (name '("Too far away" "Schedule too far away" "Finished future task"
                           "Today schedule" "Today deadline" "Old schedule" "Old deadline"
                           "Whole week interval" "Ends today interval" "Overlapping interval"))
              (cl-assert (not (string-match-p name upcoming))))
            (cl-assert (string-match-p
                        (regexp-quote (format "Scheduled: <%s>--<%s>"
                                              (format-time-string "%Y-%m-%d %a"
                                                                  (org-time-from-absolute next-monday))
                                              (format-time-string "%Y-%m-%d %a"
                                                                  (org-time-from-absolute (+ next-monday 2)))))
                        upcoming))
            (princ "Agenda check passed: overdue block, assigned dates, repeaters, upcoming block.\n")))
        (dolist (view '(week todo milestones tags search))
          (pcase view
            ('week (org-agenda nil "a"))
            ('todo (org-todo-list))
            ('milestones (org-agenda nil "m"))
            ('tags (org-tags-view nil "MILESTONE"))
            ('search (org-search-view nil "Styled task")))
          (with-current-buffer org-agenda-buffer-name
            (goto-char (point-min))
            (while (progn
                     (search-forward "Styled task")
                     (not (get-text-property (line-beginning-position) 'org-hd-marker))))
            (let ((start (line-beginning-position))
                  (end (line-end-position)))
              (dolist (field '(("tasks" . font-lock-function-name-face)
                               ("Styled parent" . shadow)
                               ("ON_HOLD" . warning)
                               ("MILESTONE" . org-tag)
                               ("[0/2]" . shadow)
                               ("Scheduled:" . org-scheduled)))
                (goto-char start)
                (search-forward (car field) end)
                (let ((face (get-text-property (- (point) (length (car field))) 'face)))
                  (cl-assert (or (eq face (cdr field))
                                 (and (listp face) (memq (cdr field) face))))))
              (goto-char start)
              (if (eq view 'week)
                  (search-forward "12:00" end)
                (search-forward (format-time-string "%Y-%m-%d" (org-time-from-absolute today)) end))
              (cl-assert (eq 'org-date (get-text-property (1- (point)) 'face))))
            (let ((before (buffer-string)))
              (+org-agenda-style-view)
              (cl-assert (equal-including-properties before (buffer-string))))))
        (dolist (case '((nil "Old schedule" org-warning)
                        ("DONE" "Finished schedule" org-agenda-done)))
          (org-todo-list (car case))
          (with-current-buffer org-agenda-buffer-name
            (goto-char (point-min))
            (search-forward (cadr case))
            (let ((start (line-beginning-position))
                  (end (line-end-position)))
              (goto-char start)
              (search-forward "Scheduled:" end)
              (cl-assert (eq (get-text-property (1- (point)) 'face) (caddr case)))
              (search-forward "<" end)
              (cl-assert (eq (get-text-property (1- (point)) 'face) (caddr case)))
              (when (car case)
                (search-forward "DONE" end)
                (cl-assert (eq (get-text-property (1- (point)) 'face) 'org-done))))))
        (princ "Style check passed: weekly, TODO, milestone/tag and search views; status/tag faces preserved.\n"))
    (when (get-file-buffer file)
      (kill-buffer (get-file-buffer file)))
    (delete-directory directory t)))
