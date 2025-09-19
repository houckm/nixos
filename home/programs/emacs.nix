{ config, lib, pkgs, ... }:

{
 programs.emacs = {
   enable = true;
   package = pkgs.emacs;
   extraPackages = epkgs: with epkgs; [
     # Core
     use-package
     evil
     evil-collection
     which-key
     
     # UI
     dashboard
     doom-themes
     doom-modeline
     all-the-icons
     org-bullets
     
     # Completion & Navigation
     company
     corfu
     cape
     vertico
     consult
     marginalia
     embark
     embark-consult
     projectile
     
     # Terminal
     vterm
     vterm-toggle
     
     # Languages
     nix-mode
     python-mode
     yaml-mode
     haskell-mode
     ansible
     
     # LSP
     lsp-mode
     lsp-ui
     lsp-pyright
     lsp-haskell
     
     # Org
     org
     org-roam
     org-roam-ui
     org-journal
     ob-nix
     
     # Git
     magit
   ];
   
   extraConfig = ''
     ;; Basic settings
     (setq inhibit-startup-message t)
     (tool-bar-mode -1)
     (menu-bar-mode -1)
     (scroll-bar-mode -1)
     (global-display-line-numbers-mode 1)
     
     ;; Font
     (set-face-attribute 'default nil
                         :font "JetBrainsMono Nerd Font"
                         :height 140)
     
     (require 'use-package)
     (setq use-package-always-ensure nil)
     
     ;; Evil mode
     (use-package evil
       :init (setq evil-want-keybinding nil)
       :config (evil-mode 1))
     
     (use-package evil-collection
       :after evil
       :config (evil-collection-init))
     
     ;; Vertico + Consult + Marginalia
     (use-package vertico
       :init (vertico-mode))
     
     (use-package consult
       :bind (("C-s" . consult-line)
              ("C-S-s" . consult-line-multi)
              ("C-x b" . consult-buffer)
              ("M-y" . consult-yank-pop)
              ("C-c f" . consult-find)
              ("C-c g" . consult-grep)))
     
     (use-package marginalia
       :init (marginalia-mode))
     
     (use-package embark
       :bind (("C-." . embark-act)
              ("M-." . embark-dwim)))
     
     (use-package embark-consult
       :after (embark consult))
     
     ;; Projectile
     (use-package projectile
       :init (projectile-mode 1)
       :custom
       (projectile-project-search-path '("~/projects" "~/org-roam"))
       :bind-keymap
       ("C-c p" . projectile-command-map))
     
    (use-package vterm-toggle
      :bind (("C-\\" . vterm-toggle)
            ("C-c t" . vterm-toggle))
      :custom
      (vterm-toggle-fullscreen-p nil)
      (vterm-toggle-scope 'project)
      (vterm-toggle-cd-auto-create-buffer t))


     ;; Dashboard
     (use-package dashboard
       :config
       (dashboard-setup-startup-hook)
       (setq dashboard-startup-banner 'logo
             dashboard-center-content t
             dashboard-items '((recents . 5)
                               (projects . 5)
                               (agenda . 5))))
     
     ;; Theme
     (use-package doom-themes
       :config
       (load-theme 'leuven t)
       (doom-themes-org-config))
     
     (use-package doom-modeline
       :hook (after-init . doom-modeline-mode))
     
     ;; Completion with Corfu + Cape
     (use-package corfu
       :custom
       (corfu-auto t)
       (corfu-cycle t)
       :init
       (global-corfu-mode))
     
     (use-package cape
       :init
       (add-to-list 'completion-at-point-functions #'cape-dabbrev)
       (add-to-list 'completion-at-point-functions #'cape-file)
       (add-to-list 'completion-at-point-functions #'cape-elisp-block))
     
     ;; Org mode
     (use-package org
       :custom
       (org-agenda-files '("~/org/" "~/org-roam/"))
       (org-default-notes-file "~/org/notes.org")
       :bind (("C-c a" . org-agenda)
              ("C-c c" . org-capture)))
     

     ;; Org-babel configuration
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
        (python . t)
        (shell . t)
        (haskell . t)
        (nix . t)))

     ;; Add syntax highlighting for YAML and Ansible (non-executable)
     (add-to-list 'org-src-lang-modes '("yaml" . yaml))
     (add-to-list 'org-src-lang-modes '("ansible" . yaml)) 

     ;; Don't prompt before evaluating code blocks
     (setq org-confirm-babel-evaluate nil)

     ;; Syntax highlighting in code blocks
     (setq org-src-fontify-natively t)
     (setq org-src-tab-acts-natively t)

     ;; Better code block templates
     (require 'org-tempo) 

     ;; Org bullets
     (use-package org-bullets
       :hook (org-mode . org-bullets-mode))
     
     ;; Org-journal
     (use-package org-journal
       :custom
       (org-journal-dir "~/org/journal/")
       (org-journal-file-format "%Y-%m-%d.org")
       :bind (("C-c j" . org-journal-new-entry)))
     
     ;; Org-roam
     (use-package org-roam
       :custom
       (org-roam-directory "~/org-roam/")
       (org-roam-capture-templates
        '(("j" "Journal" plain "* %?\nEntered on %U\n  %i\n  %a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :journal:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("m" "Meeting" plain "* %? :meeting:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :meeting:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("a" "Ansible Idea" plain "* %? :ansible:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :ansible:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("n" "Note" plain "* %? :note:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :note:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("t" "Todo" plain "* TODO %?\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :todo:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("p" "Project Idea" plain "* %? :project:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :project:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("b" "Bookmark / Link" plain "* %? :bookmark:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :bookmark:\n:PROPERTIES:\n:CREATED: %U\n:ROAM_REFS: %?\n:END:\n")
           :unnarrowed t)
          ("r" "Reading Note" plain "* %? :reading:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :reading:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)
          ("c" "Code Snippet" plain "* %? :code:\n%U\n%a"
           :target (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                              "#+title: ''${title}\n#+filetags: :code:\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
           :unnarrowed t)))
       :bind (("C-c n l" . org-roam-buffer-toggle)
              ("C-c n f" . org-roam-node-find)
              ("C-c n i" . org-roam-node-insert))
       :config
       (org-roam-setup))
     
     ;; Magit
     (use-package magit
       :bind ("C-x g" . magit-status))


     (use-package ansible
       :hook (yaml-mode . ansible))

     
     ;; Haskell
     (use-package haskell-mode
       :hook (haskell-mode . turn-on-haskell-indentation)
              (haskell-mode . lsp))
     
     ;; LSP
     (use-package lsp-mode
       :hook ((nix-mode . lsp)
              (python-mode . lsp)
              (yaml-mode . lsp)
              (haskell-mode . lsp)
              (haskell-literate-mode . lsp))
       :commands lsp)
     
     (use-package lsp-haskell
       :after lsp-mode)
       

     ;; C/C++ Development
     (use-package cc-mode
        :hook ((c-mode . lsp)
               (c++-mode . lsp))
      :custom
      (c-default-style "linux")
      (c-basic-offset 4))

     ;; Which-key
     (use-package which-key
       :config (which-key-mode))
   '';
 };
}
