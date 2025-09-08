;;; magit-config.el --- Magit configuration -*- lexical-binding: t -*-

(use-package magit
  :ensure nil
  :bind (("C-c g g" . magit-status)
         ("C-c g l" . magit-log)
         ("C-c g b" . magit-blame)))

(provide 'magit-config)
;;; magit-config.el ends here
