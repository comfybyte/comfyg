{ pkgs, inputs, system, ... }:

let
  nix-gaming = inputs.nix-gaming.packages."${system}";
in
  {
    home = {
      username = "maya";
      homeDirectory = "/home/maya";
    };

    imports = with inputs; [
      hyprland.homeManagerModules.default
      nixvim.homeManagerModules.nixvim
      agenix.homeManagerModules.default
      ./zsh.nix
      ./starship.nix
      ./waybar.nix
      ./nixvim.nix
      ./hyprland.nix
      ./tmux.nix
      ./alacritty.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.stateVersion = "23.05";
    home.packages = with pkgs; [
      mako
      swww
      wl-clipboard
      lxappearance
      rose-pine-gtk-theme
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
      xplr

      osu-lazer-bin
      minecraft
      prismlauncher
    ];

    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName = "comfybyte";
        userEmail = "comfybyte@proton.me";
        signing = {
          signByDefault = true;
          key = "61143F72A8F3440A";
        };
      };

      rofi = {
        enable = true;
        theme = "glue_pro_blue";
      };

      bat.enable = true;
      zellij.enable = true;
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-vkcapture
        ];
      };
      neomutt = {
        enable = true;
        vimKeys = true;
      };
      newsboat = {
        enable = true;
        urls = [];
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "rose-pine-moon";
        package = pkgs.rose-pine-gtk-theme;
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = nix-gaming.proton-ge;
    };
  }
