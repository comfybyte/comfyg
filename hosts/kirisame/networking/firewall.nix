{
  networking.nftables.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [{
      from = 3000;
      to = 3010;
    }];
  };
}
