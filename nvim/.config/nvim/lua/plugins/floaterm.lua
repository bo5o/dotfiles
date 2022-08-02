local M = {}

function M.setup()
  vim.g.floaterm_keymap_toggle = "<leader>ot"
  vim.g.floaterm_keymap_prev = "<F2>"
  vim.g.floaterm_keymap_next = "<F3>"
  vim.g.floaterm_keymap_new = "<leader>oT"
  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8
  vim.g.floaterm_wintitle = 0
  vim.g.floaterm_autoclose = 1
  vim.g.floaterm_opener = "edit"
end

function M.config()
  vim.api.nvim_set_hl(
    0,
    "FloatermBorder",
    { fg = "#ebdbb2", bg = nil, ctermfg = 0, ctermbg = 13 }
  )
end

return M
