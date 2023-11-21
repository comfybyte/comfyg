{ pkgs, config, lib, ... }:
let cfg = config.inner.vim;
in with lib; {
  options.inner.vim.enable = mkEnableOption "Enable (Neo)vim.";

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      options = {
        number = true;
        nuw = 1;
        relativenumber = true;
        cursorcolumn = true;
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
        listchars = {
          space = "⋅";
          eol = "↴";
        };
      };
      globals = {
        mapleader = " ";
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
        ftplugin_sql_omni_key = "<C-j>";
        neoformat_enabled_nix = [ "nixfmt" "rustfmt" ];
      };
      colorscheme = "tokyonight";
      colorschemes.tokyonight = {
        enable = true;
        transparent = true;
        lualineBold = true;
        styles = {
          functions = { bold = true; };
          sidebars = "transparent";
          floats = "transparent";
        };
      };
      plugins = import ./plugins.nix;
      extraConfigLua = builtins.readFile ./init.lua;
      extraPlugins = with pkgs.vimPlugins; [
        hop-nvim
        luasnip
        barbecue-nvim
        friendly-snippets
        lsp-inlayhints-nvim
        rust-vim
        vim-rhubarb
        neoformat
        indent-blankline-nvim
        (pkgs.vimUtils.buildVimPlugin {
          pname = "toggle-lsp-diagnostics-nvim";
          version = "master";
          src = pkgs.fetchFromGitHub {
            owner = "WhoIsSethDaniel";
            repo = "toggle-lsp-diagnostics.nvim";
            rev = "a896a95851fe5c5adf71a50030d60f8fa488fa7e";
            sha256 = "sha256-coedGERDTVmAD3+/QaEaq4peK7cCaOPo5ooKEalqasI=";
          };
        })
      ];
    } // (import ./maps.nix);
  };
}
