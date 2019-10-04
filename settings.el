;; this file will be sourced by ~/.emacs. Frequently-changed custom
;; settings will be kept in ~/.emacs, but unambigous settings like
;; making backups and not showing the menu bar will be kept here,
;; with the understanding that if we look at those variables in Customize,
;; it will say something like "this setting was changed elsewhere"

(load "~/dotfiles/bindings.el")

(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'recentf-mode t)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'inhibit-startup-screen t)
(customize-set-variable 'make-backup-files nil)
