{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Import modular configurations
  imports = [
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/alacritty.nix
    ./programs/virt-manager.nix
    ./programs/emacs.nix
    ./programs/nvim.nix
    ./programs/git.nix
    ./desktop/xmonad.nix
  ];

  # XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  # Global packages not tied to specific programs
  home.packages = with pkgs; [

    # Development tools
    docker-compose
    docker
    kubectl
    terraform
    ansible
    nil
    yaml-language-server
    libvterm
    haskell-language-server
    ghc
    cabal-install
    claude-code


    # System utilities
    btop
    fd
    ripgrep
    fzf
    bat
    eza
    blueman
    
    # Network tools
    nmap
    tcpdump
    wireshark

    # Browsers
    firefox
    google-chrome

    # misc
    discord


    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
