{ pkgs, config, lib, ... }:
let cfg = config.inner.vim;
in with lib; {
  imports =
    [ ./maps.nix ./plugins.nix ./ui.nix ./cmp.nix ./lsp.nix ./menus.nix ];
  options.inner.vim.enable = mkEnableOption "Enable Neovim.";
  config = mkIf cfg.enable {
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
        # listchars.space = "⋅";
      };

      globals.mapleader = " ";
      # TODO: Split the .lua file.
      extraConfigLua = builtins.readFile ./init.lua;
      extraPlugins = with pkgs.vimPlugins; [
        vim-rhubarb
        vim-sexp
        vim-sexp-mappings-for-regular-people
      ];
    };
  };
}
