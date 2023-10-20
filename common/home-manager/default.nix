{ inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.05";

  imports = with inputs; [
    hyprland.homeManagerModules.default
    nixvim.homeManagerModules.nixvim
    agenix.homeManagerModules.default
    self.homeManagerModules.xyprland
    ./xyprland
    ./shell
    ./terminal
    ./vim
    ./rofi
    ./obs.nix
    ./git.nix
  ];
} 
