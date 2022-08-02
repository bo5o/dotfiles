local M = {}

function M.setup()
  vim.g.ipython_cell_delimit_cells_by = "tags"
end

function M.config()
  local bufopts = { silent = true, buffer = true }
  local map = vim.keymap.set
  map("n", "<c-c><c-f>", "<cmd>IPythonCellRun<cr>", bufopts)
  map("n", "<c-c><c-t>", "<cmd>IPythonCellRunTime<cr>", bufopts)
  map("n", "<c-c><c-x>", "<cmd>IPythonCellExecuteCellVerbose<cr>", bufopts)
  map("n", "<c-c><c-j>", "<cmd>IPythonCellExecuteCellVerboseJump<cr>", bufopts)
  map("n", "<c-c><c-l>", "<cmd>IPythonCellClear<cr>", bufopts)
  map("n", "[C", "<cmd>IPythonCellPrevCell<cr>", bufopts)
  map("n", "]C", "<cmd>IPythonCellNextCell<cr>", bufopts)
end

return M
