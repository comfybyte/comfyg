{ pkgs, ... }: {
  programs.nixvim = {
    colorscheme = "poimandres";
    colorschemes.poimandres = {
      enable = true;
      disableBackground = true;
      disableFloatBackground = true;
    };
    plugins = {
      lualine = {
        enable = true;
        theme = "poimandres";
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
  };
}
