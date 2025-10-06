{ pkgs, ... }:

{
  home.packages = [ pkgs.open-webui ];
  
  systemd.user.services.open-webui = {
    Unit = {
      Description = "Open WebUI";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.open-webui}/bin/open-webui serve --host 0.0.0.0 --port 8080"; 
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
