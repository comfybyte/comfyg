{ stdenv, fetchurl, ... }:

stdenv.mkDerivation rec {
  pname = "wine-lutris-ge-lol";
  version = "8.7-1";
  tag = "8.7-GE-1-LoL";

  src = fetchurl {
    url = "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/${tag}/${pname}-${version}-x86_64.tar.xz";
    sha256 = "ZrKnoXUIDYFJnQSnBrUKnZP0C9Ts/4jfSVYgJvS9yrw=";
  };

  buildCommand = ''
    mkdir -p $out
    tar -C $out --strip=1 -x -f $src
  '';
}
