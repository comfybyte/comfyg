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

    rust-overlay.url = "github:oxalica/rust-overlay";

    nixpkgs-wl = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home, hyprland, nixvim, rust-overlay, nixpkgs-wl, ... }@inputs:
  let specialPkgs = system: callPackage: pkgsi686Linux: 
    (import ./pkgs { inherit callPackage pkgsi686Linux; });
  in {
    nixosConfigurations = {
      kirisame = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs nixvim rust-overlay; };
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

            nixpkgs.overlays = [ 
              rust-overlay.overlays.default 
              nixpkgs-wl.overlay
              # TODO: Move this to a separate place as it (eventually) grows.
              (final: prev: specialPkgs system prev.callPackage prev.pkgsi686Linux)
            ];
          })
        ];
      };
    };
  };
}
