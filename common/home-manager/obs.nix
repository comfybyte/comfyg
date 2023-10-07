{ config, lib, pkgs, ... }:
let cfg = config.inner.obs;
in with lib; {
  options.inner.obs.enable = mkEnableOption "Enable OBS.";

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
  };
}
