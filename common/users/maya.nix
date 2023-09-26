{ pkgs, inputs, system, ... }:
let
  name = "Maya Lira";
  email = "comfybyte@proton.me";
  gaming = inputs.gaming.packages."${system}";
in {
  imports = [ ../home-manager ];

  home = {
    username = "maya";
    homeDirectory = "/home/maya";
  };
  home.packages = with pkgs; [ rose-pine-gtk-theme ];
  home.sessionVariables = {
    EDITOR = "nvim";
    PF_INFO = "ascii title os host kernel shell de uptime pkgs memory";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = gaming.proton-ge;
  };

  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    signing = {
      signByDefault = true;
      key = "61143F72A8F3440A";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.rofi = {
    enable = true;
    theme = "glue_pro_blue";
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-gtk-theme;
    };
  };
}
