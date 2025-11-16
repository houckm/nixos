{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./nix-settings.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core system packages shared across all hosts
  environment.systemPackages = with pkgs; [
    # Core utilities
    wget
    git
    curl
    htop
    tree
    unzip

    # File Management
    rsync
    fd
    ripgrep

    # Text Processing
    jq
    yq-go
  ];
}
