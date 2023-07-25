{ config, pkgs, inputs, ... }:
{
  home.username = "maya";
  home.homeDirectory = "/home/maya";

  imports = [
    ./sway.nix
    ./waybar.nix
    ./nixvim.nix
    ./hyprland.nix
    ./tmux.nix
  ];

  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  # Use zsh as default shell.
  programs.zsh = {
    enable = true;
    shellAliases = {
      # NixOS aliases.
      nors = "sudo nixos-rebuild switch";
      hmb = "home-manager build";
      hms = "home-manager switch";

      # tmux aliases.
      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      # Mic testing.
      mic-loop = "pactl load-module module-loopback";
      mic-unloop = "pactl unload-module module-loopback";

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
    userName = "mayaneru";
    userEmail = "comfy.is.sleepy@gmail.com";
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
    flameshot
    libreoffice-fresh
    obsidian
    ulauncher 
    emote 
    gparted
    wmctrl

    osu-lazer-bin
  ];

  programs.alacritty = 
  let termfont = "Monocraft Nerd Font"; 
  in {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
        padding.x = 0;
        padding.y = 0;
      };
      draw_bold_text_with_bright_colors = true;
      custom_cursor_colors = true;
      font = {
        size = 14;
        normal.family = "${termfont}";
        bold.family = "${termfont}";
        italic.family = "${termfont}";
        bold_italic.family = "${termfont}";
      };
      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xcbe1e7";
        };
        cursor = {
          text = "0xff271d";
          cursor = "0xfbfcfc";
        };
        normal = {
          black =   "0x141228";
          red =     "0xff5458";
          green =   "0x62d196";
          yellow =  "0xffb378";
          blue =    "0x65b2ff";
          magenta = "0x906cff";
          cyan =    "0x63f2f1";
          white =   "0xa6b3cc";
        };
        bright = {
          black =   "0x565575";
          red =     "0xff8080";
          green =   "0x95ffa4";
          yellow =  "0xffe9aa";
          blue =    "0x91ddff";
          magenta = "0xc991e1";
          cyan =    "0xaaffe4";
          white =   "0xcbe3e7";
        };
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
