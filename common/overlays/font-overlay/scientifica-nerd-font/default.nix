{ stdenv, fetchzip, pkgs }:
stdenv.mkDerivation rec {
  pname = "scientifica-nerd-font";
  version = "2.3";

  src = fetchzip {
    url =
      "https://github.com/nerdypepper/scientifica/releases/download/v${version}/scientifica.tar";
    sha256 = "sha256-1+dL7wQp+y3U/PDMJQaYeRzvOoNWgHoeja4E9AMccnM=";
  };
  nativeBuildInputs = [ pkgs.nerd-font-patcher ];
  buildPhase = builtins.readFile ./build.sh;
}
