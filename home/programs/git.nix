{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    settings = {
      # Your identity
      user = {
        name = "Hunter Houck";
        email = "hhouck.linux@gmail.com";
      };
      
      # Default branch name
      init.defaultBranch = "main";
      
      # Better diff algorithm
      diff.algorithm = "patience";
      
      # Push configuration
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      
      # Pull configuration (avoid merge commits)
      pull.rebase = true;
      
      # Better merge conflict resolution
      merge.conflictstyle = "diff3";
      
      # Colors
      color.ui = true;
      
      # Editor
      core.editor = "nvim";
      
      # Better logging
      log.decorate = "short";
      
      # Submodule settings
      submodule.recurse = true;
      
      # Security
      transfer.fsckobjects = true;
      fetch.fsckobjects = true;
      receive.fsckObjects = true;
      
      # Aliases
      alias = {
        # Status and info
        st = "status";
        s = "status --short";
        
        # Branching
        br = "branch";
        co = "checkout";
        sw = "switch";
        
        # Commits
        ci = "commit";
        cm = "commit -m";
        ca = "commit --amend";
        
        # Logs
        lg = "log --oneline --graph --decorate";
        lga = "log --oneline --graph --decorate --all";
        last = "log -1 HEAD";
        
        # Diffs
        df = "diff";
        dc = "diff --cached";
        
        # Remote operations
        f = "fetch";
        fa = "fetch --all";
        p = "push";
        pl = "pull";
        
        # Utilities
        unstage = "reset HEAD --";
        discard = "checkout --";
        
        # Show current branch
        current = "branch --show-current";
        
        # Clean up merged branches
        cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d";
      };
    };
    
    # Ignore patterns (global gitignore)
    ignores = [
      # OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      
      # Editor files
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/"
      ".idea/"
      
      # Build artifacts
      "*.o"
      "*.so"
      "*.dylib"
      "*.exe"
      "result"
      "result-*"
      
      # Logs
      "*.log"
      
      # Temporary files
      "*.tmp"
      "*.temp"
      ".cache/"
      
      # Environment files
      ".env"
      ".env.local"
      
      # Dependencies
      "node_modules/"
      "__pycache__/"
      "*.pyc"
    ];
    
  };
  
  # Additional Git tools
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    gitui
    gh
  ];
}
