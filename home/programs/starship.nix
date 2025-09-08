{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      
      # Prompt character formatting
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
        vicmd_symbol = "[V](bold green)";
      };
      
      # Command duration
      cmd_duration = {
        min_time = 2000;
        format = "took [$duration](bold yellow)";
      };
      
      # Directory display
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        style = "bold blue";
        repo_root_style = "bold green";
        read_only = " 🔒";
      };
      
      # Git configuration
      git_branch = {
        symbol = " ";
        style = "bold purple";
      };
      
      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold red";
      };
      
      # Nix shell indicator
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };
      
      # Language versions
      golang = { 
        format = "via [🏎️ $version](bold cyan) "; 
      };
      
      python = { 
        format = "via [🐍 $version](bold green) ";
        python_binary = ["python3" "python"];
      };
      
      rust = { 
        format = "via [🦀 $version](bold red) "; 
      };
      
      nodejs = { 
        format = "via [⬢ $version](bold green) "; 
      };
      
      # Additional useful modules
      package = {
        format = "via [📦 $version](208 bold) ";
      };
      
      docker_context = {
        format = "via [🐳 $context](blue bold)";
      };
      
      kubernetes = {
        format = "via [⛵ $context](blue bold) ";
        disabled = false;
      };
      
      # Time (optional - shows current time)
      time = {
        disabled = true;  # Set to false if you want time shown
        format = "🕙[$time]($style) ";
        time_format = "%T";
        style = "bright-white";
      };
      
      # Battery indicator (useful for laptops)
      battery = {
        full_symbol = "🔋";
        charging_symbol = "⚡️";
        discharging_symbol = "💀";
        
        display = [
          {
            threshold = 15;
            style = "bold red";
          }
          {
            threshold = 50;
            style = "bold yellow";
          }
        ];
      };
    };
  };
}
