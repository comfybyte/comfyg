{ config, lib, ... }:
let parts = config.parts;
in {
  imports = [
    ./git
    ./gtk
    ./hyprland
    ./rofi
    ./vim
    ./shells
    ./alacritty
    ./tmux
    ./kitty
    ./gpg
  ];

  options.parts = {
    enable = lib.mkEnableOption "Enable this module.";
    stateVersion = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf parts.enable {
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = parts.stateVersion;
  };
}
