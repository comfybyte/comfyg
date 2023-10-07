{ inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.05";

  imports = with inputs; [
    hyprland.homeManagerModules.default
    nixvim.homeManagerModules.nixvim
    agenix.homeManagerModules.default
    ./shell
    ./terminal
    ./hyprland
    ./vim
    ./rofi
    ./obs.nix
  ];
}
