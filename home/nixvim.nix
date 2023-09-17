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

      rustfmt_autosave = 1;
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
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>")
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>")
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        '';
      };
      lspsaga = {
        enable = true;
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
          "<C-u>" = "cmp.mapping.scroll_docs( -4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
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

    vim.api.nvim_create_user_command("Q", "q", {})
    vim.api.nvim_create_user_command("W", "w", {})
    vim.api.nvim_create_user_command("WQ", "wq", {})
    vim.api.nvim_create_user_command("Wq", "wq", {})

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

    require("lsp-inlayhints").setup {
    inlay_hints = {
        parameter_hints = {
            prefix = "fn"
        }
    }
}

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
  if not (args.data and args.data.client_id) then
  return
  end

  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

    require("barbecue").setup()
    '';

    extraPlugins = with pkgs.vimPlugins; [ 
      hop-nvim 
      luasnip 
      barbecue-nvim
      lsp-inlayhints-nvim
      rust-vim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "actions-preview.nvim";
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "aznhe21";
          repo = "actions-preview.nvim";
          rev = "5650c76abfb84d6498330dd045657ba630ecdbba";
          sha256 = "09i6fp5kjz2dxhhfznzlrq8gvn204byk4mw23cmxlkc6hnnz4z74";
        };
      })
    ];
  };
}
