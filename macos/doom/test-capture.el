;;; test-capture.el -*- lexical-binding: t; -*-
;; Run: emacs --batch -Q -l macos/doom/test-capture.el

(require 'cl-lib)
(require 'org)
(require 'org-element)
(require 'org-capture)
(defmacro after! (_feature &rest body) `(progn ,@body))
(defmacro map! (&rest _bindings) nil)
(load (expand-file-name ".config/doom/config.el"
                        (file-name-directory load-file-name)) nil t)

(let* ((directory (make-temp-file "doom-capture-test-" t))
       (single (expand-file-name "single.org" directory))
       (multiple (expand-file-name "multiple.org" directory))
       (missing (expand-file-name "missing.org" directory)))
  (unwind-protect
      (progn
        (with-temp-file single
          (insert "* Tasks\n** TODO Work\n* Experiments :LOG:\n"))
        (with-temp-file multiple
          (insert "* Tasks\n* Logs\n** Research Log :LOG:\n*** Existing entry\n"
                  "** Development Log :LOG:\n"))
        (with-temp-file missing (insert "* Tasks\n"))
        (dolist (case `((,single "TODO Work" "Experiments" 0)
                        (,multiple "Existing entry" "Research Log" 0)
                        (,multiple "Tasks" "Development Log" 1)))
          (pcase-let ((`(,file ,origin ,parent ,expected-choices) case))
            (let ((choices 0) (titles 0))
              (set-buffer (find-file-noselect file))
              (goto-char (point-min))
              (search-forward origin)
              (cl-letf (((symbol-function 'completing-read)
                         (lambda (prompt candidates &rest _)
                           (if (string-prefix-p "Log section:" prompt)
                               (progn
                                 (cl-incf choices)
                                 (car (cl-find-if
                                       (lambda (candidate)
                                         (string-prefix-p parent (car candidate)))
                                       candidates)))
                             (cl-incf titles)
                             "Batch notes"))))
                (org-capture nil "l"))
              (cl-assert (= choices expected-choices))
              (cl-assert (= titles 1))
              (insert "Compared implementations.\n")
              (save-excursion
                (save-restriction
                  (widen)
                  (org-back-to-heading t)
                  (cl-assert (string-prefix-p "[" (org-get-heading t t t t)))
                  (cl-assert (string-suffix-p "] Batch notes" (org-get-heading t t t t)))
                  (cl-assert (not (org-get-todo-state)))
                  (org-up-heading-safe)
                  (cl-assert (equal (org-get-heading t t t t) parent))))
              (org-capture-finalize)
              (with-current-buffer (find-file-noselect file)
                (cl-assert (string-match-p "Compared implementations" (buffer-string)))))))
        (with-current-buffer (find-file-noselect missing)
          (let ((org-capture-plist (list :original-buffer (current-buffer))))
            (cl-assert (condition-case nil
                           (progn (+org-capture-project-log-target) nil)
                         (user-error t)))))
        (with-temp-buffer
          (let ((org-capture-plist (list :original-buffer (current-buffer))))
            (cl-assert (condition-case nil
                           (progn (+org-capture-project-log-target) nil)
                         (user-error t)))))
        (princ "Capture check passed: automatic log selection, multiple logs, title/date/body, invalid targets.\n"))
    (dolist (file (list single multiple missing))
      (when (get-file-buffer file) (kill-buffer (get-file-buffer file))))
    (delete-directory directory t)))
