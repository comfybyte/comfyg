{ stdenv, fetchzip, pkgs }:
stdenv.mkDerivation rec {
  pname = "monaspace-krypton-nerd-font";
  version = "1.000";

  src = fetchzip {
    url =
      "https://github.com/githubnext/monaspace/releases/download/v${version}/monaspace-v${version}.zip";
    sha256 = "sha256-H8NOS+pVkrY9DofuJhPR2OlzkF4fMdmP2zfDBfrk83A=";
    stripRoot = false;
  };
  nativeBuildInputs = [ pkgs.nerd-font-patcher ];
  buildPhase = ''
    mkdir -p $out/share/fonts/opentype

    fonts="$src/monaspace-v1.000/fonts/otf"
    for file in $(ls $fonts/*Krypton*); do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $file;
    done
  '';
}
