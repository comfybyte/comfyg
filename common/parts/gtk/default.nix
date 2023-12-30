{ pkgs, config, lib, ... }:
let
  cfg = config.parts.gtk;
  gtk-theme = {
    pkg = pkgs.tokyo-night-gtk;
    theme = "Tokyonight-Storm-B";
    icons = "Tokyonight-Dark-Cyan";
  };
in {
  options.parts.gtk.enable = lib.mkEnableOption "Enable GTK theming.";

  config = lib.mkIf cfg.enable {
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
      font.package = pkgs.monaspace-krypton-nerd-font;
      font.name = "MonaspiceKr Nerd Font";
      font.size = 15;
    };
    home.sessionVariables = { GTK_THEME = gtk-theme.theme; };
  };
}
