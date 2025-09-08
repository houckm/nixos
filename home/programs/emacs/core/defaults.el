;;; defaults.el --- Sensible defaults -*- lexical-binding: t -*-

;; Disable startup screen
(setq inhibit-startup-screen t
      initial-scratch-message nil)

;; Better defaults
(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 80)

;; Enable useful modes
(electric-pair-mode 1)
(show-paren-mode 1)
(global-auto-revert-mode 1)
(savehist-mode 1)
(recentf-mode 1)
(column-number-mode 1)

;; Backup settings
(setq backup-directory-alist '(("." . "~/.cache/emacs/backups"))
      auto-save-file-name-transforms '((".*" "~/.cache/emacs/auto-save/" t))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

;; Smooth scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position t)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Create cache directories if they don't exist
(make-directory "~/.cache/emacs/backups" t)
(make-directory "~/.cache/emacs/auto-save" t)

(provide 'defaults)
;;; defaults.el ends here
