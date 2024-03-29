vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })

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
require("toggle_lsp_diagnostics").init()

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.md"},
  callback = function ()
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")
  end
})
