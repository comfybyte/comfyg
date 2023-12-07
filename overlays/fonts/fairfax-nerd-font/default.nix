{ stdenv, fetchurl, pkgs }:
stdenv.mkDerivation rec {
  pname = "fairfax-nerd-font";
  version = "2023-10";

  src = fetchurl {
    url =
      "https://github.com/kreativekorp/open-relay/releases/download/${version}/Fairfax.zip";
    sha256 = "sha256-mOoxH5HlZN2+p4JtyWwLxgbO1iKl6t0Unq75Arw2jH0=";
  };
  dontUnpack = true;
  nativeBuildInputs = with pkgs; [ nerd-font-patcher unzip ];
  buildPhase = ''
    mkdir -p $out/unpack
    mkdir -p $out/share/fonts/truetype
    unzip -d $out/unpack $src
    for file in $(ls $out/unpack | grep .ttf); do 
      nerd-font-patcher -c -q --out $out/share/fonts/truetype "$out/unpack/$file"
    done
  '';
}
