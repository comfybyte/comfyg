{ pkgs, writeShellApplication }:
writeShellApplication {
  name = "retag";
  runtimeInputs = with pkgs; [ coreutils imv gnome.zenity ];
  text = builtins.readFile ./run.sh;
}
