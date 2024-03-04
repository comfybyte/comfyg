{ pkgs, ... }: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  environment.systemPackages = with pkgs; [
    libsForQt5.okular # PDF viewer.
    libsForQt5.kdenlive # video editor.
    vlc # video player.
    xfce.ristretto # image viewer.
    xfce.tumbler
    discord
    tenacity # Audio editor.
    krita # Image editor.
    vivaldi
    vivaldi-ffmpeg-codecs
    libreoffice-fresh
    obsidian
    authy
    emote # Emoji picker.
    gparted
    firefox-devedition
    floorp
    librewolf
    hyprpicker # Colour picker.
    localsend
    gnome.nautilus
    fractal # Matrix client.
    kooha # screen recorder.
  ];
}
