{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Pinned rev of Nixpkgs before a lockfile update, in case something breaks.
    pinned.url =
      "github:nixos/nixpkgs/a08d6979dd7c82c4cef0dcc6ac45ab16051c1169";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wl = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    inotify.url = "github:mikesart/inotify-info";
    hyprland.url = "github:hyprwm/Hyprland";
    xyprland = {
      url = "github:comfybyte/xyprland";
      inputs.hyprland.follows = "hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home, nixvim, nixpkgs-wl, agenix, ... }@inputs:
    let
      mkSystem = extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system;
            pinned = import inputs.pinned {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            home.nixosModules.home-manager
            agenix.nixosModules.default
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ nixpkgs-wl.overlay ]
                ++ builtins.attrValues self.overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs system; };

            })
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = { kirisame = mkSystem [ ./hosts/kirisame ]; };
      overlays = import ./overlays;
    };

  nixConfig = rec {
    connect-timeout = 20;
    substituters = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-users = [ "@wheel" ];
    trusted-substituters = substituters;
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
