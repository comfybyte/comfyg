{ pkgs, ... }: {
  users.users.comfy = {
    isNormalUser = true;
    home = "/home/comfy";
    extraGroups = [ "wheel" "docker" "wireshark" "libvirt" ];
    shell = pkgs.fish;
  };
  home-manager.users.comfy = import ./home/comfy.nix;
}
