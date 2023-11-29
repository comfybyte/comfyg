# (Auto)completion and snippets.
{ pkgs, ... }: {
  programs.nixvim.plugins = {
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp_luasnip.enable = true;
    nvim-cmp = {
      enable = true;
      mappingPresets = [ "cmdline" "insert" ];
      snippet.expand = "luasnip";
      sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "luasnip"; }
        { name = "path"; }
      ];
      mapping = let select = "{ behavior = cmp.SelectBehavior.Select }";
      in {
        "<C-space>" = "cmp.mapping.complete()";
        "<C-p>" = "cmp.mapping.select_prev_item(${select})";
        "<C-n>" = "cmp.mapping.select_next_item(${select})";
        "<cr>" = "cmp.mapping.confirm({ select = true })";
        "<C-u>" = "cmp.mapping.scroll_docs( -4)";
        "<C-d>" = "cmp.mapping.scroll_docs(4)";
      };
    };
    luasnip = {
      enable = true;
      fromVscode = [ { } ];
    };
  };
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    luasnip
    friendly-snippets
  ];
}
