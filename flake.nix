{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    # Home Manager.
    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nix-configured Neovim.
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # extra gaming packages.
    gaming.url = "github:fufexan/nix-gaming";
    # extra Wayland packages.
    nixpkgs-wl = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # formatting.
    treefmt-nix.url = "github:numtide/treefmt-nix";
    # rolling-release Hyprland package and configuration layer.
    hyprland.url = "github:hyprwm/Hyprland";
    xyprland = {
      url = "github:comfybyte/xyprland";
      inputs.hyprland.follows = "hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, systems, nixpkgs, home, nixvim, nixpkgs-wl
    , treefmt-nix, flake-utils, ... }:
    let
      # import stable nixpkgs for `system`.
      stableFor = system:
        import inputs.stable {
          inherit system;
          config.allowUnfree = true;
        };
      # create a list of Home Manager modules where `specialArgs` are available.
      mkHomeModules = specialArgs: [
        home.nixosModules.home-manager
        ({ pkgs, ... }: {
          home-manager = {
            extraSpecialArgs = specialArgs;
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        })
      ];
      # a module with all overlays applied.
      overlayModule = ({ pkgs, ... }: {
        nixpkgs.overlays = [ nixpkgs-wl.overlay ]
          ++ builtins.attrValues self.overlays;
      });
      # make a nixos system with `extraModules`.
      mkSystem = system: extraModules:
        let
          stable = stableFor system;
          # args shared between both Home Manager and NixOS contexts.
          specialArgs = { inherit inputs system stable; };
        in nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = builtins.concatLists [
            [ overlayModule ]
            (mkHomeModules specialArgs)
            extraModules
          ];
        };
      eachSystem = f:
        nixpkgs.lib.genAttrs (import systems)
        (system: f nixpkgs.legacyPackages.${system});
      treefmtEval =
        eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in {
      nixosConfigurations = {
        kirisame = mkSystem "x86_64-linux" [ ./hosts/kirisame ];
      };
      overlays = import ./overlays;
      homeManagerModules = { parts = import ./common/parts; };
      formatter =
        eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      templates = {
        simple-rust = {
          path = ./templates/simple-rust;
          description =
            "Barebones nightly Rust project template. (with clippy and bacon)";
        };
      };
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
    trusted-substituters = substituters;
    allowed-users = [ "@wheel" ];
    trusted-users = allowed-users;
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
