{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      nuw = 1;
      relativenumber = true;

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

      undodir = "/home/maya/.cache/nvim/undodir";
      undofile = true;
    };

    globals = {
      mapleader = " ";

      loaded_netrw = 1;
      loaded_netrwPlugin = 1;

      ftplugin_sql_omni_key = "<C-j>";
    };

    maps = {
      normal = {
        "<C-d>" = "<C-d>zz";
        "<C-u>" = "<C-u>zz";
        "n" = "nzzzv";
        "N" = "Nzzzv";
        "G" = "Gzz";

        "<leader>y" = ''"+y'';
        "<leader>Y" = ''"+Y'';
      };
      visual = {
        "<leader>y" = ''"+y'';
      };
      select = {
        "<leader>p" = ''"_dP'';
      };
    };

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

      gitsigns.enable = true;
      fugitive.enable = true;

      # Discord presence.
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

      # Visual indicator for indentation.
      indent-blankline.enable = true;

      # Highlight current line and word.
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
          rnix-lsp.enable = true;
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
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        '';
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
          { name = "path"; }
        ];
        mapping = let 
          select = "{ behavior = cmp.SelectBehavior.Select }";
        in 
        {
          "<C-space>" = "cmp.mapping.complete()";
          "<C-p>"  = "cmp.mapping.select_prev_item(${select})";
          "<C-n>"  = "cmp.mapping.select_next_item(${select})";
          "<cr>"  = "cmp.mapping.confirm({ select = true })";
        };
      };

      null-ls = {
        enable = true;
        sources.formatting = {
          nixfmt.enable = true;
          rustfmt.enable = true;
        };
      };
    };

    extraConfigLua = ''
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

    -- Telescope
    local telescope = require("telescope")
    local file_browser = require("telescope").extensions.file_browser
    local builtin = require("telescope.builtin")

    telescope.setup {
      defaults = {
        file_ignore_patterns = { "node_modules", "yarn.lock", "target/debug", "dist" }
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          theme = "ivy",
          respect_gitignore = false
        }
      }
    }

    telescope.load_extension('file_browser')

    -- Opens it at the current file's path (as it should)
    local browser_opts = {
      path = "%:p:h"
    }

    vim.keymap.set("n", "<leader>pv", function()
    file_browser.file_browser(browser_opts)
    end)

    vim.keymap.set("n", "<leader>px", function()
    vim.cmd("vsplit")
    file_browser.file_browser(browser_opts)
    end)

    vim.keymap.set("n", "<leader>pz", function()
    vim.cmd("split")
    file_browser.file_browser(browser_opts)
    end)

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
    vim.keymap.set("n", "<leader>fo", builtin.vim_options, {})
    vim.keymap.set("n", "<leader>fc", builtin.command_history, {})

    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
    vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})

    vim.keymap.set('n', '<leader>?', builtin.oldfiles)
    vim.keymap.set('n', '<leader>o', builtin.oldfiles)

    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    -- Hop motions
    local hop = require("hop")
    local hint = require("hop.hint")

    local before = hint.HintDirection.BEFORE_CURSOR
    local after = hint.HintDirection.AFTER_CURSOR

    hop.setup {
      case_insensitive = false
    }

    local function set_keymap(motion, action, normal_only)
      normal_only = normal_only or false

      -- Hop sometimes errors from blank lines, so wrapping it with pcall silences that.
      vim.keymap.set("n", motion, function() pcall(action) end)
      if not normal_only then
        vim.keymap.set("v", motion, function() pcall(action) end)
      end
    end

    set_keymap("f", function()
    hop.hint_char1({
      direction = after
    })
    end)

    set_keymap("F", function()
    hop.hint_char1({
      direction = before
    })
    end)

    set_keymap("t", function()
    hop.hint_char1({
      direction = after,
      hint_offset = 1
    })
    end)

    set_keymap("T", function()
    hop.hint_char1({
      direction = before,
    })
    end)

    set_keymap("<leader>w", function()
    hop.hint_words({
      direction = after,
    })
    end)

    set_keymap("<leader>b", function()
    hop.hint_words({
      direction = before,
    })
    end)

    set_keymap("<leader><leader>h", function()
    hop.hint_words({
      current_line_only = true
    })
    end)

    set_keymap("<leader>a", function()
    hop.hint_words()
    end)

    set_keymap("<leader>v", function()
    hop.hint_vertical()
    end)


    set_keymap("<leader>p", function()
    hop.hint_patterns()
    end)
    '';

    extraPlugins = with pkgs.vimPlugins; [ hop-nvim luasnip ];
  };
}
