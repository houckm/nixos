{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      ls = "eza";
      grep = "rg";
      cat = "bat";
      v = "nvim";
      cls = "clear";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      
      # NixOS shortcuts
      switch = "sudo nixos-rebuild switch --flake ~/nixos-config";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "docker"
        "kubectl" 
        "sudo"
        "history-substring-search"
        "colored-man-pages"
        "extract"
        "command-not-found"
      ];
    };
    
    initContent = ''
      # Custom functions
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Set editor
      export EDITOR="nvim"
      export VISUAL="nvim"
    '';
  };
}
