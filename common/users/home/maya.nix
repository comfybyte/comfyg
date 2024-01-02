{ pkgs, inputs, system, pinned, ... }:
let gaming = inputs.gaming.packages."${system}";
in {
  imports = [ ../../parts ];
  # imports = [ ../../home-manager ];
  #
  # inner = {
  #   rofi.enable = true;
  #   alacritty.enable = true;
  #   vim.enable = true;
  #   zsh.enable = true;
  #   fish.enable = true;
  #   starship.enable = true;
  #   tmux.enable = true;
  #   obs.enable = true;
  #   gtk.enable = true;
  # };

  parts = {
    enable = true;
    stateVersion = "23.05";
    gtk.enable = true;
    rofi.enable = true;
    vim.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    tmux.enable = true;
    shells.fish.enable = true;
    shells.zsh.enable = true;
    shells.starship.enable = true;
    git = {
      enable = true;
      name = "comfybyte";
      email = "comfybyte@proton.me";
      key = "61143F72A8F3440A";
    };
    hyprland = {
      enable = true;
      waybar.enable = true;
    };
  };

  home = {
    username = "maya";
    homeDirectory = "/home/maya";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = gaming.proton-ge;
  };
  programs.direnv = {
    enable = true;
    package = pinned.direnv;
    nix-direnv.enable = true;
    # hmm yes bash 3.2.1 is lower than 3.2, right right
    nix-direnv.package = pinned.nix-direnv;
  };
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "BreezeDark";
  };
  home.pointerCursor = with pkgs; {
    name = "Catppuccin-Macchiato-Mauve-Cursors";
    package = catppuccin-cursors.macchiatoMauve;
    gtk.enable = true;
    x11.enable = true;
  };
}
