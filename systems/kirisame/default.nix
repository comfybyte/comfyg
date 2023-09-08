{ config, pkgs, lib, inputs, ... }:

let
  system = pkgs.system;
in {
  imports =
    [
      ./hardware-configuration.nix
    ];

    nix = {
      package = pkgs.nixFlakes;
      settings.experimental-features = [ "nix-command" "flakes" ];
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

    environment.shells = [ pkgs.zsh ];

    nixpkgs.config.allowUnfree = true;

    services.dbus.enable = true;
    services.xserver.layout = "br-abnt2";

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    programs.dconf.enable = true;

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

    # programs.sway.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    environment.systemPackages = with pkgs;
    let
      nix-gaming = inputs.nix-gaming.packages."${system}";
    in
    [
      xdg-utils
      glib
      dracula-theme
      gnome3.adwaita-icon-theme
      grim
      slurp
      libnotify
      libsForQt5.polkit-kde-agent
      imagemagick
      qt5.qtwayland
      qt6.qtwayland
      glxinfo
      vulkan-tools
      nix-prefetch-git
      num-utils
      luajit
      speechd
      nix-index
      toybox
      patchelf
      dpkg
      xorg.xhost

      # Mostly game dependencies.
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
      alsa-lib
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
      gtk-layer-shell

      ripgrep
      jq
      gnupg
      tree
      exa
      httpie
      wget
      htop
      dig
      bandwhich

      gcc
      gnumake
      python3
      nodejs
      nodePackages_latest.pnpm
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
      cargo-shuttle
      just
      btop

      flameshot
      deluge
      deluge-gtk

      vlc
      xfce.thunar
      xfce.ristretto
      xfce.tumbler

      lutris
      wineWowPackages.stagingFull
      wine64Packages.stagingFull
      nix-gaming.wine-ge
      nix-gaming.proton-ge
      winetricks
      gamemode

    ]; 

    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];

    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.samba = {
      enable = true;
      openFirewall = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = with pkgs; [ 
        # xdg-desktop-portal-gtk 
        xdg-desktop-portal-hyprland
      ];
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

  fonts.packages = with pkgs; [ 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" "Iosevka" "IosevkaTerm" "Monofur" "Terminus" ]; })
    monocraft
    effects-eighty-nerd
    intel-one-mono-nerd
  ];

  # Adapted from the wiki page
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  networking.hostName = "kirisame";
  networking.networkmanager.enable = true;
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 80 443 ];
  # };

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  time.timeZone = "America/Sao_Paulo";

  system.stateVersion = "23.11";
}

