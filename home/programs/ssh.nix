{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    
    # SSH agent configuration
    # startAgent = true;
    
    # Global SSH client configuration
    extraConfig = ''
      # Keep connections alive
      ServerAliveInterval 60
      ServerAliveCountMax 10
      
      # Connection multiplexing (faster subsequent connections)
      ControlMaster auto
      ControlPath ~/.ssh/sockets/%r@%h:%p
      ControlPersist 10m
      
      # Security settings
      HashKnownHosts yes
      VerifyHostKeyDNS yes
      
      # Key preferences (prioritize Ed25519)
      PubkeyAcceptedAlgorithms +ssh-ed25519,rsa-sha2-512,rsa-sha2-256
    '';
    
    # Host-specific configurations
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "hunter";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      
      # Add other hosts as needed
      # "myserver" = {
      #   hostname = "example.com";
      #   user = "hunter";
      #   port = 2222;
      #   identityFile = "~/.ssh/id_ed25519";
      # };
    };
  };
  
  # SSH agent service configuration
  services.ssh-agent = {
    enable = true;
  };
  
  # Create socket directory for connection multiplexing
  home.file.".ssh/sockets/.keep".text = "";
  
  # Ensure proper SSH directory permissions
  home.file.".ssh/config".target = ".ssh/config";
}
