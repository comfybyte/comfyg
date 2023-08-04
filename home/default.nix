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
  ];

  programs.alacritty = 
  let termfont = "IosevkaTerm Nerd Font"; 
  in {
    enable = true;
    settings = {
      window = {
        opacity = 0.7;
        padding.x = 2;
        padding.y = 2;
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
