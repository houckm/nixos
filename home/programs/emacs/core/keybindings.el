;;; keybindings.el --- Key bindings -*- lexical-binding: t -*-

;; Enable Evil mode
(use-package evil
  :ensure nil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  
  ;; Set initial state for some modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Evil Collection for better integration
(use-package evil-collection
  :ensure nil
  :after evil
  :config
  (evil-collection-init))

;; Set leader key for Evil mode
(evil-set-leader 'normal (kbd "SPC"))

;; Leader key bindings
(evil-define-key 'normal 'global
  (kbd "<leader>ff") 'find-file
  (kbd "<leader>fs") 'save-buffer
  (kbd "<leader>fr") 'recentf-open-files
  (kbd "<leader>bb") 'switch-to-buffer
  (kbd "<leader>bk") 'kill-this-buffer
  (kbd "<leader>br") 'revert-buffer
  (kbd "<leader>wv") 'split-window-right
  (kbd "<leader>ws") 'split-window-below
  (kbd "<leader>wd") 'delete-window
  (kbd "<leader>wo") 'delete-other-windows
  (kbd "<leader>gg") 'magit-status
  (kbd "<leader>pp") 'projectile-switch-project
  (kbd "<leader>pf") 'projectile-find-file
  (kbd "<leader>qq") 'save-buffers-kill-emacs)

;; Escape quits everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; Set leader key
(global-set-key (kbd "C-c") nil)

;; Window management
(global-set-key (kbd "C-c w v") 'split-window-right)
(global-set-key (kbd "C-c w s") 'split-window-below)
(global-set-key (kbd "C-c w d") 'delete-window)
(global-set-key (kbd "C-c w o") 'delete-other-windows)

;; Buffer management
(global-set-key (kbd "C-c b b") 'switch-to-buffer)
(global-set-key (kbd "C-c b k") 'kill-this-buffer)
(global-set-key (kbd "C-c b r") 'revert-buffer)

;; File operations
(global-set-key (kbd "C-c f f") 'find-file)
(global-set-key (kbd "C-c f r") 'recentf-open-files)
(global-set-key (kbd "C-c f s") 'save-buffer)

;; Better defaults
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'keybindings)
;;; keybindings.el ends here
