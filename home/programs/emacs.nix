{ config, pkgs, lib, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # or emacs29 for X11
    
    extraPackages = epkgs: with epkgs; [
      # Core packages
      use-package
      
      # Evil mode (if you want Vim bindings)
      evil
      evil-collection
      
      # Completion framework
      vertico
      consult
      orderless
      marginalia
      corfu
      cape
      
      # UI enhancements
      doom-themes
      doom-modeline
      all-the-icons
      which-key
      helpful
      
      # Project management
      projectile
      magit
      
      # Language support
      nix-mode
      markdown-mode
      yaml-mode
      json-mode
      web-mode
      
      # Org mode enhancements
      org-roam
      org-modern
      
      # Quality of life
      rainbow-delimiters
      highlight-indent-guides
      undo-tree
    ];
  };
  
  # Link our config files
  home.file = {
    ".config/emacs/init.el".source = ./emacs/init.el;
    ".config/emacs/core" = {
      source = ./emacs/core;
      recursive = true;
    };
    ".config/emacs/langs" = {
      source = ./emacs/langs;
      recursive = true;
    };
    ".config/emacs/tools" = {
      source = ./emacs/tools;
      recursive = true;
    };
  };
}
