{ pkgs, inputs, pinned, system, ... }: {
  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };
  environment.systemPackages = with pkgs;
    let
      forSys = set: set.packages."${system}";
      inotify-info = forSys inputs.inotify;
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
      num-utils
      luajit
      speechd
      toybox
      patchelf
      xorg.xhost
      busybox
      # qemu_full
      nmap
      ripgrep
      jq
      fzf
      fd
      gnupg
      pinentry
      pulsemixer
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
      pinned.zenith
      transmission # BitTorrent client.
      transmission-gtk
      piper
      pulseaudio
      pavucontrol

      inotify-info.default
      nix-prefetch-git
      nodePackages.serve
      zip
      unzip
      unrar
      wdisplays
      git
      neofetch
      pfetch
      imv
      mpv
      parted
      keychain
      cachix
      cloc
      shellcheck
      wmctrl
      betterdiscordctl
      p7zip
      virt-manager
      nixos-shell
      nix-tree
      mlt

      # should be devshells but oh well
      nodejs_18
      cargo
      cargo-info
      just
      nixfmt
      ghc
      clojure
      clj-kondo

      sshot
      retag
    ];
}
