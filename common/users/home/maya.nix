{ pkgs, inputs, system, ... }:
let
  gaming = inputs.gaming.packages."${system}";
  gtk-theme = {
    pkg = pkgs.tokyo-night-gtk;
    theme = "Tokyonight-Storm-B";
    icons = "Tokyonight-Dark-Cyan";
  };
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
    GTK_THEME = gtk-theme.theme;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = gtk-theme.icons;
      package = gtk-theme.pkg;
    };
    theme = {
      name = gtk-theme.theme;
      package = gtk-theme.pkg;
    };
    font.package = pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; };
    font.name = "Ubuntu Nerd Font";
    font.size = 16;
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
