{ pkgs, config, lib, inputs, ... }:
let cfg = config.parts.vim;
in {
  options.parts.vim.enable = lib.mkEnableOption "Enable Neovim.";

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./maps.nix
    ./plugins.nix
    ./ui.nix
    ./cmp.nix
    ./lsp.nix
    ./menus.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      options = {
        number = true;
        nuw = 1;
        relativenumber = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        hlsearch = false;
        smartindent = true;
        wrap = false;
        termguicolors = true;
        scrolloff = 10;
        sidescrolloff = 10;
        updatetime = 1000;
        completeopt = "menuone,noselect";
        undodir = "${config.home.homeDirectory}/.cache/nvim/undodir";
        undofile = true;
        list = true;
      };

      globals.mapleader = " ";
      # TODO: Split the .lua file.
      extraConfigLua = builtins.readFile ./init.lua;
      extraPlugins = with pkgs.vimPlugins; [
        vim-rhubarb
        vim-sexp
        vim-sexp-mappings-for-regular-people
        (pkgs.vimUtils.buildVimPlugin rec {
          name = "vim-just";
          src = pkgs.fetchFromGitHub {
            owner = "noahtheduke";
            repo = name;
            rev = "974b16e257e2d30d94ec954d815ff2755fa229fb";
            sha256 = "sha256-7Np2XatOQMyxtRqfwNa6YOtgjG1NwpmSYNidy15LFlg=";
          };
        })
      ];
    };
  };
}
