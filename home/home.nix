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
      twitter = {
        name = "Twitter";
        exec = "google-chrome-stable --app=https://twitter.com";
        icon = "twitter";  # Uses system icon if available
        categories = [ "Network" "WebBrowser" ];
        comment = "Twitter Web App";
      };
      

      claude = {
      name = "Claude";
      exec = "google-chrome-stable --app=https://claude.ai";
      icon = "${config.home.homeDirectory}/.local/share/icons/claude.png";
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
      
      reddit = {
      name = "Reddit";
      exec = "google-chrome-stable --app=https://reddit.com";
      icon = "reddit";
      categories = [ "Network" "WebBrowser" ];
      comment = "Reddit Web App";
      };
      # Add more as needed
      gmail = {
        name = "Gmail";
        exec = "google-chrome-stable --app=https://mail.google.com";
        icon = "gmail";
        categories = [ "Network" "Email" ];
        comment = "Gmail Web App";
      };
    };
  };


  home.file.".local/share/icons/claude.png".source = ./assets/icons/claude.png;


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

    # communication
    discord


    # torrents
    mullvad-vpn
    qbittorrent 

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
