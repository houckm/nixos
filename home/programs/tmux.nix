{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    
    # Enable mouse support
    mouse = true;
    
    # Escape time for vim
    escapeTime = 0;
    
    # Key bindings
    keyMode = "vi";
    
    # Custom key bindings
    extraConfig = ''
      # Renumber windows when one is closed
      set -g renumber-windows on
      
      # Enable focus events
      set -g focus-events on
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Remap prefix from 'C-b' to 'C-a'
      # unbind C-b
      # set-option -g prefix C-a
      # bind-key C-a send-prefix
      
      # Split panes using different keys (since | is problematic)
      bind % split-window -h -c "#{pane_current_path}"  # vertical split
      bind '"' split-window -v -c "#{pane_current_path}"  # horizontal split
      
      # Create new window with current path
      bind c new-window -c "#{pane_current_path}"
      
      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      
      # Vim-like pane switching
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Enable vi mode
      setw -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      
      # Quick reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      
      # Clear screen and history
      bind -n C-l send-keys C-l \; run 'sleep 0.1' \; clear-history
      
      # Session management
      bind-key S new-session
      bind-key L list-sessions
      
      # Window management
      bind-key w list-windows
      bind-key , command-prompt -I "#W" "rename-window '%%'"
      
      # Enable 24-bit color (true color) support
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",alacritty:Tc"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours
      
      # Nord Theme Colors
      set -g status-style "bg=#3b4252,fg=#eceff4"
      set -g window-status-style "bg=#3b4252,fg=#81a1c1"
      set -g window-status-current-style "bg=#81a1c1,fg=#2e3440,bold"
      set -g window-status-activity-style "bg=#bf616a,fg=#2e3440"
      set -g pane-border-style "fg=#4c566a"
      set -g pane-active-border-style "fg=#88c0d0"
      set -g message-style "bg=#5e81ac,fg=#eceff4"
      set -g message-command-style "bg=#5e81ac,fg=#eceff4"
      set -g mode-style "bg=#81a1c1,fg=#2e3440"
      
      # Status bar configuration
      set -g status-interval 5
      set -g status-left-length 50
      set -g status-right-length 50
      
      # Status bar content
      set -g status-left "#[bg=#88c0d0,fg=#2e3440,bold] #S #[bg=#3b4252] "
      set -g status-right "#[fg=#81a1c1]%H:%M #[fg=#88c0d0]%d-%b #[bg=#88c0d0,fg=#2e3440,bold] #h "
      
      # Window status format
      set -g window-status-format " #I:#W "
      set -g window-status-current-format " #I:#W "
      
      # Activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off
      
      # Don't exit when last session is closed
      set-option -g exit-empty on
    '';
    
    # Plugins using home-manager's tmux plugin support
    plugins = with pkgs.tmuxPlugins; [
      # Better defaults
      sensible
      
      # Save and restore tmux sessions
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'ssh psql mysql sqlite3'
        '';
      }
      
      # Automatic saving of sessions
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '15'
        '';
      }
      
      # Better copy/paste
      yank
      
      # Better pane management
      # pain-control
      
      # Prefix highlight
      {
        plugin = prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_fg '#2e3440'
          set -g @prefix_highlight_bg '#88c0d0'
          set -g @prefix_highlight_show_copy_mode 'on'
          set -g @prefix_highlight_copy_mode_attr 'fg=#2e3440,bg=#a3be8c,bold'
        '';
      }
      
      # Session manager
      {
        plugin = tmux-fzf;
        extraConfig = ''
          TMUX_FZF_LAUNCH_KEY="C-f"
        '';
      }
    ];
  };
  
  # Additional tmux-related packages
  home.packages = with pkgs; [
    tmuxinator    # Session manager
  ];
  
  # Tmuxinator configuration directory
  home.file.".tmuxinator" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/tmuxinator";
    recursive = true;
  };
}
