{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts =
        [ "Terminus" "UbuntuMono" "JetBrainsMono" "IosevkaTerm"];
    })
    monocraft
    lotion-nerd-font
  ];
}
