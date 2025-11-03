{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./services/docker.nix
  ];

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
# Networking
  networking = {
    hostName = "homeserver";
    networkmanager.enable = true;
    
    interfaces.enp0s25 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.1.103";
        prefixLength = 24;
      }];
    };
    
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" "8.8.8.8" ];
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # Allow wheel group to use sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Localization
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Users
  users.users.hunter = {
    isNormalUser = true;
    description = "Hunter Houck";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIClIg1RpM0C1yrFeP2avju5rYMmmYIdRkE0WwRw3Rah hhouck.linux@gmail.com"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
  vim
  nano  # For users less comfortable with vim
  
  # Version control
  git
  
  # System monitoring
  htop
  btop  # Modern htop alternative
  iotop  # Disk I/O monitoring
  
  # Network tools
  wget
  curl
  nmap  # Network scanning
  iperf3  # Network performance testing
  tcpdump  # Packet capture
  
  # System utilities
  tmux
  rsync  # File syncing
  tree  # Directory visualization
  ncdu  # Disk usage analyzer
  
  # File utilities
  unzip
  zip
  
  # Diagnostics
  lsof  # List open files
  strace  # System call tracing
  ];  

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "25.05";
}
