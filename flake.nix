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

    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgs-wl = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";

    rust-overlay.url = "github:oxalica/rust-overlay";

    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, home, hyprland, nixvim, rust-overlay, nixpkgs-wl
    , nix-gaming, agenix, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = ({ pkgs, ... }: {
        nixpkgs.overlays = [
          rust-overlay.overlays.default
          nixpkgs-wl.overlay
          (import ./pkgs pkgs)
        ];
      });
    in {
      nixosConfigurations = {
        kirisame = nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./systems/kirisame
            home.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maya = import ./home;
              home-manager.extraSpecialArgs = { inherit inputs system; };
            }
            agenix.nixosModules.default
            overlays
          ];
        };
      };
    };

  nixConfig = {
    connect-timeout = 20; # seconds.
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

}
