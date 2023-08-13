{ stdenv, fetchzip, pkgs, lib }:

stdenv.mkDerivation rec {
  pname = "intel-one-mono-nerd";
  version = "1.2.1";

  src = fetchzip {
    url = "https://github.com/intel/intel-one-mono/releases/download/V${version}/ttf.zip";
    sha256 = "Yk6fcMnm9gJRRvwX/jBDj11NZc3aaxgeQJyEgdKnbMQ=";
  };

  nativeBuildInputs = [ pkgs.nerd-font-patcher ];

  buildPhase = ''
   mkdir -p $out/share/fonts/truetype
   for file in $(ls $src | grep .ttf); do nerd-font-patcher --out $out/share/fonts/truetype $file; done;
  '';

  meta = with lib; {
    description = "Intel One Mono Typeface.";
    homepage = "https://github.com/intel/intel-one-mono";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
