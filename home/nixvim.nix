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

      presence-nvim = {
        enable = true;
        mainImage = "file";
        neovimImageText = "Hacking...";
        buttons = null;
        editingText = "Editing a file";
        readingText = "Reading a file";
        workspaceText = "In a workspace";
        fileExplorerText = "In menu";
        gitCommitText = "About to break git";
      };
    };

    extraConfigLua = ''
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
    '';
  };
}
