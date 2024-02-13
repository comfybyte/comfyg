{
  description = "A comfy Rust project flake template.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # See [`https://crane.dev/API.html`]
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, flake-utils, rust-overlay, crane, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pname = "simple-rust";
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile
          ./rust-toolchain.toml;
        craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;
        src = craneLib.cleanCargoSource (craneLib.path ./.);
        commonArgs = {
          inherit pname src;
          strictDeps = true;
          version = "0.1";
        };
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        bin = craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });
      in {
        devShells.default = craneLib.devShell {
          inputsFrom = [ bin ];
          packages = with pkgs; [ just bacon ];
        };

        # `nix build`.
        packages = {
          inherit bin;
          default = bin;
        };

        # `nix run`.
        apps.default = flake-utils.lib.mkApp { drv = bin; };

        # `nix flake check`.
        checks = {
          inherit bin;
          clippy = craneLib.cargoClippy (commonArgs // {
            inherit cargoArtifacts;
          });
          fmt = craneLib.cargoFmt {
            inherit src;
          };
        };
      });
}
