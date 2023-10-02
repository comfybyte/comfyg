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
        hlsearch = true;
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
      colorscheme = "catppuccin";
      colorschemes.catppuccin = {
        enable = true;
        flavour = "macchiato";
        transparentBackground = true;
      };
      plugins = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };

        nix.enable = true;

        treesitter = {
          enable = true;
          nixGrammars = true;
          ensureInstalled = "all";
          nixvimInjections = true;
        };

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
          neovimImageText = "=w=";
          editingText = "Editing something";
          readingText = "Reading something";
          workspaceText = "In a project";
          fileExplorerText = "In menu";
          gitCommitText = "About to break git";
          showTime = false;
          extraOptions.buttons = false;
        };
        indent-blankline = {
          enable = true;
          showEndOfLine = true;
          showCurrentContext = true;
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
          sources = [ # TODO: Configure snippets.
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
      };
      extraPlugins = with pkgs.vimPlugins; [
        hop-nvim
        luasnip
        barbecue-nvim
        friendly-snippets
        lsp-inlayhints-nvim
        rust-vim
        vim-rhubarb
        neoformat
      ];
    } // (import ./lua.nix) // (import ./maps.nix);
  };
}
