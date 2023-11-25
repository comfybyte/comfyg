{ pkgs, pinned, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  environment.systemPackages = with pkgs; [
      libsForQt5.okular
      vlc
      xfce.ristretto
      xfce.tumbler
      discord
      audacity
      krita
      vivaldi
      vivaldi-ffmpeg-codecs
      libreoffice-fresh
      pinned.obsidian
      authy
      emote
      gparted
      firefox-devedition
      librewolf
      hyprpicker
      localsend
      deluge
      deluge-gtk
      qpwgraph
      gnome.nautilus
  ];
}
