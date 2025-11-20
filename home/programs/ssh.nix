{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # SSH agent configuration
    # startAgent = true;

    # Host-specific configurations
    matchBlocks = {
      # Default host configuration (applies to all hosts)
      "*" = {
        # Keep connections alive
        serverAliveInterval = 60;
        serverAliveCountMax = 10;

        # Connection multiplexing (faster subsequent connections)
        controlMaster = "auto";
        controlPath = "~/.ssh/sockets/%r@%h:%p";
        controlPersist = "10m";

        # Security settings
        hashKnownHosts = true;

        extraOptions = {
          VerifyHostKeyDNS = "yes";
          PubkeyAcceptedAlgorithms = "+ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
        };
      };

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
