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

    # IAC
    terraform
    ansible

    nil # nix lsp
    yaml-language-server
    haskell-language-server
    ghc
    cabal-install
    claude-code
    clang-tools
    gdb
    gcc
    cmake


    # System monitoring & performance
    btop
    fd
    ripgrep
    fzf
    bat
    eza
    blueman
    zoxide
    
    # Network tools
    nmap
    tcpdump
    wireshark
    dig
    netcat-gnu
    iperf3

    # terminal & shell enhancement
    libvterm

    # Browsers
    firefox
    google-chrome

    # communication
    discord


    # torrents
    mullvad-vpn
    qbittorrent 

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
