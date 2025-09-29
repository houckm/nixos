{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "Nord";
    
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      drun-display-format = "{icon} {name}";
      font = "JetBrainsMono Nerd Font 12";
    };
  };
  
  # Icon theme for the icons
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
}
