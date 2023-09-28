{ pkgs, inputs, ... }:

{
  programs.fish.enable = true;
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
      toybox
      patchelf
      dpkg
      xorg.xhost
      busybox
      qemu_full
      nodePackages.serve
      nmap
      wireshark
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
      parted
      ventoy-full
      agenix.default
      keychain
      cachix

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
      mprocs
      gitui
      wiki-tui
      handlr-regex
      zenith

      gcc
      gnumake
      nodejs
      nodePackages_latest.pnpm
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.minimal))
      cargo-shuttle
      cargo-info
      cargo-leptos
      just
      nixfmt

      deluge
      deluge-gtk
      virt-manager
      nixos-shell

      vlc
      xfce.thunar
      xfce.ristretto
      xfce.tumbler

      lutris
      wineWowPackages.stagingFull
      wine64Packages.stagingFull
      gaming.wine-ge
      gaming.proton-ge
      winetricks
      gamemode

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
      libsForQt5.okular

      osu-lazer-bin
      minecraft
      prismlauncher
    ];
}
