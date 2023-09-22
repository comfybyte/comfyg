{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs;
  let
    nix-gaming = inputs.nix-gaming.packages."${system}";
    agenix = inputs.agenix.packages."${system}";
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
    busybox
    qemu_full

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
    agenix.default
    keychain
    cachix

    ripgrep
    jq
    gnupg
    pinentry-curses
    tree
    exa
    httpie
    wget
    htop
    btop
    dig
    bandwhich
    uutils-coreutils
    du-dust
    bat
    mprocs
    gitui
    wiki-tui
    gitoxide
    handlr-regex
    zenith

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
    cargo-info
    cargo-leptos
    just
    trunk
    nixfmt

    flameshot
    deluge
    deluge-gtk
    virt-manager

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
}
