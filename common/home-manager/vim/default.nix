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
      plugins = {
        lualine = {
          enable = true;
          theme = "tokyonight";
        };

        nix.enable = true;

        treesitter = {
          enable = true;
          nixGrammars = true;
          ensureInstalled = "all";
          nixvimInjections = true;
        };

        treesitter-context.enable = true;

        telescope = {
          enable = true;
          extensions = {
            file_browser = {
              enable = true;
              hijackNetrw = true;
              respectGitignore = false;
            };
            fzf-native.enable = true;
          };
        };

        harpoon = {
          enable = true;
          keymaps = {
            addFile = "<C-a>";
            toggleQuickMenu = "<C-e>";
            navFile = {
              "1" = "<leader>1";
              "2" = "<leader>2";
              "3" = "<leader>3";
              "4" = "<leader>4";
              "5" = "<leader>5";
              "6" = "<leader>6";
            };
          };
        };

        surround.enable = true;

        gitsigns.enable = true;
        fugitive.enable = true;

        presence-nvim = {
          enable = true;
          mainImage = "file";
          neovimImageText = "🌙";
          editingText = "Editando arquivo";
          readingText = "Lendo arquivo";
          workspaceText = "Num projeto";
          fileExplorerText = "Num menu";
          gitCommitText = "Quebrando o Git";
          showTime = false;
          extraOptions.buttons = false;
        };
        cursorline = {
          enable = true;
          cursorword = {
            enable = true;
            minLength = 3;
            hl.underline = true;
          };
          cursorline = {
            enable = true;
            timeout = 0;
          };
        };

        markdown-preview.enable = true;

        comment-nvim.enable = true;
        nvim-autopairs.enable = true;
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
            rust-analyzer = {
              enable = true;
              extraOptions = { procMacro.enable = false; };
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
        lspsaga = {
          enable = true;
          extraOptions = { lightbulb.enable = false; };
        };
        fidget.enable = true;
        luasnip = {
          enable = true;
          fromVscode = [ { } ];
        };
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
        nvim-colorizer.enable = true;
        ts-autotag.enable = true;
        trouble.enable = true;
      };
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
