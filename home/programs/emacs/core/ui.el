;;; ui.el --- UI Configuration -*- lexical-binding: t -*-

;; Set default font
(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font"
                    :height 150)  ; Height is in 1/10 pt, so 150 = 15pt

;; Set font for all frames
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-15"))


;; Clean up UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

;; Line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                help-mode-hook
                org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Theme
(use-package doom-themes
  :ensure nil
  :config
  (load-theme 'doom-nord t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Modeline
(use-package doom-modeline
  :ensure nil
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 3))

;; Which-key
(use-package which-key
  :ensure nil
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; All the icons
(use-package all-the-icons
  :ensure nil)

(provide 'ui)
;;; ui.el ends here
