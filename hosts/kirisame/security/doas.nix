let
  # Allow a list of commands to be used without password.
  allowAll = cmds:
    builtins.map (cmd: {
      inherit cmd;
      groups = [ "wheel" ];
      persist = true;
    }) cmds;
in {
  security.doas.enable = true;
  security.doas.extraRules = allowAll [ "nix" "nixos-rebuild" ];
}
