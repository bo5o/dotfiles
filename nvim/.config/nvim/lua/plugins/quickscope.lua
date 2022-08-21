local M = {}

function M.setup()
  vim.g.qs_max_chars = 256
  vim.g.qs_buftype_blacklist = { "terminal", "nofile", "startify", "qf", "mason" }
  vim.g.qs_lazy_highlight = 1
end

return M
