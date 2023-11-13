{ pkgs, writeShellApplication }:
writeShellApplication {
  name = "sshot";
  runtimeInputs = with pkgs; [ coreutils libnotify grim slurp ];
  text = builtins.readFile ./run.sh;
}
