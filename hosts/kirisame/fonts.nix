{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    # General fonts.
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # Japanese fonts.
    ipafont
    kochi-substitute

    # Nerd fonts.
    (nerdfonts.override { fonts = [ "Iosevka" "Ubuntu" "UbuntuMono" "Gohu" ]; })
    monocraft
    fixedsys-nerd-font
    scientifica-nerd-font
    fairfax-nerd-font
    monaspace-krypton-nerd-font
  ];
}
