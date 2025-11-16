{ config, pkgs, ... }:

{
  # Basic monitoring setup
  # This provides a foundation for server monitoring

  environment.systemPackages = with pkgs; [
    htop
    btop
    iotop
    ncdu
  ];

  # Example Prometheus + Grafana setup
  # Uncomment and configure when ready to use full monitoring stack

  # services.prometheus = {
  #   enable = true;
  #   port = 9090;
  #
  #   exporters = {
  #     node = {
  #       enable = true;
  #       enabledCollectors = [ "systemd" ];
  #       port = 9100;
  #     };
  #   };
  #
  #   scrapeConfigs = [
  #     {
  #       job_name = "homeserver";
  #       static_configs = [{
  #         targets = [ "localhost:9100" ];
  #       }];
  #     }
  #   ];
  # };

  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       http_addr = "0.0.0.0";
  #       http_port = 3000;
  #     };
  #   };
  # };

  # networking.firewall.allowedTCPPorts = [ 9090 3000 ];
}
