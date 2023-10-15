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
    (nerdfonts.override {
      fonts =
        [ "Terminus" "IosevkaTerm"];
    })
    monocraft
    lotion-nerd-font
    fixedsys-nerd-font
    scientifica-nerd-font
  ];
}
