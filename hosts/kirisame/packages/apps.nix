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
      libsForQt5.kdenlive
      vlc
      xfce.ristretto
      xfce.tumbler
      discord
      tenacity # Audio editor.
      krita # Image editor.
      vivaldi
      vivaldi-ffmpeg-codecs
      libreoffice-fresh
      pinned.obsidian
      authy
      emote # Emoji picker.
      gparted
      firefox-devedition
      floorp
      librewolf
      hyprpicker # Colour picker.
      localsend
      qpwgraph
      gnome.nautilus
      fractal # Matrix client.
  ];
}
