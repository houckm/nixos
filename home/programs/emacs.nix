{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      # Themes & UI
      doom-themes
      doom-modeline
      dashboard
      
      # Evil mode
      evil
      evil-surround
      
      # Navigation
      avy
      helm
      projectile
      helm-projectile
      treemacs
      
      # Org mode ecosystem
      org
      org-roam
      org-journal
      org-bullets
      org-super-agenda
      
      # Focus mode
      writeroom-mode
      olivetti
      
      # Git
      magit
      
      # Utilities
      which-key
      general
      
      # LSP & Completion
      lsp-mode
      corfu
      cape
      kind-icon
      yasnippet
      
      # Language modes
      yaml-mode
      nix-mode
      
      # Editing
      smartparens
      undo-tree
      
      # Terminal
      vterm
      vterm-toggle
    ];
  };

  # Copy your init.el to the right location
  home.file.".emacs.d/init.el".source = ./emacs/init.el;
  
  # Optional: Create snippets directory structure
  home.file.".emacs.d/snippets/.keep".text = "";
}
