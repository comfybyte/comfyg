{ callPackage, pkgsi686Linux }:

{
  wine-lutris-ge-lol = pkgsi686Linux.callPackage ./wine-lutris-ge-lol {};
  effects-eighty-nerd = callPackage ./effects-eighty-nerd {};
  intel-one-mono-nerd = callPackage ./intel-one-mono-nerd {};
}
