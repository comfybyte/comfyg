{ stdenv, fetchurl, pkgs }:
stdenv.mkDerivation rec {
  pname = "fixedsys-nerd-font";
  version = "3.02.9";

  src = fetchurl {
    url =
      "https://github.com/kika/fixedsys/releases/download/v${version}/FSEX302.ttf";
    sha256 = "sha256-s/jh2pe3IqQkd+6acvlT6yvHwhld9eK2t9R4HdP4ssw=";
  };
  dontUnpack = true;
  nativeBuildInputs = [ pkgs.nerd-font-patcher ];
  buildPhase = ''
    mkdir -p $out/share/fonts/truetype
    nerd-font-patcher -c -q --out $out/share/fonts/truetype $src
  '';
}
