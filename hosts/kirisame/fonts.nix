{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # General fonts.
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # Japanese fonts.
    ipafont
    kochi-substitute

    # Nerd fonts.
    (nerdfonts.override { fonts = [ "Terminus" "Gohu" "Ubuntu" "UbuntuMono" ]; })
    monocraft
    fixedsys-nerd-font
    scientifica-nerd-font
  ];
}
