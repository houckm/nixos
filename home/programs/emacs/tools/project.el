;;; project.el --- Project management -*- lexical-binding: t -*-

(use-package projectile
  :ensure nil
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'default
        projectile-enable-caching t))

(provide 'project)
;;; project.el ends here
