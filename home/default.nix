{ config, pkgs, inputs, ... }:
{
  home.username = "maya";
  home.homeDirectory = "/home/maya";

  imports = [
    #./sway.nix
    ./waybar.nix
    ./nixvim.nix
    ./hyprland.nix
    ./tmux.nix
    ./alacritty.nix
  ];

  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  # Use zsh as default shell.
  programs.zsh = {
    enable = true;
    shellAliases = {
      nors = "sudo nixos-rebuild switch";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      mic-loop = "pw-loopback";

      vim = "nvim";
      vi = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      theme = "intheloop";
      plugins = [
        "git"
      ];
    };
  };

  programs.git = {
    enable = true;
    userName = "hexentia";
    userEmail = "hexentia@proton.me";
  };

  home.packages = with pkgs; [
    mako # Notifications
    swww # Wallpaper
    wl-clipboard
    discord
    audacity
    krita
    vivaldi
    vivaldi-ffmpeg-codecs
    libreoffice-fresh
    obsidian
    ulauncher 
    authy
    emote 
    gparted
    wmctrl
    firefox-devedition
    pfetch
    hyprpicker
    betterdiscordctl

    # wine-lutris-ge-lol
    osu-lazer-bin
    minecraft
    prismlauncher
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    # pfetch configuration
    PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
  };

  programs.home-manager.enable = true;
}
