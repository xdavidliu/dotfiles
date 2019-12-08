;; this file will be sourced by ~/.emacs. Frequently-changed custom
;; settings will be kept in ~/.emacs, but unambigous settings like
;; making backups and not showing the menu bar will be kept here,
;; with the understanding that if we look at those variables in Customize,
;; it will say something like "this setting was changed elsewhere"

(load "~/dotfiles/bindings.el")

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; to make package-refresh-contents work
;; necessary due to bug in emacs <26.3
;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/

(column-number-mode)
(electric-pair-mode)

(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'recentf-mode t)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'inhibit-startup-screen t)
(customize-set-variable 'make-backup-files nil)
(customize-set-variable 'show-paren-mode t)
(customize-set-variable 'truncate-lines t)
(customize-set-variable 'compilation-ask-about-save nil)
(customize-set-variable 'compilation-scroll-output 'first-error)


(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
;; counterintuitively, set tramp-use-ssh-controlmaster-options to nil
;; to use the multiplexing settings in ~/.ssh/config
;; see https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html


(add-hook 'text-mode-hook 'visual-line-mode)

;; note there's also a cuda mode on Melpa
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;; Just use c-mode for flex and bison files. Note that in melpa
;; (but not melpa-stable), there is a bison-mode that claims to work for
;; both bison and flex, but it's un-usable: it indents and jumps all over the
;; place and is generally frustrating to use.
(add-to-list 'auto-mode-alist '("\\.l\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.y\\'" . c-mode))

;; note that current frame parameters can be obtained by doing
;; (assoc 'width (frame-parameters))
