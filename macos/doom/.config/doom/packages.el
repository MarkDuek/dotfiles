;;; packages.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; No optional Org export, clipboard, TOC, or async code-execution extensions.
(disable-packages! htmlize ox-clip toc-org org-cliplink ob-async)

(package! catppuccin-theme)
(package! org-roam-ui)
