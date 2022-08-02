local M = {}

function M.setup()
  vim.g.tmux_session = "popup"
end

function M.config()
  local map = vim.keymap.set
  map("n", "t<cr>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " Enter<cr>")
  map("n", "t<C-c>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-c<cr>")
  map("n", "t<C-d>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-d<cr>")
end

return M
