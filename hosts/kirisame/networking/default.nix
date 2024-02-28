{
  imports = [ ./firewall.nix ./ssh.nix ];
  networking.hostName = "kirisame";
  networking.networkmanager.enable = true;
}
