local M = {}

function M.setup()
  vim.g.slime_target = "tmux"
  vim.g.slime_python_ipython = 0
  vim.g.slime_bracketed_paste = 1

  -- always send text to the top-right pane in the current tmux tab
  -- without asking
  vim.g.slime_default_config = {
    socket_name = vim.split(os.getenv("TMUX"), ",")[1],
    target_pane = "{bottom-left}",
  }
end

return M
