{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

    nix = {
      package = pkgs.nixFlakes;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    boot.loader.systemd-boot.enable = true;
    security.polkit.enable = true;
    security.rtkit.enable = true;

    programs.zsh.enable = true;

    users.users.maya = {
      isNormalUser = true;
      home = "/home/maya";
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };

    environment.shells = with pkgs; [ zsh ];

    nixpkgs.config.allowUnfree = true;

    sound.enable = true;
    services.dbus.enable = true;
    services.xserver.layout = "br-abnt2";

    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;

    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    services.xserver.drivers = [
      "video-intel"
      "mesa"
      "vulkan-intel"
    ];

    programs.sway.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme
    grim
    slurp
    libnotify
    imagemagick
    qt5.qtwayland
    glxinfo
    vulkan-tools
    nix-prefetch-git
    num-utils
    luajit

    libpng
    giflib
    ncurses
    gnutls
    mpg123
    openal
    v4l-utils
    alsa-lib
    libjpeg
    xorg.libXcomposite
    xorg.libXinerama
    libgcrypt
    ocl-icd
    libxslt
    libva
    gtk3
    gst_all_1.gst-plugins-base


    appimage-run
    wofi
    zip
    unzip
    unrar
    bemenu
    wdisplays
    git
    neofetch
    dmenu
    imv
    parted
    ventoy-full

    ripgrep
    jq
    gnupg
    tree
    exa
    httpie
    wget
    htop

    gcc
    gnumake
    rust-bin.beta.latest.default
    python3
    nodejs

    flameshot
    deluge
    deluge-gtk
    firefox

    vlc
    xfce.thunar
    xfce.ristretto
    xfce.tumbler

    lutris
    wineWowPackages.staging
    winetricks
  ];

  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
];

services.gvfs.enable = true;
services.tumbler.enable = true;

xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
};

  # Enables fcitx5 for Japanese input.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc
      fcitx5-configtool
    ];
  };

  fonts.fonts = with pkgs; [ 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Hack" "ShareTechMono" ]; })
    monocraft
  ];

  networking.hostName = "kirisame";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  time.timeZone = "America/Sao_Paulo";

  system.stateVersion = "23.11";
}

