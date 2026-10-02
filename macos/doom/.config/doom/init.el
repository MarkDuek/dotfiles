;;; init.el -*- lexical-binding: t; -*-

;; Only Vim editing, Org, and Doom's standard keybindings.
(doom! :editor
       (evil +everywhere)

       :lang
       org

       :config
       (default +bindings))
