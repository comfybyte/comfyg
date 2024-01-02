{ pkgs, inputs, system, pinned, ... }:
let gaming = inputs.gaming.packages."${system}";
in {
  imports = [ ../../parts ];

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
    username = "mai";
    homeDirectory = "/home/mai";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = gaming.proton-ge;
  };
  programs.direnv = {
    enable = true;
    # NOTE: Pin reason: bash version fuckery.
    package = pinned.direnv;
    nix-direnv.enable = true;
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
