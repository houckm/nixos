{ pkgs, ... }:

{
  home.packages = [ pkgs.open-webui ];
  
  systemd.user.services.open-webui = {
    Unit = {
      Description = "Open WebUI";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.open-webui}/bin/open-webui serve";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
