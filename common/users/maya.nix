{ pkgs, inputs, system, ... }:
let
  name = "Maya Lira";
  email = "comfybyte@proton.me";
  gaming = inputs.gaming.packages."${system}";
in {
  imports = [ ../home-manager ];

  inner = {
    rofi.enable = true;
    alacritty.enable = true;
    vim.enable = true;
    fish.enable = true;
    starship.enable = true;
    tmux.enable = true;
    obs.enable = true;
    hyprland = {
      enable = true;
      waybar = true;
    };
  };

  home = {
    username = "maya";
    homeDirectory = "/home/maya";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = gaming.proton-ge;
  };

  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    signing = {
      signByDefault = true;
      key = "61143F72A8F3440A";
    };
    extraConfig = {
      core.editor = "vim";
      init.defaultBranch = "main";
      push.default = "current";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.libsForQt5.breeze-icons;
    };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
  };

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "BreezeDark";
  };

  home.pointerCursor = with pkgs; {
    name = "Catppuccin-Macchiato-Mauve-Cursors";
    package = catppuccin-cursors.macchiatoMauve;
    gtk.enable = true;
    x11.enable = true;
  };
}
