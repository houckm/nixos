;;; init.el --- Ultimate Polished Emacs IDE + PKM + Org + Terminal Setup -*- lexical-binding: t; -*-

;; --------------------
;; UI Settings
;; --------------------
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80)
(global-display-line-numbers-mode t)
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1)

;; --------------------
;; Font Configuration
;; --------------------
(set-face-attribute 'default nil
                    :family "JetBrains Mono Nerd Font"
                    :height 140) ; 140 = 14pt (height is in 1/10 points)

;; Set font for variable pitch mode (used in org-mode)
(set-face-attribute 'variable-pitch nil
                    :family "JetBrains Mono Nerd Font"
                    :height 140)

;; --------------------
;; Themes & Modeline
;; --------------------
(use-package doom-themes
  :config (load-theme 'doom-one t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; --------------------
;; Dashboard
;; --------------------
(use-package dashboard
  :config
  (setq dashboard-startup-banner 'official
        dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda   . 5))
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t)
  (dashboard-setup-startup-hook))

;; --------------------
;; Evil Mode + Surround + Avy
;; --------------------
(use-package evil
  :init
  (setq evil-want-C-u-scroll t
        evil-want-C-i-jump nil)
  :config (evil-mode 1))

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package avy
  :bind ("C-:" . avy-goto-char))

