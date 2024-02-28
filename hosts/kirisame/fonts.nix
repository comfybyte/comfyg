{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
    vistafonts

    # Japanese fonts.
    ipafont
    kochi-substitute

    # Nerd fonts.
    (nerdfonts.override {
      fonts = [ "Iosevka" "Ubuntu" "UbuntuMono" "Terminus" "Gohu" ];
    })
  ];
}
