# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Common modules
      ../../modules/common

      # Hardware modules
      ../../modules/hardware/nvidia.nix
      ../../modules/hardware/audio.nix
      ../../modules/hardware/bluetooth.nix

      # Service modules
      ../../modules/services/ssh.nix
      ../../modules/services/gaming.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "spaceship"; # Define your hostname.

  networking.extraHosts = ''
  192.168.122.113 rhcsa1.example.local rhcsa1
  192.168.122.114 rhcsa2.example.local rhcsa2
  '';

  virtualisation.docker.enable = true;


  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver = {
  enable = true;
  windowManager.xmonad = {
  	enable = true;
	  enableContribAndExtras = true;  # Important for most configurations
    config = null;  # We'll manage config through home-manager
    };
  };
  services.displayManager = {
  defaultSession = "none+xmonad";
  };

  services.displayManager.sddm = {
  enable = true;
  theme = "astronaut";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hunter = {
    isNormalUser = true;
    description = "Hunter Houck";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  programs.zsh.enable = true;

  programs.git.enable = true;


  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Vagrant configuration
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
  };

  # Spaceship-specific packages (common packages are in modules/common)
  environment.systemPackages = with pkgs; [
     sddm-astronaut
     lshw
     usbutils
     pciutils
     pavucontrol
     gnumake

     # Virtualization tools
     vagrant
     qemu
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5901 5902 8080 3000];

  system.stateVersion = "25.05";

}
