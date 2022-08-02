local M = {}

function M.config()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
  })

  local lsp_lines = require("lsp_lines")
  lsp_lines.setup()

  vim.keymap.set(
    "n",
    "<leader>ll",
    lsp_lines.toggle,
    { desc = "Show/hide lsp diagnostics" }
  )
end

return M
