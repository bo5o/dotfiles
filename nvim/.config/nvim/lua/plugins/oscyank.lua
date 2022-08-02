local M = {}

function M.config()
  local oscyank = require("osc52")
  vim.keymap.set("n", "<leader>C", oscyank.copy_operator, { expr = true })
  vim.keymap.set("n", "<leader>CC", "<leader>C_", { remap = true })
  vim.keymap.set("x", "<leader>C", oscyank.copy_visual)
end

return M
