{ inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.05";

  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
    agenix.homeManagerModules.default
    xyprland.homeManagerModules.xyprland
    ./xyprland
    ./shell
    ./terminal
    ./vim
    ./rofi
    ./obs.nix
    ./git.nix
  ];
} 
