{ pkgs, inputs, ... }:

{
  programs.fish.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  environment.systemPackages = with pkgs;
    let
      gaming = inputs.gaming.packages."${system}";
      agenix = inputs.agenix.packages."${system}";
      inotify-info = inputs.inotify.packages."${system}";
    in [
      mako
      swww
      wl-clipboard
      xdg-utils
      glib
      grim
      slurp
      libnotify
      imagemagick
      qt5.qtwayland
      qt6.qtwayland
      glxinfo
      vulkan-tools
      nix-prefetch-git
      num-utils
      luajit
      speechd
      toybox
      patchelf
      dpkg
      xorg.xhost
      busybox
      qemu_full
      nodePackages.serve
      nmap
      inotify-info.default

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

      zip
      unzip
      unrar
      wdisplays
      git
      neofetch
      ranger
      dmenu
      imv
      mpv
      parted
      ventoy-full
      agenix.default
      keychain
      cachix
      cloc
      shellcheck

      libsForQt5.okular
      libsForQt5.neochat

      ripgrep
      jq
      fzf
      fd
      gnupg
      pinentry-curses
      eza
      httpie
      wget
      htop
      btop
      dig
      uutils-coreutils
      du-dust
      bat
      gitui
      handlr-regex
      zenith
      qpwgraph

      nodejs_18
      nodePackages_latest.pnpm
      cargo
      cargo-shuttle
      cargo-info
      cargo-leptos
      just
      nixfmt
      ghc

      deluge
      deluge-gtk
      virt-manager
      nixos-shell
      nix-tree

      vlc
      xfce.ristretto
      xfce.tumbler

      lutris
      wineWowPackages.stagingFull
      wine64Packages.stagingFull
      gaming.wine-ge
      gaming.proton-ge
      winetricks
      gamemode
      bottles

      discord
      audacity
      krita
      vivaldi
      vivaldi-ffmpeg-codecs
      libreoffice-fresh
      obsidian
      authy
      emote
      gparted
      wmctrl
      firefox-devedition
      pfetch
      hyprpicker
      betterdiscordctl
      p7zip
      localsend

      osu-lazer-bin
      minecraft
      prismlauncher

      evremap
    
      sshot
      retag
    ];
}
