local M = {}

function M.setup()
  require("lspconfig").bashls.setup({})
end

return M
