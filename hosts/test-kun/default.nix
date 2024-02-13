# Dummy (baka?) system for testing.
{ pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  system.stateVersion = "23.11";

  boot.loader.systemd-boot.enable = true;
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  time.timeZone = "America/Sao_Paulo";
  programs.zsh.enable = true;
  users.users.comfy = {
    isNormalUser = true;
    home = "/home/comfy";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
