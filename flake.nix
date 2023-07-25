{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/2bbe3aa122f242f43ac31fb85a39da48db69ca79";
  };

  outputs = { self, nixpkgs, home, hyprland, nixvim, ... }@inputs: {
    nixosConfigurations = {
      kirisame = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs nixvim; };
        modules = [
          ./systems/kirisame
          home.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.maya = import ./home;
          }
          ({ pkgs, ... }@args: {
            home-manager.users.maya = nixpkgs.lib.mkMerge [
              nixvim.homeManagerModules.nixvim
              (import ./home/nixvim.nix pkgs)
              hyprland.homeManagerModules.default
            ];
          })
        ];
      };
    };
  };
}
