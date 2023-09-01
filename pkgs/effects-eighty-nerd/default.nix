{ lib, pkgs, stdenv, fetchzip }:

stdenv.mkDerivation {
  pname = "effects-eighty-nerd";
  version = "2017-08-06b";

  src = fetchzip {
    url = "https://fontlibrary.org/assets/downloads/effects-eighty/3b1759f5caa1e5d5bb2e9cda6850f6b0/effects-eighty.zip";
    sha256 = "1lk28aq2nqnlqywrz96vc0fx5l0pw3vgdf48zlcay3jj0cga6hyf";
  };

  nativeBuildInputs = [ pkgs.nerd-font-patcher ];

  buildPhase = ''
   mkdir -p $out/share/fonts/truetype
   for file in $(ls $src | grep .ttf); do nerd-font-patcher -c -q --out $out/share/fonts/truetype $file; done;
  '';

  meta = with lib; {
    description = "Effects Eighty is an homage to the dot-matrix printers of the 1980s. It is a very faithful reproduction of the output of one of that class of printers.";
    homepage = "https://fontlibrary.org/en/font/effects-eighty";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
