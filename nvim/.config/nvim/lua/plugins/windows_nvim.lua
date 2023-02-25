local M = {}

function M.config()
  require("windows").setup()
  vim.keymap.set("n", "<C-w>z", "<cmd>WindowsMaximize<cr>")
  vim.keymap.set("n", "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>")
  vim.keymap.set("n", "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>")
  vim.keymap.set("n", "<C-w>=", "<cmd>WindowsEqualize<cr>")
end

return M
