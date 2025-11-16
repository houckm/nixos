{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Import modular configurations
  imports = [
    # Program configs
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/alacritty.nix
    ./programs/virt-manager.nix
    ./programs/ssh.nix
    #./programs/emacs.nix
    ./programs/nvim.nix
    ./programs/tmux.nix
    ./programs/git.nix
    ./programs/rofi.nix

    # Desktop configs
    ./desktop/xmonad.nix
    ./desktop/polybar.nix
    ./desktop/applications.nix

    # Package modules
    ./modules/development.nix
    ./modules/browsers.nix
    ./modules/networking.nix
    ./modules/media.nix
  ];

  # XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  # Packages not in modules (system-specific or misc)
  home.packages = with pkgs; [
    blueman
    libvterm
    nerd-fonts.jetbrains-mono
  ];
}
