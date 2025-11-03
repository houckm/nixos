{ config, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Add user to docker group
  users.users.hunter.extraGroups = [ "docker" ];

  # Docker Compose for manual stacks
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Declarative containers
  virtualisation.oci-containers = {
    backend = "docker";
    
    containers = {
      portainer = {
        image = "portainer/portainer-ce:latest";
        ports = [
          "9443:9443"
          "8000:8000"
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
        autoStart = true;
      };
    };
  };

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 9443 8000 ];
}
