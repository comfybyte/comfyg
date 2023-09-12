{ config, pkgs, lib, inputs, system, ... }:
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
      ./nu.nix
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

      osu-lazer-bin
      minecraft
      prismlauncher
    ];

    programs = {
      home-manager.enable = true;
      zsh = {
        enable = true;
        shellAliases = {
          nors = "sudo nixos-rebuild switch";

          txn = "tmux new";
          txl = "tmux list-sessions";
          txa = "tmux attach -t";

          ls = "exa";
          lls = "ls";

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
      git = {
        enable = true;
        userName = "mayaneru";
        userEmail = "mayaneru@proton.me";
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
        ];
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
