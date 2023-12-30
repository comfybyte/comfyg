{ config, lib, ... }: {
  config = lib.mkIf config.parts.vim.enable {
    programs.nixvim.keymaps = let
      mkMap = key: mode: action: { inherit key mode action; };
      mkN = key: action: mkMap key "n" action;
      mkV = key: action: mkMap key "v" action;
      mkS = key: action: mkMap key "s" action;
      nMaps = [
        (mkN "<C-d>" "<C-d>zz")
        (mkN "<C-u>" "<C-u>zz")
        (mkN "G" "Gzz")
        (mkN "<leader>y" ''"+y'')
        (mkN "<leader>Y" ''"+Y'')
        (mkN "<leader>ft" "<cmd>lua vim.lsp.buf.format()<cr>")
        (mkN "<leader>xx" "<cmd>TroubleToggle<cr>")
        (mkN "<leader>xd" "<cmd>ToggleDiag<cr>")
      ];
      vMaps = [ (mkV "<leader>y" ''"+y'') ];
      sMaps = [ (mkS "<leader>po" ''"_dP'') ];
    in nMaps ++ vMaps ++ sMaps;
  };
}
