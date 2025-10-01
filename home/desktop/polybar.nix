{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    
    config = {
      "bar/main" = {
        width = "100%";
        height = 22;
        background = "#2e3440";
        foreground = "#d8dee9";
        
        font-0 = "JetBrainsMono Nerd Font:size=10;2";
        
        modules-left = "xworkspaces";
        modules-center = "date";
        modules-right = "cpu memory filesystem wlan eth";
        
        padding-right = 1;
        module-margin = 1;
        
        tray-position = "right";
        tray-padding = 2;
      };
      
      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        
        label-active = "%name%";
        label-active-background = "#88c0d0";
        label-active-foreground = "#2e3440";
        label-active-padding = 1;
        
        label-occupied = "%name%";
        label-occupied-padding = 1;
        
        label-urgent = "%name%";
        label-urgent-background = "#bf616a";
        label-urgent-padding = 1;
        
        label-empty = "%name%";
        label-empty-foreground = "#4c566a";
        label-empty-padding = 1;
      };
      
      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%A %H:%M";
        label = "%date%";
      };
      
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#88c0d0";
        label = "%percentage:2%%";
      };
      
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#88c0d0";
        label = "%percentage_used%%";
      };
      
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 30;
        format-mounted-prefix = " ";
        format-mounted-prefix-foreground = "#88c0d0";
        label-mounted = "%used%/%total%";
      };
      
      "module/wlan" = {
        type = "internal/network";
        interface = "wlp13s0";
        interval = 3;
        format-connected = "<label-connected>";
        format-connected-prefix = "󰖩 ";
        format-connected-prefix-foreground = "#88c0d0";
        label-connected = "%downspeed%/%upspeed%";
        format-disconnected = "";
      };
      
      "module/eth" = {
        type = "internal/network";
        interface = "enp12s0";
        interval = 3;
        format-connected = "<label-connected>";
        format-connected-prefix = "󰈀 ";
        format-connected-prefix-foreground = "#88c0d0";
        label-connected = "%downspeed%/%upspeed%";
        format-disconnected = "";
      };
    };
  };
}
