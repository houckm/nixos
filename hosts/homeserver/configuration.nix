{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    # Common modules
    ../../modules/common

    # Service modules
    ../../modules/services/ssh.nix
    ./services/docker.nix
    ./services/backup.nix
    ./services/monitoring.nix
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

  # Override SSH settings for homeserver (disable password auth)
  services.openssh.settings.PasswordAuthentication = false;

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

  # Homeserver-specific packages (common packages are in modules/common)
  environment.systemPackages = with pkgs; [
    vim
    nano
    tmux
    ncdu
    zip
    lsof
    strace
    nmap
    iperf3
    tcpdump
    iotop
  ];

  system.stateVersion = "25.05";
}
