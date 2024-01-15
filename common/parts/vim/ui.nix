{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.parts.vim.enable {
    programs.nixvim = {
      colorscheme = "rose-pine";
      colorschemes.rose-pine = {
        enable = true;
        style = "moon";
        transparentBackground = true;
        transparentFloat = true;
      };
      plugins = {
        lualine = {
          enable = true;
          theme = "rose-pine";
        };
        cursorline = {
          enable = true;
          cursorline = {
            enable = true;
            timeout = 0;
          };
        };
        gitsigns.enable = true;
        nvim-colorizer.enable = true;
      };
      extraPlugins = with pkgs.vimPlugins; [
        barbecue-nvim
        indent-blankline-nvim
      ];
      extraConfigLuaPre = builtins.readFile ./ui.lua;
    };
  };
}
