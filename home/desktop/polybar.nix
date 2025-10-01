{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    
    config = {
      "bar/main" = {
        width = "100%";
        height = 24;
        background = "#2e3440";
        foreground = "#d8dee9";
        
        font-0 = "JetBrainsMono Nerd Font:size=10;2";
        font-1 = "JetBrainsMono Nerd Font:size=12;3";
        
        modules-left = "xworkspaces xwindow";
        modules-center = "date";
        modules-right = "pulseaudio cpu memory filesystem wlan eth";
        
        padding-right = 1;
        module-margin = 1;
        
        tray-position = "right";
        tray-padding = 2;
        
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
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
      
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
        label-foreground = "#8fbcbb";
      };
      
      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%a %b %d";
        time = "%H:%M";
        label = "%date% %time%";
        
        # Click to open Emacs org-agenda
        click-left = "emacs --eval '(org-agenda-list)' &";
      };
      
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        
        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%percentage%%";
        
        format-muted = "<label-muted>";
        format-muted-prefix = "󰖁 ";
        format-muted-prefix-foreground = "#bf616a";
        label-muted = "muted";
        label-muted-foreground = "#4c566a";
        
        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
        ramp-volume-foreground = "#88c0d0";
        
        # Click to open volume control
        click-right = "pavucontrol &";
      };
      
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#88c0d0";
        label = "%percentage:2%%";
        
        # Click to open btop
        click-left = "alacritty -e btop &";
      };
      
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#88c0d0";
        label = "%percentage_used%%";
        
        # Click to open btop
        click-left = "alacritty -e btop &";
      };
      
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 30;
        format-mounted-prefix = " ";
        format-mounted-prefix-foreground = "#88c0d0";
        label-mounted = "%used%/%total%";
        
        # Click to open ranger
        click-left = "alacritty -e ranger &";
      };
      
      "module/wlan" = {
        type = "internal/network";
        interface = "wlp13s0";
        interval = 3;
        format-connected = "<label-connected>";
        format-connected-prefix = "󰖩 ";
        format-connected-prefix-foreground = "#88c0d0";
        label-connected = "%downspeed%  %upspeed%";
        format-disconnected = "";
        
        # Click to open network manager
        click-left = "alacritty -e nmtui &";
      };
      
      "module/eth" = {
        type = "internal/network";
        interface = "enp12s0";
        interval = 3;
        format-connected = "<label-connected>";
        format-connected-prefix = "󰈀 ";
        format-connected-prefix-foreground = "#88c0d0";
        label-connected = "%downspeed%  %upspeed%";
        format-disconnected = "";
        
        # Click to open network manager
        click-left = "alacritty -e nmtui &";
      };
    };
  };
}
