{ pkgs, ... }: {
  programs.nixvim = {
    colorscheme = "kanagawa";
    plugins = {
      lualine = {
        enable = true;
        theme = "kanagawa";
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
      kanagawa-nvim
      barbecue-nvim
      indent-blankline-nvim
    ];
    extraConfigLuaPre = builtins.readFile ./ui.lua;
  };
}
