{ rustPlatform, fetchFromGitHub, libevdev, pkg-config, lib }:
rustPlatform.buildRustPackage rec {
  pname = "evremap";
  version = "2023-07-25"; # Commit date since there's no versioning.

  src = fetchFromGitHub {
    owner = "wez";
    repo = pname;
    rev = "master";
    hash = "sha256-FRUJ2n6+/7xLHVFTC+iSaigwhy386jXccukoMiRD+bw=";
  };

  cargoHash = "sha256-RpdGgmOCQgrPIwkiYXs7w9r3zSCuC+DDbQXOujsxWaI=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libevdev ];

  meta = with lib; {
    description = "A keyboard input remapper for Linux/Wayland systems.";
    homepage = "https://github.com/wez/evremap";
    license = licenses.mit;
  };
}
