{ pkgs, ... }: {
  users.users.mai = {
    isNormalUser = true;
    home = "/home/mai";
    extraGroups = [ "wheel" "docker" "wireshark" "libvirt" ];
    shell = pkgs.fish;
  };
  home-manager.users.mai = import ./home/mai.nix;
}
