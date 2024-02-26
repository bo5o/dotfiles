local M = {}

function M.setup()
  require("lspconfig").eslint.setup({})
end

return M
