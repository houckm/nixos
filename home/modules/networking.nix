{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nmap
    tcpdump
    wireshark
    dig
    netcat-gnu
    iperf3
  ];
}
