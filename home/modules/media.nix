{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
    obs-studio
    discord
    qbittorrent
  ];
}
