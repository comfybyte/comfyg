{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "trunk";
  version = "0.17.5";

  src = fetchFromGitHub {
    owner = "thedodd";
    repo = "trunk";
    rev = "v${version}";
    sha256 = "sha256-CRlSHOT4hMblfaTcX9Y2BN52RYjDSLaanoxOMccff40=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  # It's 2 minor versions behind for some reason
  cargoPatches = [ ./bump_lockfile.patch ];

  # Throws with permission errors
  checkFlags = [ "--skip=tools::tests::download_and_install_binaries" ];

  cargoSha256 = "sha256-L8a+7/diZvRe3+jTMwKyDfolBIQK6fwXoEkQIc+ym8A=";

  meta = {
    homepage = "https://github.com/thedodd/trunk";
    description = "Build, bundle & ship your Rust WASM application to the web.";
  };
}
