{ stdenv, fetchzip, pkgs }:
stdenv.mkDerivation {
  pname = "lotion-nerd-font";
  version = "28-08-2019";

  src = fetchzip {
    url =
      "https://gitlab.com/nefertiti/lotion-dist/-/archive/master/lotion-dist-master.zip";
    sha256 = "sha256-Jn9WM91RstzutRN68AMdzb4OYWUM4bq+ZSlwN+jQ5g4=";
  };
  nativeBuildInputs = [ pkgs.nerd-font-patcher ];
  buildPhase = ''
    mkdir -p $out/share/fonts/truetype
    for file in $(ls $src/ttf | grep .ttf); do nerd-font-patcher -c -q --out $out/share/fonts/truetype $src/ttf/$file; done;
  '';
}
