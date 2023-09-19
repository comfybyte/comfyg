{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" "SpaceMono" "Terminus" "Mononoki" ]; })
    monocraft
    effects-eighty-nerd
    intel-one-mono-nerd
  ];
}
