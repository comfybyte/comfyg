{ stdenv, fetchurl, pkgs }:
stdenv.mkDerivation {
  pname = "bedstead-nerd-font";
  version = "2020-06-22";

  src = fetchurl {
    url =
      "https://fontlibrary.org/assets/downloads/bedstead/962e0e3f7c6c4de53e519e12b097b677/bedstead.zip";
    sha256 = "sha256-Y6B9RhMd7bHTI9iadlHS4g1I/yqDrM4/TMDZJRsKQfk=";
  };
  dontUnpack = true;
  nativeBuildInputs = with pkgs; [ nerd-font-patcher unzip ];
  buildPhase = ''
    mkdir -p $out/unpacked
    unzip $src -d $out/unpacked
    mkdir -p $out/share/fonts/opentype
    for file in $(ls $out/unpacked/bedstead-002.002/*.otf); do nerd-font-patcher -c -q --out $out/share/fonts/opentype $file; done;
    rm -r $out/unpacked
  '';
}
