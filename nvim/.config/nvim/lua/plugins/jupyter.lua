local M = {}

function M.setup()
  vim.g.jupyter_mapkeys = 1
end

function M.config()
  local bufopts = { silent = true, buffer = true }
  local map = vim.keymap.set
  map("n", "<localleader>R", "<cmd>JupyterRunFile<cr>", bufopts)
  map("n", "<localleader>I", "<cmd>PythonImportThisFile<cr>", bufopts)
  map("n", "<localleader>X", "<cmd>JupyterSendCell<cr>", bufopts)
  map("n", "<localleader>E", "<cmd>JupyterSendRange<cr>", bufopts)
  map("n", "<localleader>e", "<Plug>JupyterRunTextObj", bufopts)
  map("v", "<localleader>e", "<Plug>JupyterRunVisual", bufopts)
end

return M
