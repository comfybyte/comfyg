{
  networking.hostName = "kirisame";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 3000;
      to = 3012;
    }];
  };
  services.openssh.enable = true;
}
