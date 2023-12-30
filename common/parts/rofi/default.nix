{ config, lib, pkgs, ... }:
let cfg = config.parts.rofi;
in with lib; {
  options.parts.rofi.enable = mkEnableOption "Enable rofi.";

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      theme = "midnight_sky";
      terminal = "${pkgs.alacritty}/bin/alacritty";

      location = "bottom-right";
      xoffset = -8;
      yoffset = -32;
    };

    home.file.".local/share/rofi/themes/midnight_sky.rasi".text =
      import ./theme.nix;
  };
}
