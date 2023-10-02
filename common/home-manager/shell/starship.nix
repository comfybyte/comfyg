{ config, lib, ... }:
let cfg = config.inner.starship;
in with lib; {
  options.inner.starship.enable = mkEnableOption "Enable starship.";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings.command_timeout = 3000;
    };
  };
}
