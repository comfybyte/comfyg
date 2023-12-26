{
  programs.nixvim.plugins = {
    nix.enable = true;
    leap.enable = true;
    surround.enable = true;
    fugitive.enable = true;
    markdown-preview.enable = true;
    comment-nvim.enable = true;
    nvim-autopairs = {
      enable = true;
      disabledFiletypes = [ "clj" ];
    };
    ts-autotag.enable = true;
    trouble.enable = true;
  };
}
