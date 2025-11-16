{ config, pkgs, ... }:

{
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
  };

  # Optional: Enable GameMode for better performance
  programs.gamemode.enable = true;

  # System packages for gaming
  environment.systemPackages = with pkgs; [
    protonup-qt
  ];
}
