{
  imports = [ ./doas.nix ./polkit.nix ];
  security.rtkit.enable = true;
}
