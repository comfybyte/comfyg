{ pkgs, inputs, system, ... }:
let gaming = inputs.gaming.packages."${system}";
in {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    lutris
    libpng
    giflib
    ncurses
    gnutls
    mpg123
    openal
    v4l-utils
    alsa-lib
    libjpeg
    libpulseaudio
    alsa-plugins
    xorg.libXcomposite
    xorg.libXinerama
    libgcrypt
    ocl-icd
    libxslt
    libva
    gtk3
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    cups
    dosbox
    dxvk

    wineWowPackages.stagingFull
    wine64Packages.stagingFull
    gaming.wine-ge
    gaming.proton-ge
    osu-lazer-bin
    winetricks
    gamemode
    minecraft
    prismlauncher
  ];
}
