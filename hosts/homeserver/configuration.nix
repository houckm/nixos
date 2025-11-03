{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "homeserver";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/Chicago";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # SSH - critical for remote access
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # User account
  users.users.hunter = {
    isNormalUser = true;
    description = "Hunter Houck";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIClIg1RpM0C1yrFeP2avju5rYMmmYIdRkE0WwRw3Rah hhouck.linux@gmail.com"
    ];
  };


  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];  # SSH
  };

  # Docker for containers
  virtualisation.docker.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    wget
    curl
    tmux
  ];

  # Flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
