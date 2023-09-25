{
  extraConfigLua = ''
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

    vim.api.nvim_create_user_command("Q", "q", {})
    vim.api.nvim_create_user_command("W", "w", {})
    vim.api.nvim_create_user_command("WQ", "wq", {})
    vim.api.nvim_create_user_command("Wq", "wq", {})

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

    local browser_opts = {
      path = "%:p:h" -- Current path instead of project root
    }

    vim.keymap.set("n", "<leader>pp", function()
    file_browser.file_browser(browser_opts)
    end)

    vim.keymap.set("n", "<leader>pv", function()
    vim.cmd("vsplit")
    file_browser.file_browser(browser_opts)
    end)

    vim.keymap.set("n", "<leader>px", function()
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
    vim.keymap.set("n", "<leader>fm", builtin.marks, {})
    vim.keymap.set("n", "<leader>f'", builtin.registers, {})

    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
    vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})

    vim.keymap.set('n', '<leader>?', builtin.oldfiles)
    vim.keymap.set('n', '<leader>o', builtin.oldfiles)

    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local hop = require("hop")
    local hint = require("hop.hint")

    local before = hint.HintDirection.BEFORE_CURSOR
    local after = hint.HintDirection.AFTER_CURSOR

    hop.setup {
      case_insensitive = false
    }

    local function set_keymap(motion, action, normal_only)
    normal_only = normal_only or false

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
          prefix = "f"
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
}
