# LSPs, linters and formatter
{ config, pkgs, ... }: {
  programs.nixvim = {
    globals.ftplugin_sql_omni_key = "<C-j>"; # <C-c> is annoying in .sql files.
    plugins = {
      treesitter = {
        enable = true;
        nixGrammars = true;
        ensureInstalled = "all";
        nixvimInjections = true;
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # Nix.
          lua-ls.enable = true;
          hls.enable = true; # Haskell.
          tsserver.enable = true;
          html.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          jsonls.enable = true;
          cssls.enable = true;
          taplo.enable = true; # TOML.
          clojure-lsp.enable = true;
          rust-analyzer = {
            enable = true;
            # Use from nix-shell env instead.
            installCargo = false;
            installRustc = false;
            # extraOptions = { procMacro.enable = false; };
          };
        };
        onAttach = ''
          bufopts = { noremap = true, silent = true, buffer = bufnr }

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufops)
          vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>")
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        '';
      };
      none-ls = {
        enable = true;
        sources.formatting = {
          nixfmt.enable = true;
          rustfmt.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
          taplo.enable = true;
          prettier.enable = true;
          prettier_d_slim.enable = true;
          eslint.enable = true;
          eslint_d.enable = true;
        };
        sources.code_actions = {
          eslint.enable = true;
          eslint_d.enable = true;
          shellcheck.enable = true;
        };
      };
      lspsaga = {
        enable = true;
        extraOptions = { lightbulb.enable = false; };
      };
      dap.enable = true; # Debugging.
      nvim-jdtls = {
        # Unfinished, workspace probably should be dynamic.
        enable = true;
        data = "${config.home.homeDirectory}/.cache/jdtls/workspace";
      };
      fidget.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      lsp-inlayhints-nvim
      rust-vim
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
  };
}
