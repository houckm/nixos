{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      # Window configuration
      window = {
        padding = {
          x = 6;
          y = 6;
        };
        decorations = "full";
        opacity = 0.95;
        blur = true;
      };

      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # Font configuration
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold Italic";
        };
        size = 12.0;
      };

      # Nord Color Scheme
      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5aaad";
        };
        
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
        };
        
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };

      # Key bindings
      keyboard.bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
        { key = "Equals"; mods = "Control"; action = "IncreaseFontSize"; }
        { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
        { key = "N"; mods = "Control|Shift"; action = "SpawnNewInstance"; }
      ];

      # Mouse
      mouse = {
        hide_when_typing = true;
      };

      # Terminal
      env = {
        TERM = "alacritty";
      };

      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        vi_mode_style = {
          shape = "Block";
          blinking = "Off";
        };
      };
    };
  };
}
