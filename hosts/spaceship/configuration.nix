# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "spaceship"; # Define your hostname.

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Optional: Enable JACK applications
    jack.enable = true;
  };

  # USB audio interface support
  boot.kernelModules = [ "snd-usb-audio" ];


  services.ollama = {
    enable = true;
    acceleration = "cuda";  # You have NVIDIA GPU
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  # Enable Bluetooth manager service
  services.blueman.enable = true;

  # mullvad-vpn
  services.mullvad-vpn.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
  };
  
  # Optional: Enable GameMode for better performance
  programs.gamemode.enable = true;

  # nvidia 
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
  # Modesetting is required.
    modesetting.enable = true;

  # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  # Enable this if you have graphical corruption issues or application crashes after waking
  # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  # of just the bare essentials.
    powerManagement.enable = false;

  # Fine-grained power management. Turns off GPU when not in use.
  # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

  # Use the NVidia open source kernel module (not to be confused with the
  # independent nouveau driver).
  # Support is limited to the Turing and later architectures. Full list of 
  # supported GPUs is at: 
  # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  # Only available from driver 515.43.04+
  # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

  # Enable the Nvidia settings menu,
  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # package = config.boot.kernelPackages.nvidiaPackages.stable;
 };


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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

  services.xserver.displayManager.lightdm.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hunter = {
    isNormalUser = true;
    description = "Hunter Houck";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  programs.zsh.enable = true;

  programs.git.enable = true;


  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # Core utilities
     wget
     git
     curl
     htop
     tree
     unzip

     # System tools
     lshw
     usbutils
     pciutils
     pavucontrol

     # File Management
     rsync
     fd
     ripgrep

     # Development
     gnumake
     gcc

     # steam
     protonup-qt

     obs-studio

     # Text Processing
     jq
     yq-go

  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Keep system-level SSH security in configuration.nix
  security.pam.sshAgentAuth.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5901 5902 8080];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
