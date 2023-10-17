{ pkgs, ... }: {
  users.users.maya = {
    isNormalUser = true;
    home = "/home/maya";
    extraGroups = [ "wheel" "docker" "wireshark" ];
    shell = pkgs.fish;
  };
  home-manager.users.maya = (import ./home/maya.nix);
}
