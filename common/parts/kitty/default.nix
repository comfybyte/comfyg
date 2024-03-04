{ config, lib, pkgs, ... }:
let
  cfg = config.parts.kitty;
  themeFile = ".config/kitty/themes/kanagawa.conf";
in {
  options.parts.kitty.enable = lib.mkEnableOption "Enable kitty.";
  config = lib.mkIf cfg.enable {
    home.file."${themeFile}".text = import ./kanagawa.nix;
    programs.kitty = {
      enable = true;
      font.package = pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; };
      font.name = "Mononoki Nerd Font";
      font.size = 17;
      settings = {
        cursor_stop_blinking_after = "0";
        background_opacity = "0.8";
      };
      extraConfig = ''
        include ${config.home.homeDirectory + themeFile}
      '';
    };
  };
}
