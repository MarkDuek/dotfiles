;;; init.el -*- lexical-binding: t; -*-

(doom!
 :completion
 vertico

 :ui
 doom
 doom-dashboard

 :editor
 (evil +everywhere)

 :tools
 biblio

 :lang
 (org +roam)

 :config
 (default +bindings))
