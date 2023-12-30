{ config, lib, ... }: {
  config = lib.mkIf config.parts.vim.enable {
    programs.nixvim = {
      globals = {
        # Disable NetRw since we're using Telescope.
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
      };
      plugins = {
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
        # For marking and jumping to common files in 2 keystrokes.
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
      };
    };
  };
}
