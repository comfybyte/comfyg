{ lib, pkgs, config, ... }:
let
  lua = import ./lua.nix;
  maps = import ./maps.nix;
in {
  programs.nixvim = lib.attrsets.mergeAttrsList [
    {
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
      };

      globals = {
        mapleader = " ";

        loaded_netrw = 1;
        loaded_netrwPlugin = 1;

        ftplugin_sql_omni_key = "<C-j>";
        neoformat_run_all_formatters = 1;
        neoformat_enabled_nix = [ "nixfmt" "rustfmt" ];
      };
      autoCmd = [{
        event = [ "BufWritePre" "BufRead" ];
        pattern = [ "*.nix" "*.rs" ];
        command = "Neoformat";
        description = "Formatting on save.";
      }];
      colorscheme = "rose-pine";
      colorschemes.rose-pine = {
        enable = true;
        transparentBackground = true;
        transparentFloat = true;
      };
      plugins = {
        lualine = {
          enable = true;
          theme = "rose-pine";
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
          neovimImageText = "Hacking...";
          editingText = "Editing a file";
          readingText = "Reading a file";
          workspaceText = "In a workspace";
          fileExplorerText = "In menu";
          gitCommitText = "About to break git";
          showTime = false;
          extraOptions = {
            # Nixvim's only accepts null, which doesn't disable it for some reason.
            buttons = false;
          };
        };
        indent-blankline.enable = true;
        cursorline = {
          enable = true;
          cursorline = {
            enable = true;
            timeout = 1000;
            number = false;
          };
          cursorword = {
            enable = true;
            minLength = 3;
            hl.underline = true;
          };
        };
        comment-nvim.enable = true;
        nvim-autopairs.enable = true;
        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            rust-analyzer.enable = true;
            lua-ls.enable = true;
            hls.enable = true;
            tsserver.enable = true;
            html.enable = true;
            bashls.enable = true;
            clangd.enable = true;
            jsonls.enable = true;
          };
          onAttach = ''
            bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>")
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
    }
    lua
    maps
  ];
}
