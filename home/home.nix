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
    #./programs/emacs.nix
    ./programs/nvim.nix
    ./programs/tmux.nix
    ./programs/git.nix
    ./programs/rofi.nix
    ./desktop/xmonad.nix
    ./desktop/polybar.nix
  ];

  # XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    desktopEntries = {
      claude = {
      name = "Claude";
      exec = "google-chrome-stable --app=https://claude.ai";
      icon = "claude";
      categories = [ "Network" "WebBrowser" "Development" ];
      comment = "Claude AI Assistant";
      };
      youtube = {
        name = "YouTube";
        exec = "google-chrome-stable --app=https://youtube.com";
        icon = "youtube";
        categories = [ "Network" "WebBrowser" "AudioVideo" ];
        comment = "YouTube Web App";
      };
      oreilly = {
        name = "O'Reilly";
        exec = "google-chrome-stable --app=https://learning.oreilly.com/home/";
        icon = "oreilly";
        categories = [ "Network" "WebBrowser" "AudioVideo" ];
        comment = "O'Reilly Web App";
      };
      reddit = {
      name = "Reddit";
      exec = "google-chrome-stable --app=https://reddit.com";
      icon = "reddit";
      categories = [ "Network" "WebBrowser" ];
      comment = "Reddit Web App";
      };
      gmail = {
        name = "Gmail";
        exec = "google-chrome-stable --app=https://mail.google.com";
        icon = "gmail";
        categories = [ "Network" "Email" ];
        comment = "Gmail Web App";
      };
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

    nil
    yaml-language-server
    haskell-language-server
    ghc
    cabal-install
    claude-code
    clang-tools
    gdb
    gcc
    cmake
    kiro

    # System monitoring & performance
    btop
    fd
    ripgrep
    fzf
    bat
    eza
    blueman
    zoxide
    ranger
    fastfetch
    vlc
    
    # Network tools
    nmap
    tcpdump
    wireshark
    dig
    netcat-gnu
    iperf3

    # terminal & shell enhancement
    libvterm
    tmux

    # Browsers
    firefox
    google-chrome

    obs-studio
    discord

    # torrents
    qbittorrent 

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
