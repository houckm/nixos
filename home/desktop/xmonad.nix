{ config, pkgs, lib, ... }:

{
  # XMonad window manager configuration
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad/xmonad.hs;
    extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.xmonad-extras
    ];
  };

  # Status bar
  programs.xmobar = {
    enable = true;
    extraConfig = builtins.readFile ./xmonad/xmobarrc;
  };

  # XMonad-related packages
  home.packages = with pkgs; [
    dmenu           # Application launcher
    nitrogen        # Wallpaper setter
    picom           # Compositor
    dunst           # Notification daemon
    xclip           # Clipboard management
    maim            # Screenshot tool
    xdotool         # Window manipulation
    xorg.xrandr     # Display configuration
    arandr          # GUI for xrandr
    trayer          # System tray
  ];

  # Services that work well with XMonad
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.75;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 10";
        frame_color = "#88c0d0";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#3b4252";
        foreground = "#eceff4";
      };
      urgency_normal = {
        background = "#3b4252";
        foreground = "#eceff4";
      };
      urgency_critical = {
        background = "#bf616a";
        foreground = "#eceff4";
        frame_color = "#bf616a";
      };
    };
  };
}
