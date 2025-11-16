{ config, pkgs, ... }:

{
  # Audio with Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # USB audio interface support
  boot.kernelModules = [ "snd-usb-audio" ];
}
