outputs = { nixpkgs, home-manager, claude-code, ... }: {
  nixosConfigurations.spaceship = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./hosts/spaceship/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.hunter = import ./home/home.nix;
        nixpkgs.overlays = [ claude-code.overlays.default ];
      }
    ];
  };
<<<<<<< HEAD
  
  nixosConfigurations.homeserver = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./hosts/homeserver/configuration.nix
    ];
||||||| ed349bf (homeserver configuration.nix)

  outputs = { nixpkgs, home-manager, claude-code, ... }: {
    nixosConfigurations.spaceship = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/spaceship/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hunter = import ./home/home.nix;
          nixpkgs.overlays = [ claude-code.overlays.default ];
        }
      ];
    };
    homeserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/homeserver/configuration.nix
=======

  outputs = { nixpkgs, home-manager, claude-code, ... }: {
    nixosConfigurations.spaceship = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/spaceship/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hunter = import ./home/home.nix;
          nixpkgs.overlays = [ claude-code.overlays.default ];
        }
      ];
    };
>>>>>>> parent of ed349bf (homeserver configuration.nix)
  };
};
