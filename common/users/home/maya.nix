{ pkgs, inputs, system, ... }:
let
  gaming = inputs.gaming.packages."${system}";
in {
  imports = [ ../../home-manager ];

  inner = {
    rofi.enable = true;
    alacritty.enable = true;
    vim.enable = true;
    zsh.enable = true;
    starship.enable = true;
    tmux.enable = true;
    obs.enable = true;
    git.enable = true;
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
    font.package = pkgs.scientifica-nerd-font;
    font.name = "Scientifica Nerd Font";
    font.size = 14;
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
