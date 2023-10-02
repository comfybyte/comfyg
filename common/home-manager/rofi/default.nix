{ config, lib, ... }:
let cfg = config.inner.rofi;
in with lib; {
  options.inner.rofi.enable = mkEnableOption "Enable rofi.";

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      theme = "catppuccin-macchiato";
      location = "bottom-right";
    };

    home.file.".local/share/rofi/themes/catppuccin-macchiato.rasi".source =
      ./catppuccin-macchiato.rasi;
  };
}
