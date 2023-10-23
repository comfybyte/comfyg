{
  description = "My Nix flake configurations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/Hyprland";
    xyprland.url = "github:comfybyte/xyprland/main";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url =
        "github:nix-community/nixvim/05b77732e3babaa95d73cbffca83029784a64cdd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wl = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    inotify.url = "github:mikesart/inotify-info";
  };

  outputs =
    { self, nixpkgs, home, hyprland, nixvim, nixpkgs-wl, agenix, ... }@inputs:
    let
      mkSystem = extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
      overlays = {
        font = (import ./common/overlays/font-overlay);
        script = (import ./common/overlays/script-overlay);
      };
    };

  nixConfig = {
    connect-timeout = 20;
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
