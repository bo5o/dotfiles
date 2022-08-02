local M = {}
function M.setup()
  vim.g["semshi#error_sign"] = false
end

function M.config()
  vim.api.nvim_command([[silent UpdateRemotePlugins]])
end

return M
