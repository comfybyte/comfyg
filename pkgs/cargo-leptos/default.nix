{ rustPlatform, fetchFromGitHub, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-leptos";
  version = "0.1.11";

  src = fetchFromGitHub {
    owner = "leptos-rs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-hZevu2lwyYFenABu1uV7/mZc7SXfLzR6Pdmc3zHJ2vw=";
  };

  # Fixes some issues with Cargo.lock using git deps and fixed-output derivations.
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "leptos_hot_reload-0.3.0" = "sha256-Pl3nZaz5r5ZFagytLMczIyXEWQ6AFLb3+TrI/6Sevig=";
    };
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  # Avoids downloading dependencies on its own.
  # (See https://github.com/leptos-rs/cargo-leptos#dependencies)
  buildFeatures = [ "no_downloads" ];

  # Checks fail to query crates.io.
  doCheck = false;

  meta = {
    description = "Build tool for Leptos (Rust).";
    homepage = "https://github.com/leptos-rs/cargo-leptos";
  };
}
