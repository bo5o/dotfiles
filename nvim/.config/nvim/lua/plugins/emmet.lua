local M = {}

function M.setup()
  vim.g.user_emmet_install_global = 0
end

function M.config()
  vim.api.nvim_command("EmmetInstall")
end

return M
