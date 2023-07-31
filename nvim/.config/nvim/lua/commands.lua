-- Close all buffer except the current one
vim.api.nvim_create_user_command("BufOnly", [[silent! execute "%bd|e#|bd#"]], {})

-- automatically highlight yanked region
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  group = highlight_yank,
  desc = "Highlight yanked region",
})

local terminal_settings =
  vim.api.nvim_create_augroup("terminal_settings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  group = terminal_settings,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = "Disable line numbers in terminal buffers",
})

local file_type_settings =
  vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "yaml",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "vue",
    "tex",
    "bib",
    "xml",
    "lua",
  },
  group = file_type_settings,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
