;;; completion.el --- Completion setup -*- lexical-binding: t -*-

;; Vertico for vertical completion
(use-package vertico
  :ensure nil
  :init
  (vertico-mode)
  :config
  (setq vertico-cycle t))

;; Orderless for flexible matching
(use-package orderless
  :ensure nil
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia for annotations
(use-package marginalia
  :ensure nil
  :init
  (marginalia-mode))

;; Consult for search and navigation
(use-package consult
  :ensure nil
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("C-c r" . consult-ripgrep)))

;; Corfu for in-buffer completion
(use-package corfu
  :ensure nil
  :init
  (global-corfu-mode)
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 2))

(provide 'completion)
;;; completion.el ends here
