{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    
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
    
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "*" = {
        bg = mkLiteral "#2e3440";
        bg-alt = mkLiteral "#3b4252";
        fg = mkLiteral "#d8dee9";
        fg-alt = mkLiteral "#4c566a";
        
        background-color = mkLiteral "@bg";
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };
      
      "window" = {
        width = mkLiteral "40%";
        background-color = mkLiteral "@bg";
        border = mkLiteral "2px";
        border-color = mkLiteral "#88c0d0";
      };
      
      "mainbox" = {
        children = map mkLiteral [ "inputbar" "listview" ];
      };
      
      "inputbar" = {
        background-color = mkLiteral "@bg-alt";
        children = map mkLiteral [ "prompt" "entry" ];
        padding = mkLiteral "12px";
      };
      
      "prompt" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#88c0d0";
        padding = mkLiteral "0 8px 0 0";
      };
      
      "entry" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "@fg";
        placeholder = "Search...";
        placeholder-color = mkLiteral "@fg-alt";
      };
      
      "listview" = {
        lines = 8;
        columns = 1;
        padding = mkLiteral "8px";
      };
      
      "element" = {
        padding = mkLiteral "8px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };
      
      "element selected" = {
        background-color = mkLiteral "#88c0d0";
        text-color = mkLiteral "@bg";
      };
      
      "element-icon" = {
        size = mkLiteral "1.5em";
        margin = mkLiteral "0 8px 0 0";
      };
      
      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };
  };
  
  # Icon theme for the icons
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
}
