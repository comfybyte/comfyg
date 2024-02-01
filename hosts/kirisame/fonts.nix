{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # Japanese fonts.
    ipafont
    kochi-substitute

    # Nerd fonts.
    (nerdfonts.override {
      fonts = [ "Iosevka" "Ubuntu" "UbuntuMono" "Terminus" ];
    })
  ];
}
