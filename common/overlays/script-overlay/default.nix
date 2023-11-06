final: prev:
with prev; {
  sshot = callPackage ./sshot { };
  retag = callPackage ./retag { };
}