;; --------------------
;; Helm + Projectile
;; --------------------
(use-package helm
  :init (require 'helm-config)
  :bind (("M-x"     . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b"   . helm-mini)
         ("C-s"     . helm-occur))
  :config (helm-mode 1))

(use-package projectile
  :init (projectile-mode 1)
  :custom
  (projectile-completion-system 'helm)
  (projectile-project-search-path '("~/projects" "~/org-roam")))

(use-package helm-projectile
  :after (helm projectile)
  :config (helm-projectile-on)
  :bind (("C-c p f" . helm-projectile-find-file)
         ("C-c p p" . helm-projectile-switch-project)
         ("C-c p s" . helm-projectile-ag)))

;; --------------------
;; Treemacs
;; --------------------
(use-package treemacs
  :bind (("C-x t t" . treemacs)))

;; --------------------
;; Org Mode + Org-Roam + Org-Journal + Enhancements
;; --------------------
(use-package org
  :config
  (setq org-hide-emphasis-markers t
        org-startup-indented t
        org-pretty-entities t
        org-agenda-files '("~/org-roam" "~/org-todo.org"))
  ;; Org-writing enhancements
  (add-hook 'org-mode-hook 'visual-line-mode)         ;; Soft wrapping
  (add-hook 'org-mode-hook 'variable-pitch-mode)      ;; Variable pitch font
  (add-hook 'org-mode-hook 'flyspell-mode)            ;; Spell check
  (setq line-spacing 0.2)
  (setq org-startup-indented t))

(use-package org-roam
  :init (setq org-roam-directory (file-truename "~/org-roam"))
  :custom (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config (org-roam-db-autosync-mode))

(use-package org-journal
  :custom
  (org-journal-dir "~/org-journal/")
  (org-journal-file-type 'daily)
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-enable-agenda-integration t))

;; Org enhancements
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package org-super-agenda
  :after org
  :config (org-super-agenda-mode))

;; Org Capture Templates
(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree "~/org-journal/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("m" "Meeting" entry (file+headline "~/org-roam/notes.org" "Meetings")
         "* %? :meeting:\n%U\n%a")
        ("a" "Ansible Idea" entry (file+headline "~/org-roam/ansible.org" "Ideas")
         "* %? :ansible:\n%U\n%a")
        ("n" "Note" entry (file+headline "~/org-roam/notes.org" "Notes")
         "* %? :note:\n%U\n%a")
        ("t" "Todo" entry (file+headline "~/org-roam/todo.org" "Tasks")
         "* TODO %?\n%U\n%a")
        ("p" "Project Idea" entry (file+headline "~/org-roam/projects.org" "Projects")
         "* %? :project:\n%U\n%a")
        ("b" "Bookmark / Link" entry (file+headline "~/org-roam/bookmarks.org" "Bookmarks")
         "* %? :bookmark:\n%U\n%a")
        ("r" "Reading Note" entry (file+headline "~/org-roam/reading.org" "Reading Notes")
         "* %? :reading:\n%U\n%a")
        ("c" "Code Snippet" entry (file+headline "~/org-roam/code.org" "Snippets")
         "* %? :code:\n%U\n%a")))

;; --------------------
;; Org Focus Mode (Writeroom + Olivetti)
;; --------------------
(use-package writeroom-mode
  :config
  (setq writeroom-width 100
        writeroom-fullscreen-effect 'maximized))

(use-package olivetti
  :config
  (setq olivetti-body-width 100))

(defun my/org-focus-mode ()
  "Enable Org distraction-free writing."
  (interactive)
  (writeroom-mode 1)
  (olivetti-mode 1))

(defun my/org-focus-mode-off ()
  "Disable Org distraction-free writing."
  (interactive)
  (writeroom-mode 0)
  (olivetti-mode 0))

(global-set-key (kbd "C-c f") 'my/org-focus-mode)
(global-set-key (kbd "C-c F") 'my/org-focus-mode-off)

;; --------------------
;; Git
;; --------------------
(use-package magit
  :bind (("C-x g" . magit-status)))

;; --------------------
;; Which-key
;; --------------------
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode)

;; --------------------
;; LSP & Completion
;; --------------------
(use-package lsp-mode
  :commands lsp
  :hook ((c-mode      . lsp)
         (c++-mode    . lsp)
         (python-mode . lsp)
         (yaml-mode   . lsp)
         (nix-mode    . lsp))
  :config (setq lsp-prefer-flymake nil))

(use-package corfu
  :init (global-corfu-mode)
  :custom (corfu-auto t)
  (corfu-cycle t))

(use-package cape
  :after corfu
  :init
  (add-to-list 'completion-at-point-functions 'cape-file)
  (add-to-list 'completion-at-point-functions 'cape-dabbrev))

(use-package kind-icon
  :after corfu
  :custom (kind-icon-use-icons t)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package yasnippet
  :init (yas-global-mode 1))

;; --------------------
;; Snippets & Keybindings
;; --------------------
(defun ansible-lint-current-file ()
  (interactive)
  (shell-command (concat "ansible-lint " (buffer-file-name))))

(defun ansible-run-current-playbook ()
  (interactive)
  (shell-command (concat "ansible-playbook " (buffer-file-name))))

(use-package yaml-mode
  :mode "\\.yml\\'"
  :hook ((yaml-mode . (lambda ()
                        (define-key yaml-mode-map (kbd "C-c a l") 'ansible-lint-current-file)
                        (define-key yaml-mode-map (kbd "C-c a r") 'ansible-run-current-playbook)))))

(let ((snippet-dir "~/.emacs.d/snippets"))
  (setq yas-snippet-dirs
        (append yas-snippet-dirs
                (list (expand-file-name "yaml-mode" snippet-dir)
                      (expand-file-name "python-mode" snippet-dir)
                      (expand-file-name "c-mode" snippet-dir)
                      (expand-file-name "nix-mode" snippet-dir)))))

;; --------------------
;; Smartparens (Auto parentheses)
;; --------------------
(use-package smartparens
  :hook ((prog-mode . smartparens-mode)
         (text-mode . smartparens-mode))
  :config (require 'smartparens-config))

;; --------------------
;; Undo Tree
;; --------------------
(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

;; --------------------
;; Terminal (vterm) with pop-up toggle
;; --------------------
(use-package vterm
  :ensure t)

(use-package vterm-toggle
  :ensure t
  :bind (("C-`" . vterm-toggle))
  :config
  (setq vterm-toggle-fullscreen-p nil)) ;; nil = bottom pop-up

(defun my/vterm-fullscreen-toggle ()
  "Open vterm in fullscreen if not already."
  (interactive)
  (setq vterm-toggle-fullscreen-p t)
  (vterm-toggle)
  (setq vterm-toggle-fullscreen-p nil))

(global-set-key (kbd "C-c V") 'my/vterm-fullscreen-toggle)

(provide 'init)
;;; init.el ends here
