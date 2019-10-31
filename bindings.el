;; sept 5 2019, these bindings are intended to be similar to the ones
;; from before, from 190827, as can be found in google drive
;; The basic idea is to not disturb the traditional emacs keybindings,
;; like C-f for forward-char, C-w and A-w for cut and copy, and C-y for paste,
;; etc. etc.

;; to match Gnome terminal copy and paste
(global-set-key (kbd "C-S-c") 'kill-ring-save)
(global-set-key (kbd "C-S-v") 'yank)

(defun kill-ring-save-line ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))
(global-set-key (kbd "S-<backspace>") 'kill-ring-save-line)
;; originally backward-delete-char-untabify, same as backspace

(defun newline-above ()
  (interactive)
  (move-beginning-of-line nil) (newline) (previous-line))
(global-set-key (kbd "M-o") 'newline-above)
;; originally the prefix key for facemenu-keymap
;; see info (elisp)Prefix Keys

(defun newline-below () (interactive) (move-end-of-line nil) (newline))
(global-set-key (kbd "C-o") 'newline-below)
;; originally openline

(global-set-key (kbd "M-z") 'switch-to-buffer) ;; zap-to-char
(defun switch-to-other-buffer () (interactive) (switch-to-buffer nil))
(global-set-key (kbd "C-z") 'switch-to-other-buffer) ;; suspend-frame

;; I had list-buffers here, which deleted my other windows
;; Now that I'm saving window positions upon exiting emacs so I don't have
;; to reopen where I left off, I won't use that anymore
;; (global-set-key (kbd "s-z") 'ignore)

(global-set-key (kbd "M-r") 'recentf-open-files)
;; move-to-window-line-top-bottom

;; digit-argument, already done by M-1
;; these are shorthand for C-x 1, etc.
(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-window-below)
(global-set-key (kbd "C-3") 'split-window-right)
;; (global-set-key (kbd "C-4") 'ignore)
;; (global-set-key (kbd "C-5") 'ignore)
;; (global-set-key (kbd "C-6") 'ignore)
;; (global-set-key (kbd "C-7") 'ignore)
;; (global-set-key (kbd "C-8") 'ignore)
;; (global-set-key (kbd "C-9") 'ignore)
;; (global-set-key (kbd "C-0") 'ignore)

;; no shorthard for open new window, since that screws with the saved .desktop file
;; use C-2 instead

;; M-s originally prefix key for search-map
(defvar master-save-key (kbd "M-s"))
;; cannot use a let because of elisp lacking lexical scoping or something
(global-set-key master-save-key 'save-buffer)
;; need to use hook instead of directly defining because mode-maps
;; do not exist before entering mode for first time
(add-hook
 'Custom-mode-hook
 (lambda ()
   (define-key custom-mode-map master-save-key 'Custom-save)
   (define-key custom-field-keymap master-save-key 'Custom-save)))
(add-hook
 'custom-theme-choose-mode-hook
 (lambda ()
   (define-key custom-theme-choose-mode-map master-save-key 'custom-theme-save)))
;; enables saving in both customize buffers and the textboxes in them
;; and also in customize-themes

(let ((S-return (kbd "S-<return>")))
  (define-key emacs-lisp-mode-map S-return 'eval-last-sexp)
  (define-key lisp-interaction-mode-map S-return 'eval-last-sexp))

;; (global-set-key (kbd "S-<return>") 'ignore)
;; (global-set-key (kbd "C-<return>") 'ignore)
;; (global-set-key (kbd "M-<return>") 'ignore)

(let ((backtab (kbd "<backtab>"))) ;; shift tab
  (define-key emacs-lisp-mode-map backtab 'completion-at-point)
  (define-key lisp-interaction-mode-map backtab 'completion-at-point))

;; let cinnamon have "M-<tab>", because that seems standard;
;; windows 10, cinnamon, and gnome all obey this!
(global-set-key (kbd "C-<tab>") 'other-window)
(defun other-window-previous () (interactive) (other-window -1))
(global-set-key (kbd "C-S-<iso-lefttab>") 'other-window-previous)
;; (global-set-key (kbd "<backtab>") 'ignore) ;; shift tab

;; emacs.stackexchange.com/questions/220
;; this input-decode-map method only works for GUI emacs, not terminal
;; there appears to be a solution in the thread above for terminal, but
;; it looks complicated. Don't even bother; terminal emacs is basically
;; unusable.
(define-key input-decode-map (kbd "C-i") [C-i])

;; taken by another one of my bindings elsewhere)
;; (global-set-key (kbd "<C-i>") 'ignore)

(global-set-key (kbd "M-i") 'copy-buffer-filename) ;; tab-to-tab-stop

(defun copy-buffer-filename ()
  (interactive)
  (kill-new (buffer-file-name))
  (message (concat "copied filename " (buffer-file-name))))

(define-key input-decode-map (kbd "C-m") [C-m])
;; reserved by corp
;; (global-set-key (kbd "<C-m>") 'ignore)
;; M-m moves to first non-whitespace character

(define-key input-decode-map (kbd "C-[") [C-bracketleft])
;; (global-set-key (kbd "C-<bracketleft>") 'ignore)
;; "C-]" is abort-recursive-edit; useful for leaving minibuffer

(global-unset-key (kbd "M-{"))  ;; backward-paragraph
(global-unset-key (kbd "M-}"))  ;; forward-paragraph
(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)

;; some keys that are redundant but work like in Chrome, so I may or may not rebind these
(defun backward-kill-line () (interactive) (kill-line 0))
(global-set-key (kbd "C-<backspace>") 'backward-kill-line)
;; (global-set-key (kbd "C-<delete>") 'ignore)

;; (global-set-key (kbd "S-<delete>") 'ignore)  ;; kill-region, same as C-w
;; (global-set-key (kbd "M-<delete>") 'ignore)
;; backward-kill-word, same as M-<backspace>

(global-set-key (kbd "M-t") 'visual-line-mode) ;; transpose-words
(global-set-key (kbd "C-t") 'toggle-truncate-lines) ;; transpose-chars
(global-set-key (kbd "M-c") 'compile) ;; capitalize-word

;; C-j is newline without indentation, which might be useful
;; (global-set-key (kbd "M-j") 'ignore) ;; indent-new-comment-line

;; C-l is recenter-top-bottom
;; (global-set-key (kbd "M-l") 'ignore) ;; downcase-word

;; these don't work in bash
;; (global-set-key (kbd "M-k") 'ignore) ;; kill-sentence
;; (global-set-key (kbd "M-e") 'ignore) ;; forward-sentence
;; (global-set-key (kbd "M-a") 'ignore) ;; backward-sentence

;; don't use this; I have C-q set to close window in Cinnamon,
;; since a lot of programs already use this, like Nemo and VLC, and also
;; C-q never means anything else, e.g. in Chrome it does nothing.
;; (global-set-key (kbd "C-q") 'ignore) ;; quoted-insert

;; (global-set-key (kbd "M-q") 'ignore) ;; fill-paragraph

;; (global-set-key (kbd "M-u") 'ignore) ;; upcase-word

(global-set-key (kbd "C-h") 'mark-whole-buffer) ;; help prefix, same as F1

(defun find-or-info-file (filename)
  (if (string-suffix-p ".info" filename)
      (info filename)
    (find-file filename)))

;; take last copied string from clipboard, treat it as a filename, and
;; either use info on it if it ends in '.info', or visit it otherwise
(defun find-or-info-clipbard ()
  (interactive)
  (find-or-info-file (current-kill 0)))

(global-set-key (kbd "C-,") 'find-or-info-clipbard)
(global-set-key (kbd "M-,") 'find-file) ;; xref-pop-marker-stack
;; (global-set-key (kbd "C-.") 'ignore)
;; (global-set-key (kbd "M-.") 'ignore) ;; xref-find-definitions

;; (global-set-key (kbd "C-=") 'ignore)
;; (global-set-key (kbd "M-=") 'ignore) ;; count-words-region
;; (global-set-key (kbd "C--") 'ignore) ;; negative-argument
;;                      "M--" is also negative-argument

;; if gnome or cinnamon is capturing M-`, do this:
;; gsettings set org.cinnamon.desktop.keybindings.wm switch-group []
;; M-` is tmm-menubar, probably useful

(defun kill-current-buffer () (interactive) (kill-buffer (current-buffer)))
(global-set-key (kbd "C-`") 'kill-current-buffer)
;; (global-set-key (kbd "C-'") 'ignore)
;; (global-set-key (kbd "M-'") 'ignore) ;; abbrev-prefix-mark

;; (global-set-key (kbd "C-;") 'ignore)
;; M-;  comment-dwim (super useful)

;; (global-set-key (kbd "C-<prior>") 'ignore) ;; scroll-right
;; (global-set-key (kbd "C-<next>") 'ignore) ;; scroll-left
;; (global-set-key (kbd "S-<prior>") 'ignore)
;; (global-set-key (kbd "S-<next>") 'ignore)
;; the two below actually look pretty useful
;; (global-set-key (kbd "M-<prior>") 'ignore) ;; scroll-other-window-down
;; (global-set-key (kbd "M-<next>") 'ignore) ;; scroll-other-window

;; (global-set-key (kbd "M-n") 'ignore)
;; (global-set-key (kbd "M-p") 'ignore)
;; (global-set-key (kbd "C-<escape>") 'ignore)
;; M-<escape> is tricky because of the ESC <-> M equivalence; better not touch it

;; (global-set-key (kbd "S-SPC") 'ignore)
;; (global-set-key (kbd "M-SPC") 'ignore) ;; just-one-space
;; C-SPC is set-mark-command; very useful

;; C-\  toggle-input-method, for TeX; actually useful
;; M-\  delete-horizontal-space; actually useful
;; C-/  undo: obviously useful
;; M-/  dabbrev-expand (wow! this is super nice!)

;; okay that takes care of all the keybindings; there are also other
;; useful functions remaining in the old corp .emacs file

;; (global-set-key (kbd "<f2>") 'ignore) ;; prefix for 2C-mode-map
;; (global-set-key (kbd "<f3>") 'ignore) ;; kmacro-start-macro-or-insert-counter
;; (global-set-key (kbd "<f4>") 'ignore) ;; kmacro-end-or-call-macro
;; (global-set-key (kbd "<f5>") 'ignore)
;; (global-set-key (kbd "<f6>") 'ignore)
;; (global-set-key (kbd "<f7>") 'ignore)
;; (global-set-key (kbd "<f8>") 'ignore)
;; (global-set-key (kbd "<f9>") 'ignore)
;; (global-set-key (kbd "<f10>") 'ignore) ;; menu-bar-open
;; f11 is maximize; keep this way
;; (global-set-key (kbd "<f12>") 'ignore)
;; also C-<f1>, M-<f1>, S-<f1>, s-<f1>

;; from archwiki thinkpad x1 carbon 6gen
;; (global-set-key (kbd "C-<pause>") 'ignore) ;; Fn+B
;; (global-set-key (kbd "<pause>") 'ignore) ;; Fn+P
;; (global-set-key (kbd "<Scroll_Lock>") 'ignore) ;; Fn+K

;; don't have <XF86WakeUp> by itself because need to use for volume
;; (global-set-key (kbd "S-<XF86WakeUp>") 'ignore)
;; (global-set-key (kbd "C-<XF86WakeUp>") 'ignore)
;; (global-set-key (kbd "M-<XF86WakeUp>") 'ignore)
;; (global-set-key (kbd "s-<XF86WakeUp>") 'ignore)
;; Fn-F11 seems to be caught by something outside emacs
;; (global-set-key (kbd "<XF86Favorites>") 'ignore) ;; Fn-F12
