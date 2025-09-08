;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;; Performance optimizations for startup
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;; Add core, langs, and tools to load path
(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "langs" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "tools" user-emacs-directory))

;; Load core configuration
(require 'defaults)
(require 'ui)
(require 'keybindings)
(require 'completion)

;; Load language configurations
(require 'nix-config)

;; Load tools
(require 'magit-config)
(require 'project)

;; Reset GC threshold
(setq gc-cons-threshold (* 2 1024 1024))

;;; init.el ends here
